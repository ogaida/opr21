#!/usr/bin/env ruby

require 'tempfile'
require "json"

class Opr21

  # set initial credentials if required.... 
  CREDENTIALS={
      :domain => "mydom.1password.eu",
      :email => "myuser@mydom.com",
      :secret => "12-123456-123456-123456-123456-123456-123456"
  }

  attr_reader :expiration_date, :tempfile, :password
  attr_writer :debug

  def initialize(password, hash={})
    @password = password
    @debug = false
    @tempfile = Tempfile.new('op')
    check_creds(hash)
  end

  def op(*args)
    check_creds()
    cmd = %(. #{tempfile.path} ; op "#{args.join('" "')}")
    puts cmd if @debug
    output = `#{cmd}`
    puts output if @debug
    JSON.parse(output)
  end

  # gibt die Werte des ersten Elementes mit entsprechenden Namen
  def getItem(name, fields = "website,username,title,password", vault = "Private")
    all = self.op "list", "items", "--vault", vault
    arr = all.select{|i| i["overview"]["title"] =~ /#{name}/i}
    if arr.class == Array
        self.op "get", "item", arr[0]["uuid"], "--fields", fields
    else
        {}
    end
  end  

  # gibt eine Liste von item.titles aus die matchen
  def getItemList(regex, vault = "Private")
    all = self.op "list", "items", "--vault", vault
    arr = all.select{|i| i["overview"]["title"] =~ /#{regex}/i}
    return_arr = []
    if arr.class == Array
        arr.each do |item|
          return_arr << item["overview"]["title"]
        end
    end
    return_arr
  end  

  def debug= (debug)
    @debug = debug
  end

  private

  def check_creds(hash={})
    hash = CREDENTIALS.update hash
    if system(". #{tempfile.path} ;op get account > /dev/null 2>&1")
        # noch ok
        @expiration_date = Time.at(Time.now.to_i + 30*60)
    else
        # neu einloggen
        system("echo '#{password}' | op signin #{CREDENTIALS[:domain]} #{CREDENTIALS[:email]} #{CREDENTIALS[:secret]} > #{@tempfile.path}")
        puts "session saved in #{tempfile.path}" if @debug
    end
  end

end


# yet another onepassword wrapper in 2021

get your items from 1password in ruby.

# synopsis

```ruby
require "opr21"

unless ENV.has_key?"ONEPASSWORD"
    puts "env-var ONEPASSWORD is missing"
else
    op = Opr21.new(ENV["ONEPASSWORD"], {:domain => "your-domain", :email => "your-email", :secret => "your-secret"})
    opv = op.getItem "your-item-title"
    puts opv["website"]
end
```

with the fuction `getItemList(string, vault)` you can search for your entry. it returns an array of the entry titles.


# installation

just install the gem:

```bash
gem install opr21
```

# external tools / requirements

Download the op commandlinetool for 1password.


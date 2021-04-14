Gem::Specification.new do |spec|
  spec.name = 'opr21'
  spec.version = '0.1.1'
  spec.date = '2021-04-14'
  spec.summary = "yet another onepassword wrapper in 2021"
  spec.description = "get your items from 1password"
  spec.authors = ["Oliver Gaida"]
  spec.email = 'oliver.gaida@mediabeam.com'
  spec.files = `git ls-files`.split($/)
  spec.homepage = 'https://github.com/ogaida/opr21'
  #spec.executables = %w(rusdc)
  spec.add_runtime_dependency 'json', '~> 2.1', '>= 2.1.0'
  spec.license = 'MIT'
end

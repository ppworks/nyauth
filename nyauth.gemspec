$:.push File.expand_path('../lib', __FILE__)
require 'nyauth/version'

Gem::Specification.new do |s|
  s.name        = 'nyauth'
  s.version     = Nyauth::VERSION
  s.authors     = ['ppworks']
  s.email       = ['koshikawa@ppworks.jp']
  s.homepage    = 'https://github.com/ppworks/nyauth'
  s.summary     = 'Simple authentication'
  s.description = 'Simple & modualbe authentication gem'
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency 'responders', '~> 2.0'
  s.add_dependency 'sprockets-rails', '~> 2.2'
end

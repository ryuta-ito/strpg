Gem::Specification.new do |s|
  s.name        = 'strpg'
  s.version     = '0.0.0'
  s.date        = '2016-06-18'
  s.summary     = "strpg"
  s.description = "strict programming system"
  s.authors     = ["ryuta-ito"]
  s.email       = 'ir47389@gmail.com'
  s.files       = Dir["lib/**/*"]
  s.homepage    = 'http://rubygems.org/gems/hola'
  s.license     = 'MIT'
  s.executables = ['strpg', 'thor.rb']
  s.add_runtime_dependency 'color_echo', '3.1.0'
  s.add_runtime_dependency 'thor', '0.19.1'
end

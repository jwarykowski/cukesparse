Gem::Specification.new do |s|
  s.name        = 'cukesparse'
  s.date        = '2013-04-13'
  s.summary     = 'Cukesparse - cucumber command line parser'
  s.description = 'A simple command line parser to pass arguments into Cucumber'
  s.homepage    = 'https://github.com/jonathanchrisp/cukesparse'
  s.version     = '1.0.2'
  s.executables << 'cukesparse'
  s.add_runtime_dependency 'clik'
  s.add_runtime_dependency 'colored'
  s.author      = 'Jonathan Chrisp'
  s.email       = 'jonathan.chrisp@gmail.com'
  s.files       = ['lib/cukesparse.rb']
  s.license     = 'MIT'
  s.test_file   = 'spec/test_cukesparse.rb'
end
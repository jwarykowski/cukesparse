Gem::Specification.new do |s|
  s.name        = 'cukesparse'
  s.date        = '2013-04-16'
  s.summary     = 'Cukesparse - cucumber command line parser'
  s.description = 'A simple command line parser to pass arguments into Cucumber'
  s.homepage    = 'https://github.com/jonathanchrisp/cukesparse'
  s.version     = '1.0.5'
  s.required_ruby_version = ">= 1.9.2"
  s.executables << 'cukesparse'

  s.add_development_dependency 'rspec', '~> 2.13.0'
  s.add_development_dependency 'rake', '~> 10.0.4'

  s.add_runtime_dependency 'clik', '~> 0.1.0'
  s.add_runtime_dependency 'colored', '~> 1.2'
  s.add_runtime_dependency 'cucumber', '~> 1.2.5'

  s.author      = 'Jonathan Chrisp'
  s.email       = 'jonathan.chrisp@gmail.com'
  s.files       = ['lib/cukesparse.rb']
  s.license     = 'MIT'
  s.test_file   = 'spec/cukesparse_spec.rb'
end
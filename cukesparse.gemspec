Gem::Specification.new do |s|
  s.name        = 'cukesparse'
  s.version     = '1.0.9'
  s.date        = '2013-05-31'
  s.summary     = 'Cukesparse - cucumber command line parser'
  s.description = 'A simple command line parser to pass arguments into Cucumber'
  s.author      = 'Jonathan Chrisp'
  s.email       = 'jonathan.chrisp@gmail.com'
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/jonathanchrisp/cukesparse'
  s.required_ruby_version = ">= 1.9.2"

  s.add_development_dependency 'rspec', '~> 2.13.0'
  s.add_development_dependency 'rake', '~> 10.0.4'

  s.add_runtime_dependency 'clik', '~> 0.1.0'
  s.add_runtime_dependency 'colored', '~> 1.2'
  s.add_runtime_dependency 'cucumber', '~> 1.3.1'

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
end
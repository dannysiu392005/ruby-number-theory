Gem::Specification.new do |s|

  s.name         = 'number-theory'
  s.version      = '1.0.0'
  s.summary      = "A Ruby Number Theory Library"
  s.description  = "A number theory library written in pure Ruby. Provides methods for primality test, factoring integers, and more."
  
 	s.authors      = ['Alberto Donizetti', 'Danny Siu']
  s.email        = 'dannysiu392005@gmail.com'
  
  s.files        = Dir['lib/**/*.rb'] + Dir['test/**/*.rb']
  s.platform     = Gem::Platform::RUBY
  s.license      = 'GNU GPL 3'

	s.require_path = "lib"
	s.test_files   = Dir['test/**/*.rb']
	s.add_dependency("narray", [">=0.6"])

  s.homepage     = 'https://github.com/dannysiu392005/ruby-number-theory'

end
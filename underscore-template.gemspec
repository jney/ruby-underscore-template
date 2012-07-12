Gem::Specification.new do |s|
  s.name = "underscore-template"
  s.version = "0.0.1"
  s.summary = "UnderscoreTemplate template compiler"
  s.description = "Compile and evaluate underscore templates from Ruby."

  s.files = Dir["README.md", "LICENSE", "lib/**/*.rb"]

  s.add_dependency 'sprockets', '~> 2.1.3'
  s.add_development_dependency "execjs", "~> 0.4"

  s.authors = ["Jean-Sébastien Ney"]
  s.email = ["jeansebastien.ney@gmail.com"]
  s.homepage = "https://github.com/jney/ruby-underscore-template/"
end

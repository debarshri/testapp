Gem::Specification.new do |gem|
  gem.name    = "app"
  gem.version = "1.0"

  gem.authors     = "Debarshi Basak"
  gem.email       = "steve.richert@gmail.com"
  gem.description = "Ad arbritrar server"
  gem.summary     = gem.description
  gem.homepage    = "https://github.com/debarshri/testapp"

  gem.add_development_dependency "bundler", "~> 1.0"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(/^spec\//)
  gem.require_paths = ["app"]
end
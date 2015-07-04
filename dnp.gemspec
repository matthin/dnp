require "./lib/dnp/version"

Gem::Specification.new do |spec|
  spec.name          = "dnp"
  spec.version       = Dnp::VERSION
  spec.authors       = ["Justin Harrison"]
  spec.email         = ["justin@matthin.com"]
  spec.summary       = "Just a very dumb network protocol example."
  spec.homepage      = "https://github.com/matthin/dnp"
  spec.license       = "MIT"
  spec.require_paths = ["lib"]
  spec.add_development_dependency("rake", "~> 10.4")
  spec.add_development_dependency("rspec", "~> 3.3")
  spec.add_development_dependency("yard", "~> 0.8.7")
end


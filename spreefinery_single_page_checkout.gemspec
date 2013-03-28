# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'spreefinery_single_page_checkout'
  s.version = '1.3.2'
  s.summary = 'Single Page Checkout for Spreefinery Engine'
  s.description = ' Single Page Checkout for Spreefinery Engine'
  s.required_ruby_version = '>= 1.9.3'

  # s.author    = 'You'
  # s.email     = 'you@example.com'
  s.authors = ["Alexander Negoda"]
  s.email = ["alexander.negoda@gmail.com"]
  s.homepage = 'https://github.com/shoponrails/spreefinery_single_page_checkout'

  s.files = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spreefinery_core'
  #s.add_dependency 'spreefinery_last_address'

  s.add_development_dependency 'capybara', '~> 1.1.2'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails', '~> 2.9'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'sqlite3'
end

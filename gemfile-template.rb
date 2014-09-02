
gem 'foundation-rails'
gem 'bcrypt', '~> 3.1.7'

gem_group :development, :test do
  gem "rspec-rails"
  gem 'factory_girl_rails'
end

gem_group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'hirb'
  gem 'rails-footnotes', '>= 4.0.0', '<5' 
end

gem_group :test do
  gem 'capybara'
  gem 'faker'
end

gem_group :production do
  gem 'rails_12factor'
end

run "bundle install"

run "rails generate rails_footnotes:install"
run "rails generate rspec:install"

insert_into_file '.gitignore', "\n/config/database.yml\n/config/secrets.yml",
  after: "/tmp\n"

git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }

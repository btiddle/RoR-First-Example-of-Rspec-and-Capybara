=====================================================
Title:    140829-pm-adam-CS-400-04-ruby-tdd-rspec-capybara-UserLoginTesting
App Name: tdd-app
Task:     First example of Rspec and Capybara
=====================================================

===============
Template File
===============
# Copy template file
copy gemfile-template.rb

===============
Create Project
===============
# Create project 
#   -m, [--template=TEMPLATE]  # Path to application template
#   -T, [--skip-test-unit]     # Skip Test::Unit files
rails new tdd-app -T -m gemfile-template.rb

===============
CD Directory
===============
# Change to sub-directory
cd tdd-app

===============
Gem File
===============
# Verify all needed gems are installed 
gem query --local

===============
Configure Rspec
===============
# Add capybara/rspec (edit /spec/rails_helper.rb)

<<<<<<< ORIGINAL
require 'rspec/rails'
=======
require 'rspec/rails'
require 'capybara/rspec'
>>>>>>> CHANGES

<<<<<<< ORIGINAL
  config.infer_spec_type_from_file_location!
end
=======
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
 end
>>>>>>> CHANGES

===============
Create Controllers
===============
# Default RESTful Routing Controllers
# rails g controller <ControllerName> index new create show edit update destroy 

# Controllers needed for this project
rails g controller Users index new show

===============
Create Models
===============
# Create models/tables using "rails generate model", "rake db:create", and "rake db:migrate"
# Type defaults to string not specified.
rails g model User name email address
OR
rails g model User name:string email:string address:string

===============
Update Factory
===============
# Setup factory (edit /spec/factories/users.rb)
<<<<<<< ORIGINAL
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    email "MyString"
    address "MyString"
  end
end
=======
# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name  }
    email { Faker::Internet.email }
    address { Faker::Address.street_address }
  end
end
>>>>>>> CHANGES

===============
Create database
===============
# Create db and apply updates
rake db:create
rake db:migrate
rake db:test:prepare

===============
Setup Routes (edit /config/routes.rb)
===============
<<<<<<< ORIGINAL
  get 'users/index'
  get 'users/new'
  get 'users/show'
=======
  resources :users
  root 'users#index'
>>>>>>> CHANGES

rake routes

===============
Apply edits to controller (app/controllers/users_controller.rb)
===============
<<<<<<< ORIGINAL
class UsersController < ApplicationController
  def index
  end

  def new
  end

  def show
  end
end
=======
class UsersController < ApplicationController

  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else

    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :address)
    end

end
>>>>>>> CHANGES

===============
Apply edits to model (/app/models/user.rb)
===============
<<<<<<< ORIGINAL
class User < ActiveRecord::Base
end
=======
class User < ActiveRecord::Base
  validates :name, :email, :address, presence: true

  def user_details
    "#{self.email} #{self.address}"
  end
end
>>>>>>> CHANGES

===============
Apply edits to index view (/app/views/users/index.html.erb)
===============
<<<<<<< ORIGINAL
<h1>Users#index</h1>
<p>Find me in app/views/users/index.html.erb</p>
=======
<h1>Welcome</h1>
<%= link_to "Create a user", new_user_path %>
>>>>>>> CHANGES


===============
Apply edits to new view (/app/views/users/new.html.erb)
===============
<<<<<<< ORIGINAL
<h1>Users#new</h1>
<p>Find me in app/views/users/new.html.erb</p>
=======
<%= form_for(@user) do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>

  <%= f.label :email %>
  <%= f.text_field :email %>

  <%= f.label :address %>
  <%= f.text_field :address %>

  <%= f.submit "Create user" %>
<% end %>
>>>>>>> CHANGES

===============
Apply edits to new show (/app/views/users/new.html.erb)
===============
<<<<<<< ORIGINAL
<h1>Users#show</h1>
<p>Find me in app/views/users/show.html.erb</p>
=======
<h1>Name: <%= @user.name %></h1>
Email: <%= @user.email %>
<br>
Address: <%= @user.address %>
>>>>>>> CHANGES

===============
Create feature test file (/spec/features/creating_users_spec.rb)
===============
require 'rails_helper'

feature "Create user" do
  scenario "can create a user" do
    visit root_path
    expect(page).to have_content("Welcome")
    click_link "Create a user"
    expect(page.current_url).to eql(new_user_url)
    fill_in "Name", with: "Whatever"
    fill_in "Email", with: "Something@email.com"
    fill_in "Address", with: "ADDRESSSS"

    # select "Option"
    # check "Box"

    click_button "Create user"
    expect(User.count).to eq 1
    expect(page.current_url).to eql(user_url(User.first))
    expect(page).to have_content(User.first.name)

  end

  scenario "failure case" do
    # i.e. failing to accept terms of serivce
    # make sure they get redirected back to where they should, et cetera
  end
end

===============
Apply edits to spec model file (/spec/models/user_spec.rb)
===============
<<<<<<< ORIGINAL
require 'rails_helper'

RSpec.describe User, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
=======
require 'rails_helper'

RSpec.describe User, :type => :model do

  subject(:user) { FactoryGirl.create(:user) }

  it "has a valid factory" do
    expect(user).to be_valid
  end

  describe "validations" do

    [:name, :email, :address].each do |attr|
      it "is invalid without a #{attr}" do
        expect(FactoryGirl.build(:user, attr => nil)).to_not be_valid
      end
    end
  end

  describe "User#user_details" do
    it 'should concatenate the user email and address' do
      expect(user.user_details).to eq("#{user.email} #{user.address}")
    end
  end
end
>>>>>>> CHANGES

===============
Run the tests
===============
# Can specify start of tests anywhere along the path. For example:
# rspec spec
# rspec spec/features
# rspec spec/features/creating_users_spec.rb

rspec spec/features/creating_users_spec.rb
rspec spec/models/user_spec.rb

===============
Issues
===============
1. Getting a ton of stack trace messages.
2. The title of passing tests is not showing. Only numerical
   total of passing tests is showing.

===============
To-do
===============
1. Stubs of automatically added tests need to be filled in.
2. Add more validation and then add more tests.
3. Fix failing tests.
4. Index page should be changed to show all records.
5. Add formatting (Bootstrap or Foundation).





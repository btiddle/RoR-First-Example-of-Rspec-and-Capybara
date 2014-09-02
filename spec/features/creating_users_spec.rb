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
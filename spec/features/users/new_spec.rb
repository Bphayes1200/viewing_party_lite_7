require 'rails_helper'

RSpec.describe "'/register'", type: :feature do
  describe "When I visit the register page" do
    before :each do
      visit "/register"
    end

    it "Should have a form to register a new user" do

      expect(page).to have_content("Viewing Party")
      expect(page).to have_content("Register a New User")
      expect(page).to have_field(:name)
      expect(page).to have_field(:email)
      expect(page).to have_field(:password)
      expect(page).to have_field(:password_confirmation)
      expect(page).to have_button("Create New User")
      fill_in :name, with: "David"
      fill_in :email, with: "David@example.com"
      fill_in :password, with: "Password!"
      fill_in :password_confirmation, with: "Password!"
      click_button("Create New User")

      expect(current_path).to eq("/users/#{User.last.id}")
      expect(page).to have_content("David's Dashboard")
    end

    it "doesn't create a new user if name is missing" do
      fill_in :email, with: "John@example.com"

      click_button("Create New User")
    end

    it "doesn't create a new user if email has already been used" do
      User.create(name: "Bob", email: "bob123@example.com")

      fill_in :name, with: "John"
      fill_in :email, with: "bob123@example.com" 

      click_button("Create New User")
    end

    it "doesn't create a new user if passwords are not matching" do 
      fill_in :name, with: "John"
      fill_in :email, with: "bob123@example.com" 
      fill_in :password, with: "123"
      fill_in :password_confirmation, with: "234"

      click_button("Create New User")

      expect(page).to have_content( "Password confirmation doesn't match Password")
    end
  end
end
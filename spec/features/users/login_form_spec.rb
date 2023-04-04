require "rails_helper"

RSpec.describe "Login Form" do 
  before :each do 
    @user = create(:user)
    visit "/login"
  end 
  it "will have fields to fill out and a button to click" do 
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
  end

  it "will log a user in and take them to their dashboard" do 
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    
    click_on "Log In"

    expect(current_path).to eq("/users/#{@user.id}")
  end

  it "will fail to log in if credientials are not met" do 
    fill_in :email, with: @user.email
    fill_in :password, with: "HI"

    click_on "Log In"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end
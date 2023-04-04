require 'rails_helper'

RSpec.describe 'landing page' do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)

    movie_response = File.read('spec/fixtures/movie.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/238?api_key=#{ENV['MOVIE_DB_KEY']}")
      .to_return(status: 200, body: movie_response)
    shawshank_response = File.read('spec/fixtures/shawshank.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/278?api_key=#{ENV['MOVIE_DB_KEY']}")
      .to_return(status: 200, body: shawshank_response)

    @movie_1 = Movie.new(JSON.parse(movie_response, symbolize_names: true))
    @movie_2 = Movie.new(JSON.parse(shawshank_response, symbolize_names: true))

    @party1 = ViewingParty.create!(duration: 120, host_id: @user2.id, party_date: '2021-03-20', party_time: '12:00:00', movie_id: @movie_1.id)
    @party2 = ViewingParty.create!(duration: 60, host_id: @user2.id, party_date: '2021-04-20', party_time: '09:00:00', movie_id: @movie_2.id)

    @user_party1 = UserParty.create!(user_id: @user1.id, viewing_party_id: @party1.id)



    visit '/'
  end

  it 'displays the title of the application' do
    expect(page).to have_content("Welcome to Viewing Party!")
  end

  it 'displays a button to create a new user' do
    expect(page).to have_button("Register New User")

    click_button "Register New User"
    expect(current_path).to eq("/register")
  end

  it 'has a link to go back to the landing page' do
    expect(page).to have_link("Home")

    click_link "Home"
    
    expect(current_path).to eq("/")
  end

  it "has a link to login" do 
    expect(page).to have_button("Login")

    click_button "Login"

    expect(current_path).to eq("/login")
  end

  it "has logged a user in and will now have a link to log out" do 
    click_button "Login"

    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
    
    click_on "Log In"

    visit "/"

    expect(page).to have_button("Log Out")
    expect(page).to_not have_button("Login")
   
    click_button "Log Out"

    expect(page).to have_button("Login")
  end

  it "a visitor will not be shown a list of existing users" do 
    expect(page).to_not have_content(@user1.name)
    expect(page).to_not have_content(@user2.name)
  end
end
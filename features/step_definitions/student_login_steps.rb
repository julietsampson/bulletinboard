Given /^a valid user$/ do
  @user = User.create!({
             :name => "User User",
             :uni => "ab1234",
             :password => "pass",
             :password_confirmation => "pass"
           })
end

feature "logged in as a student" do
  
  scenario "Signing in with correct credentials" do
    page.visit "/sessions/new"
    page.fill_in "name", :with => "User User"
    page.fill_in "uni", :with => "ab1234"
    page.fill_in "password", :with => "pass"
    page.click_button "Login"
    page.should have_content("Welcome, ab1234!")
  end

  scenario "User tries to sign in with incorrect password" do
    page.visit "/sessions/new"
    page.fill_in "name", :with => "User User"
    page.fill_in "uni", :with => "ab1234"
    page.fill_in "password", :with => "bla"
    page.click_button "Login"
    page.should have_content("Invalid credentials")
  end
  
end
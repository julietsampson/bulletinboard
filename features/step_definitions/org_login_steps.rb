Given /^a valid user$/ do
  @user = User.create!({
             :name => "User",
             :email => "ab@columbia.edu",
             :password => "pass",
             :password_confirmation => "pass"
           })
end

feature "logged in as a student" do
  
  scenario "Signing in with correct credentials" do
    page.visit "/sessions/new"
    page.fill_in "name", :with => "User"
    page.fill_in "email", :with => "ab@columbia.edu"
    page.fill_in "password", :with => "pass"
    page.click_button "Login"
    page.should have_content("Welcome, User!")
  end

  scenario "User tries to sign in with incorrect password" do
    page.visit "/sessions/new"
    page.fill_in "name", :with => "User"
    page.fill_in "email", :with => "ab@columbia.edu"
    page.fill_in "password", :with => "bla"
    page.click_button "Login"
    page.should have_content("Invalid credentials")
  end
  
end
# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    @organization = Organizer.find_by(:name => "CucumberTestUser")
    @student = Student.find_by(:name => "CucumberTestStudent")
    case page_name

    when /start page/ then '/'
    when /student sign in page/ then '/student_login_page?'
    when /organizer sign in page/ then '/organizer_login_page?'
    when /event page/ then '/events?'
    when /^(org events )?page\s?for\s?\"(.*)"$/ then '/org_events?organizer_id=' + Organizer.find_by(:name => ($2)).id.to_s
    when /event creation page/ then '/events/new'
    when /^the (edit )?page\s?for\s?\"(.*)"$/ then '/events/' + @organization.events.find_by(:name => ($2)).id.to_s + '/edit'
    when /^the (info )?page\s?for\s?\"(.*)"$/ then '/events/' + @organization.events.find_by(:name => ($2)).id.to_s
    # when /info page/ then '/events/'+@organization.events.find_by(:name => 'pumpkin carving').id.to_s
    when /^the (about )?page\s?for\s?\"(.*)"$/ then '/about_event/'+Event.find_by(:name => ($2)).id.to_s
    when /my event list page/ then '/my_events'

    when /my profile page/ then '/student_profile?'
    when /my schedule page/ then '/show_schedule'
    when /edit schedule page/ then '/edit_schedule'
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)

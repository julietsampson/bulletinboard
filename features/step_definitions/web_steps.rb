# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file was generated by Cucumber-Rails and is only here to get you a head start
# These step definitions are thin wrappers around the Capybara/Webrat API that lets you
# visit pages, interact with widgets and make assertions about page content.
#
# If you use these step definitions as basis for your features you will quickly end up
# with features that are:
#
# * Hard to maintain
# * Verbose to read
#
# A much better approach is to write your own higher level step definitions, following
# the advice in the following blog posts:
#
# * http://benmabey.com/2008/05/19/imperative-vs-declarative-scenarios-in-user-stories.html
# * http://dannorth.net/2011/01/31/whose-domain-is-it-anyway/
# * http://elabs.se/blog/15-you-re-cuking-it-wrong
#


require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |step, parent|
  with_scope(parent) { When step }
end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |step, parent, table_or_string|
  with_scope(parent) { When "#{step}:", table_or_string }
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end


When /^(?:|I )go to (.+)$/ do |page_name|
    visit path_to(page_name)
end

Then /^(?:|I )should go to (.+)$/ do |page_name|
    
    visit path_to(page_name)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )fill in '([^"]*)' with '([^"]*)'$/ do |field, value|
  fill_in(field, :with => value, match: :prefer_exact)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

# When(/^I select the datetime (\d+)\ (.*?)\ (\d+) - (\d+):(\d+) as "(.*?)"$/) do |year, month, day, hour, minute, label_text|
#   label = page.find('label', text: label_text)
#   id = label[:from]
#   select year,   from: "#{id}_1i"
#   select month,  from: "#{id}_2i"
#   select day,    from: "#{id}_3i"
#   select hour,   from: "#{id}_4i"
#   select minute, from: "#{id}_5i"
# end
# When(/^I select the datetime "([^"]*)" as "([^"]*)"$/) do |date, label_text|
#   label = page.find('label', text: label_text)
#   field = label[:from]
#   select date.strftime("%Y"),  from: "#{field}_1i" # Year.
#   select date.strftime("%B"),  from: "#{field}_2i" # Month.
#   select date.strftime("%-d"), from: "#{field}_3i" # Day.
#   select date.strftime("%H"),  from: "#{field}_4i" # Hour.
#   select date.strftime("%M"),  from: "#{field}_5i" # Minutesend
# end
When /^(?:|I )select datetime "([^ ]*) ([^ ]*) ([^ ]*) - ([^:]*):([^"]*)" as the "([^"]*)"$/ do |year, month, day, hour, minute, field|
    select year.strftime("%Y"),  from: "#{field}_1i" # Year.
    select month.strftime("%B"),  from: "#{field}_2i" # Month.
    select date.strftime("%-d"), from: "#{field}_3i" # Day.
    select date.strftime("%H"),  from: "#{field}_4i" # Hour.
    select date.strftime("%M"),  from: "#{field}_5i" # Minutesend
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select or option
# based on naming conventions.
#
When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:|I )check (?:the\s+)?"([^"]*)"(?:\s*checkbox)?$/ do |field|
  check(field)
end

When /^(?:|I )uncheck (?:the\s+)?"([^"]*)"(?:\s*checkbox)?$/ do |field|
  uncheck(field)
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field)
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  attach_file(field, File.expand_path(path))
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  assert page.has_xpath?('//*', :text => regexp)
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
    expect(page).not_to have_content(text)
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  assert page.has_no_xpath?('//*', :text => regexp)
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    assert_match(/#{value}/, field_value)
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    assert_no_match(/#{value}/, field_value)
  end
end

Then /^the "([^"]*)" field should have the error "([^"]*)"$/ do |field, error_message|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')

  form_for_input = element.find(:xpath, 'ancestor::form[1]')
  using_formtastic = form_for_input[:class].include?('formtastic')
  error_class = using_formtastic ? 'error' : 'field_with_errors'

  assert classes.include?(error_class)

  if using_formtastic
    error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
    assert error_paragraph.has_content?(error_message)
  else
    assert page.has_content?("#{field.titlecase} #{error_message}")
  end
end

Then /^the "([^"]*)" field should have no error$/ do |field|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')
  assert !classes.include?('field_with_errors')
  assert !classes.include?('error')
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    assert field_checked
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    assert !field_checked
  end
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  assert_equal path_to(page_name), current_path
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}

  assert_equal expected_params, actual_params
end

Then /^show me the page$/ do
  save_and_open_page
end

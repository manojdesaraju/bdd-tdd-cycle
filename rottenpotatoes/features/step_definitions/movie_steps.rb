Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
  Movie.create!(movie)
  end
end

Given /^I am on the details page for "(.*?)"$/ do |name|
  m= Movie.find_by_title(name)
  visit '/movies/'+m.id.to_s
end

When /^I follow "(.*?)"$/ do |link|
  click_link(link)
end

Then /^I should be on the home page$/ do
  uri = URI.parse(current_url)
  "#{uri.path}".should eq '/movies'
  expect(page).to have_content('All Movies')
end

Then /^I should see "'(.+)' has no director info"/ do |name|
  expect(page).to have_content('\''+name+'\' has no director info')
end

Then  /^I should be on the Similar Movies page for "(.*?)"/ do |name|
  expect(page).to have_content(name)
end

Then /^I should see "([^'].+)"$/ do |name|
  expect(page).to have_content(name)
end

Then /^I should not see "(.*?)"$/ do |name|
  expect(page).to have_no_content(name)
end

When /^I go to the edit page for "(.*?)"$/ do |name|
  m= Movie.find_by_title(name)
  visit '/movies/'+m.id.to_s+'/edit'
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I press "Update Movie Info"$/ do
  click_on("Update Movie Info") 
end

Then /^the director of "(.*?)" should be "(.*?)"$/ do |title, director|
  movie = Movie.find_by_title(title)
  assert movie.director == director, "#{title} director is #{movie.director} and it should be #{director}"
end

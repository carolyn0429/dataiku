# Dataiku test
# Author: Carolyn Hung
# created at : April 01, 2018
require 'rspec'
require 'cucumber'

When (/^I am a non-authenticated user$/) do
  @client = TestClient.new
  puts "[INFO]: Initialize an test client..."
end

And (/^I send POST request to endpoint to create a new user with username (.*) and password (.*)$/) do |username, password|
  @client = TestClient.new
  @response = @client.create_a_user(username, password)
  puts "[INFO]: Create a new user..."
end

When (/^I log in as an authenticated user with username (.*) and password (.*)$/) do |username, password|
  @client = TestClient.new
  @client.set_credentials(username, password)
  puts "[INFO]: Initialize an test client with authorization..."
end

When (/^I authenticate a user with username (.*) and password (.*)$/) do |username, password|
  @client = TestClient.new
  @response = @client.generate_token(username, password)
  puts "[INFO]: Authenticate a user with username #{username}..."
end

And (/^I send POST request to endpoint to create a task with title (.*) and tags (.*)$/) do |title, tags|
  tags = tags.split(",")
  puts tags
  @response = @client.create_a_task(title, tags)
end

And (/^I send PUT request with username (.*) and password (.*)$/) do |username, password|
  @client = TestClient.new
  @response = @client.generate_token(username, password)

  puts "[INFO]: Creating authorization and generating token..."
end

And (/^I should get an authorization token generated$/) do
  @response = JSON.parse(@response.body)
  @token = @response["token"]
  puts "Token: #{@token.to_s}"
end

And (/^I send GET request to endpoint to get tasks$/) do
  @response = @client.get_tasks
  print @response
end

And (/^I should get a task with id (.*)$/) do |task_id|
  @response = JSON.parse(@response.body)
  @response["id"] == task_id
end

And (/^I send GET request to endpoint to get tags/) do
  @response = @client.get_tags
  print @response
end

Then (/^I should get (.*) OK response$/) do |response_code|
  response_code == @response.code.to_s
end

And (/^I should get a list of existing tasks$/) do
  @response = JSON.parse(@response.body)
  @response.should_not nil
end

And (/^I should get a list of existing tags$/) do
  @response = JSON.parse(@response.body)
  @response.should_not nil
end

And (/^I should get a tag with id (.*)$/) do |tag_id|
  @response = JSON.parse(@response.body)
  @response["id"].should_not nil
  @response["id"] == tag_id
end

And (/^I send GET request to endpoint to get a tag with id (.*)$/) do |tag_id|
  @response = @client.get_tag_by_id(tag_id)
  print @response
end

And (/^I send GET request to endpoint to get a task with id (.*)$/) do |task_id|
  @task_id = task_id
  @response = @client.get_task_by_id(task_id)
  print @response
end

Then (/^I send PATCH request update title to (.*) and tags to (.*)$/) do |title, tags|
  tags = tags.split(",")
  puts tags
  @response = @client.update_task_by_id(@task_id, title, tags)
  print @response
end

And (/^I send GET request to endpoint to reset a database to initial state$/) do
  @response = @client.reset
  print @response
end
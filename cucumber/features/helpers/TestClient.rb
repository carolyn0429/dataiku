require 'rubygems'
require 'selenium-webdriver'
require 'cucumber'
require 'rest-client'

class TestClient
  @@URL = "http://hung.qatest.dataiku.com/"
  @@username = nil
  @@password = nil

  def create_a_user(username, password)
    response = RestClient::Request.execute(
        :method => :post,
        :url => @@URL+"users",
        :headers => {:accept => :json, :content_type=> :json},
        payload: {'username': username, 'password': password}.to_json
    )
    return response
  end

  def generate_token(username, password)
    response = RestClient::Request.execute(
        :method => :post,
        :url => @@URL+"authenticate",
        :headers => {:accept => :json, :content_type=> :json},
        payload: {'username': username, 'password': password}.to_json
    )
    return response
  end

  def set_credentials(username, password)
    @@username = username
    @@password = password
  end

  def create_a_task(title, tags)
    response = RestClient::Request.execute(
        :method => :put,
        :url => @@URL,
        :headers => {:accept => :json, :content_type=> :json},
        :user => @@username,
        :password => @@password,
        payload: {'title': title, 'tags': tags}.to_json
    )
    return response
  end

  def get_tasks()
    response = RestClient.get(@@URL)
    return response
  end

  def get_tags()
    response = RestClient.get(@@URL+"tags")
    return response
  end

  def get_task_by_id(task_id)
    response = RestClient.get(@@URL+task_id)
    return response
  end

  def get_tag_by_id(tag_id)
    response = RestClient.get(@@URL+"tags/"+tag_id)
    return response
  end

  def reset()
    response = RestClient.get(@@URL+"reset")
    return response
  end

  def update_task_by_id(task_id, title, tags)
    response = RestClient::Request.execute(
        :method => :patch,
        :url => @@URL+task_id,
        :headers => {:accept => :json, :content_type=> :json},
        :user => @@username,
        :password => @@password,
        payload: {'title': title, 'tags': tags}.to_json
    )
    return response
  end

  def delete_task_by_id(task_id)
    response = RestClient.delete(@@URL+task_id)
    return response
  end

  def self.find_element(finder, location)
    $driver.find_element(finder, location)
  end

end
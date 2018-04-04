# Dataiku test
# Author: Carolyn Hung
# created at : April 01, 2018


Feature: testing get api calls

  Scenario: reset a database to initial state
    When I am a non-authenticated user
    And I send GET request to endpoint to reset a database to initial state
    Then I should get 200 OK response

  Scenario: create a user
    When I am a non-authenticated user
    And I send POST request to endpoint to create a new user with username carolyn and password hung
    Then I should get 200 OK response

  Scenario Outline: authenticate users
    When I am a non-authenticated user
    And I send PUT request with username <username> and password <password>
    Then I should get 200 OK response
    And I should get an authorization token generated
    Examples:
      | username | password |
      | QA      | willWin  |
      | carolyn | hung |

    ## different users cannot add same task into todo list
  Scenario Outline: create a task for users
    When I log in as an authenticated user with username <username> and password <password>
    And I send POST request to endpoint to create a task with title clean bedroom and tags saturday, clean, spring
    Then I should get 200 OK response
    Examples:
    | username | password |
    | carolyn | hung |
    | QA      | willWin |


  Scenario: create more tasks
    When I log in as an authenticated user with username QA and password willWin
    And I send POST request to endpoint to create a task with title grocery shopping and tags sunday, meal prep
    Then I should get 200 OK response
    And I send POST request to endpoint to create a task with title writing journal and tags morning, mental, self
    Then I should get 200 OK response

  Scenario: get a list of existing tasks
    When I am a non-authenticated user
    And I send GET request to endpoint to get tasks
    Then I should get 200 OK response
    And I should get a list of existing tasks

  Scenario: get a list of existing tags
    When I am a non-authenticated user
    And I send GET request to endpoint to get tags
    Then I should get 200 OK response
    And I should get a list of existing tags

  Scenario: get a tag by id
    When I am a non-authenticated user
    And I send GET request to endpoint to get a tag with id 2
    Then I should get 200 OK response
    And I should get a tag with id 2

  Scenario: get a task by id
    When I am a non-authenticated user
    And I send GET request to endpoint to get a task with id 3
    Then I should get 200 OK response
    And I should get a task with id 3

  Scenario: update a task title and tags by id
    When I log in as an authenticated user with username QA and password willWin
    And I send PUT request with username QA and password willWin
    Then I should get 200 OK response
    And I should get an authorization token generated
    Then I send GET request to endpoint to get a task with id 2
    And I should get 200 OK response
    Then I send PATCH request update title to paint living room and tags to saturday, paint, family
    And I should get 200 OK response



#Feature: test search functionality on webpage
#  Scenario Outline: verify <attribute> displayed on the page
#    When I open the webpage from browser
#    Then I should see <attribute> displayed
#    Examples:
#    | attribute |
#    | search box |
#    | search button |
#
#  Scenario Outline: verify search results should display on the page
#    When I open the webpage from browser
#    And I should see search box displayed
#    Then I type <keyword> in search box
#    And I should see displayed results contain <keyword> of search
#    Examples:
#    | keyword |
#    | relayr |
#    | internet of things |
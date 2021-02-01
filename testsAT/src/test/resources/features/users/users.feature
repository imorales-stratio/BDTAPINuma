@rest
Feature: Users API

  Background:
    Given I send requests to 'localhost:3004'

  Scenario: Get all users
    When I send a 'GET' request to '/users'
    Then the service response status must be '200' and its response length must be '50'

  Scenario: Add new user
    When I create file 'user.json' based on 'files/empty.json' as 'json' with:
      | $.firstName | ADD | Ivan                 | string |
      | $.lastName  | ADD | Morales              | string |
      | $.email     | ADD | imorales@stratio.com | string |
      | $.country   | ADD | ESP                  | string |
    When I send a 'POST' request to '/users' based on 'user.json' as 'json'
    Then the service response status must be '201'
    And I save element '$.id' in environment variable 'userId'

  Scenario: Get all users
    When I send a 'GET' request to '/users'
    Then the service response status must be '200' and its response length must be '51'

  Scenario: Get user
    When I send a 'GET' request to '/users/!{userId}'
    Then the service response status must be '200'
    When I save element '$' in environment variable 'userResponse'
    Then 'userResponse' matches the following cases:
      | $.id        | equal | !{userId}            |
      | $.firstName | equal | Ivan                 |
      | $.lastName  | equal | Morales              |
      | $.email     | equal | imorales@stratio.com |
      | $.country   | equal | ESP                  |

  Scenario: Update user
    When I create file 'user.json' based on 'user.json' as 'json' with:
      | $.firstName | REPLACE | Test             | string |
      | $.lastName  | REPLACE | Numa             | string |
      | $.email     | REPLACE | numa@stratio.com | string |
    When I send a 'PUT' request to '/users/!{userId}' based on 'user.json' as 'json'
    Then the service response status must be '200'

  Scenario: Get user
    When I send a 'GET' request to '/users/!{userId}'
    Then the service response status must be '200'
    When I save element '$' in environment variable 'userResponse'
    Then 'userResponse' matches the following cases:
      | $.id        | equal | !{userId}        |
      | $.firstName | equal | Test             |
      | $.lastName  | equal | Numa             |
      | $.email     | equal | numa@stratio.com |
      | $.country   | equal | ESP              |

  Scenario: Delete user
    When I send a 'DELETE' request to '/users/!{userId}'
    Then the service response status must be '200'

  Scenario: Delete user (get 404 error)
    When I send a 'DELETE' request to '/users/!{userId}'
    Then the service response status must be '404'
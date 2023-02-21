
Feature: Articles

Background: Define URL
    Given url 'https://api.realworld.io/api/'
    Given path 'users/login'
    And request { "user": {"email": "Karate@mail.com", "password": "Abc@12345"} }
    # So in karate you can paste the JSON directly, but you have to inline this json otherwise it will not recognize this object right now.
    When method Post
    Then status 200
    # In karate, to define variables we can use * def and then name of variable.
    * def token = response.user.token 
    # Now we have defined variable that will keep our value for the next call.
    
@ignore
Scenario: Create a new article

    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request { "article": { "tagList": [], "title": "Hello Mi Amor2a", "description": "Hola Amigo", "body": "6721" } }
    When method Post
    Then status 200
    And match response.article.title == 'Hello Mi Amor2a'

@debug
Scenario: Create and delete article

    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request { "article": { "tagList": [], "title": "Delete Article", "description": "Hola Amigo", "body": "6721" } }
    When method Post
    Then status 200
    * def articleId = response.article.slug

    # Given params {limit: 10, offset: 0}
    Given path 'articles', articleId
    When method Get
    Then status 200
    # And match response.articles[0].title == 'Delete Article'

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And print 'response.articles[0] is - ', response.articles[0]
    # And match response.articles[0].title == 'Delete Article'

    Given header Authorization = 'Token ' + token
    Given path 'articles', articleId
    When method Delete
    Then status 204

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != 'Delete Article'

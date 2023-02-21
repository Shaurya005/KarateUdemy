
Feature: Articles

# Background is executed everytime when we run a scenario. It's kind of BeforeEach method. So if we have multiple scenarios in this feature then for all it'll run for every scenario and CreateToken will also be executed everytime as well but that's not we want. We can reuse the token again and again. And for that we can use callonce instead of call. 
# So during the first scenario, these feature will be called and valy will be saved in the token response. And then when we call second time another scenario, Garraty will read cash value and will not make a call to the token feature.
Background: Define URL
    Given url apiUrl
    # Given path 'users/login'
    # And request { "user": {"email": "Karate@mail.com", "password": "Abc@12345"} }
    # # So in karate you can paste the JSON directly, but you have to inline this json otherwise it will not recognize this object right now.
    # When method Post
    # Then status 200
    # # In karate, to define variables we can use * def and then name of variable.
    # * def token = response.user.token 
    # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
    # # This token variable tokenResponse is an object which will hold all variables that were defined in CreateToken.feature
    # * def token = tokenResponse.authToken
    
@ignore
Scenario: Create a new article

    # Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request { "article": { "tagList": [], "title": "Hello Mi Amor2a", "description": "Hola Amigo", "body": "6721" } }
    When method Post
    Then status 200
    And match response.article.title == 'Hello Mi Amor2a'

@debug
Scenario: Create and delete article

    # Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request { "article": { "tagList": [], "title": "Deletefnnf Article", "description": "Hola Amigo", "body": "6721" } }
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

    # Given header Authorization = 'Token ' + token
    Given path 'articles', articleId
    When method Delete
    Then status 204

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != 'Delete Article'

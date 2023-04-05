# Each feature file always starts with a keyword feature and you provide the description.
# @debug
Feature: Tests for the home page

# We have a duplication, actually, so we have test number 1 and test number 2, we have defined the same exact URL. 
# So let's put this URL into BeforeEach method and we will define this url for every test we're running in this feature file. 
# Before Each method defined in the feature file as a Background keyword.

Background: Define URL
    Given url apiUrl

    @dibba @skipme
    Scenario: Get all tags
        # Given url 'https://api.realworld.io/api/'
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['introduction', 'et']
        And match response.tags contains any ['fish', 'dog', 'et']
        # And match response.tags !contains any ['fish', 'dog']
        And match response.tags !contains 'et1'
        # And match response.tags contains only []
        And match response.tags == "#array"
        And match each response.tags == "#string"
    
    @article
    Scenario: Get 10 articles from the page
        * def timeValidator = read('classpath:helpers/time-validator.js')

        #Given url 'https://conduit.productionready.io/api/articles?limit=10&offset=0'// But the approach of putting the parameters inside of the URL, it's actually not a good thing. You have to separate your parameters from your URL.
        # Given param limit = 10
        # Given param limit = 0
        # Because we have two parameters, we can actually provide object with parameters and use it just with one line how to do it like that.
        Given params {limit: 10, offset: 0}
        # Given url 'https://api.realworld.io/api/'
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 219
        And match response.articlesCount != 500
        And match response == {"articles": "#array", "articlesCount": 219}
        And match response.articles[0].createdAt contains '2023'
        And match response.articles[*].favoritesCount contains 0
        And match response.articles[*].author.bio contains null
        And match response..bio contains null
        And match each response..following == false
        And match each response..following == '#boolean'
        And match each response..favoritesCount == '#number'
        And match each response..bio == '##string'
        And match each response.articles == 
        """
            {
                "slug": "#string",
                "title": "#string",
                "description": "#string",
                "body": "#string",
                "tagList": "#array",
                "createdAt":  "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "favorited": "#boolean",
                "favoritesCount": "#number",
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": "#boolean"
                }
            }
        """
    
    @condition
    Scenario: Conditional Logic

        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        * def favoritesCount = response.articles[0].favoritesCount
        * def article = response.articles[0]

        # * if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)
        * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favoritesCount

        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].favoritesCount == result

    @retry
    Scenario: Retry call
        * configure retry = { count: 10, interval: 5000}
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        And retry until response.articles[0].favoritesCount == 1
        When method Get
        Then status 200

    @sleep
    Scenario: Sleep call
        * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        * eval sleep(10000)
        Then status 200

    @type
    Scenario: Number to String
        * def foo = 10
        * def json = {"bar" : #(foo+'')}
        * match json == {"bar" :'10'}

        # String to Number
        * def foo = '10'
        * def json = {"bar" : #(foo*1)}
        * def json2 = {"bar" : #(~~parseInt(foo))}
        * match json == {"bar" : 10}
        * match json2 == {"bar" : 10}


        # So we want to get this biography and match each response = string, but that would be if we expecting a string there for sure, but if we use a double hash sign,
        # it means that acceptable value be null or string, also double hash sign means that bio key is optional.
        # For example, if our response will not have the bio key, the assertion will not fail as well. This is how a double hash sign works.


    # And also a big difference between Path and url. When you define the URL, it will be valid all the time during the execution of the scenario.
    # For example, if after one request, in the same scenario, you will try to make the second request, the url will be defined as previous one.
    # The lifetime of the path is only during the test. So once you make that call to the path, it expires right after the call. So that's the difference.
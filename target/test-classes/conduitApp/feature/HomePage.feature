# Each feature file always starts with a keyword feature and you provide the description.
#@debug
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
        And match response.tags !contains 'et1'
        And match response.tags == "#array"
        And match each response.tags == "#string"
    
    @article
    Scenario: Get 10 articles from the page
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
        And match response.articlesCount == 197


# And also a big difference between Path and url. When you define the URL, it will be valid all the time during the execution of the scenario.
# For example, if after one request, in the same scenario, you will try to make the second request, the url will be defined as previous one.
# The lifetime of the path is only during the test. So once you make that call to the path, it expires right after the call. So that's the difference.
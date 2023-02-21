Feature: Create Token

Scenario: Create Token
    Given url 'https://api.realworld.io/api/'
    Given path 'users/login'
    And request { "user": {"email": "#(email)", "password": "#(password)"} }
    When method Post
    Then status 200
    * def authToken = response.user.token

    # And one more thing, I want to pay attention how we organized our folders, as I mentioned before, all features that we want to run within our regression suite, like when we run command mvn test.
    # All these files should be located in the same directory as our runner, which is this ConduitTest.java.
    # But all other features that we don't want to run within the same test suite we want to locate outside of the folder where the Runner is located ?
    # In our example, we created a separate folder. So this CreateToken feature will be only called by other feature and will not be executed as an independent feature.

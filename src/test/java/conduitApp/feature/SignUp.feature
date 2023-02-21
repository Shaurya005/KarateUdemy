# @ignore
Feature: Sign Up new user

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    Given url apiUrl

# @debug
Scenario: New user Sign Up
    # Given def userData = { "email": "Karate2@mail.com", "username": "Karate232" }

    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()
    * def jsFunction = 
    """
        function() {
            var DataGenerator = Java.type('helpers.DataGenerator')
            var generator = new DataGenerator();
            return generator.getRandomUsername2()
        }
    """

    * def randomUsername2 = call jsFunction

    Given path 'users'
    # And request { "user": { "email": #('Test'+userData.email), "password": "Abc2@123456", "username": #('User'+userData.username) } }
    And request
    """
        {
            "user": {
                "email": #(randomEmail),
                "password": "Abc2@123456",
                "username": #(randomUsername2)
            }
        }
    """
    When method Post
    Then status 200
    And match response == 
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "username": #(randomUsername2),
                    "bio": null,
                    "image": "#string",
                    "token": "#string"
                }
            }
        """

    # When do you have a scenario when you need to run the same feature again and again? But just the difference is the test data that you need to run.

    # You can use a structure scenario outlined and in this scenario outline you provide this examples section,
    # provide as many columns as you want for your headers, and then you use this column or this headers

    # inside of your body like this using angle braces and the same syntax for verification of the error response.
    # For more examples on how to use data driven features, you can look right in documentation here.
    # @debug
    Scenario Outline: Validate Sign Up error messages
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

        Given path 'users'
        And request
        """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:  
                        | email          | password | username | errorResponse |
                        | #(randomEmail) | Karate123 | Karate123564 | {"errors":{"username":["has already been taken"]}} |
                        | Karate@mail.com | Karate123 | #(randomUsername) | {"errors":{"email":["has already been taken"]}} |


    # So currently our scenario outline will be executed twice. First it will run random email Karata and we'll verify that username has already been taken.                            
    # Then we will use a random user name from our data generator, but will provide the email that already exist and we should see the error message for email has already been taken.


@hooks
Feature: Hooks

# So before hook, we know it from the previous lesson is configured easily with Background section, so all code that you will put into background section will be executed before every scenario.
# So, for example, let's make a call of our dummy feature that I have created. This dummy feature is doing nothing but returning our getRandomUsername here, username variable. Let's call this feature inside of our background hook.
    
    Background: hooks
        # * def result = call read('classpath:helpers/Dummy.feature')
        # * def username = result.username

        # So as you see both username had a unique value because this call, read feature was executed every time in the background.
        # So how to do if we want to run just before all scenarios? So it means execute some code just once.

        # And we already did this with a token. But just a reminder, instead of call, you have to use callonce keyword and then call your feature.
        # So when you use keyword callonce, karate will remember the value for this result object and for the next scenario, it also will be executed again.
        # But Karate will use the cached value from the previous scenario. So in the console we will see the same username twice in the log.
        
        # So when you use call, it's the equivalent of before each when you use callonce equivalent of before feature. And another example, if you want to run some code before the entire test suite, before all features,
        # you can configure this in karate-config.js by using callSingle method here. We already using this for the token.
        # But just a reminder, if you need to run any kind of code before all scenarios, before all features to create some precondition for your entire test run, you can use callSingle keyword. 
        # If you will use karate.call instead of a callSingle, createToken feature in this example will be used for every scenario. So this is how it works now.

        # Now how to use after hooks like after scenario or after feature. Karate has a special syntaxes for that.
        # And you have to use keyword configure, then use a keyword let's say afterFeature and then you need to call a JavaScript function with the code that you want to be executed after feature.

        # So you use function() and then if we want to run the same Dummy.feature, we have to use karate.call and provide a path to our Dummy.feature.
        # So that way we will see the username will be printed into the console after feature was executed. So this example is after feature.
        # So we will run scenario one, then we run scenario two, feature will be completed and afterFeature function will be called and this function will call our Dummy.feature 
        # so Dummy.feature will generate a username and this user name will be printed to the console.
        
        #after hooks
        # * configure afterFeature = function(){ karate.call('classpath:helpers/Dummy.feature') }
        * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature') }

        # If we will replace this afterFeature to afterScenario, this call will be executed after every scenario. Something like this, so let's look into this and here this is the first scenario. 
        # This is after scenario username. This is another scenario. And we see unique after scenario was printed every time, as you see, our ofter scenario function worked just fine.
        * configure afterFeature =
        """
            function(){
                karate.log('After Feature Text');
            }
        """


        # So as you see, this is a call of JavaScript function inline. If you want to call a JavaScript function like in the block, if you want to call not just feature but you want to write your some custom JavaScript 
        # code that have to be executed at the end of every scenario or at the end of every feature, you can do something like above using javascript function inside embedded expression.

    Scenario: First scenario
        # * print username
        * print 'This is first scenario'

    Scenario: Second Scenario
        # * print username
        * print 'This is second scenario'


        # Let's quickly summarize if you want to make before or before each hook, you use a background method and provide your feature or, a file that you want to call using call or callonce. 
        # If you want to call some code before all test like BeforeAll hook, you can use karate-config.js and use command - Karata.callSingle. For the aftee feature, you should use configure 
        # command and afterScenario or afterFeature parameter and you have to provide the JavaScript function that you want to be called in this after hook.

        # If you write inline JavaScript function you can use the syntax like first one. If your function is bigger and it require a few lines, you can use embedded expression and run your JavaScript function like above.

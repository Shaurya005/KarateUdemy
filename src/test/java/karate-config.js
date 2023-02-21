function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'Karate@mail.com'
    config.userPassword = 'Abc@12345'
  } else if (env == 'qa') {
    config.userEmail = 'Karate2@mail.com'
    config.userPassword = 'Abc2@12345'
  }

  // If you look in our articles feature, you may notice that we copy paste a bunch of times header. So we copy pasted that header thing 3 times and also we are calling create token feature on background.
  // But imagine that we might have a different feature files that it also required token. So we will need to copy paste the two lines from background method of Articles.feature into background method 
  // of other feature files and then use header similar like we did there. This is also not the best thing because we can use the same token for the entire suite, for all our feature files and all the 
  // tests in our example, so we can create this token just once before running all tests and then assign this header as a global header for the entire test run. And we can do it also inside of the karate-config.js.
  
  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config;
  
  // Environment variables are certain variables that are global for the framework, and you can use them across the entire framework and reuse them.
  // For example, we have currently 3 feature files - HomePage, Articles and CreateToken, and in all 3 files we pretty much copy pasting url to run our tests.
  // But if, for example, you need to run your tests in different environment, for example, in dev environment or qa environment, so you will need to go and change this url in all three files.
  // So this is not very convenient or you have a multiple login accounts. For example, one email account can be used for one environment, another account for another one, and you have to go and change that across the features.
  // So you want to have one place where you will manage all these kind of variables in Karate, this place is this file karate-config.js. So this file is a JavaScript file created to manage environment variables.

  // So let's go through this file and quickly review it one by one, line by line.
  // So in the very beginning, this var karate environment variable is just you're getting that environment variable if it was passed during the execution of the command, then we just print to the console.
  // So you will see in the console later in the logs, what environment did you use and then you define environment in if block. If no environment was provided then our default environment will be development environment.
  // Then we have these config object and this config object you can use to save here some default environment variables or environment variables that are reusable across the environment.
  // And in the last if section you can configure what variables for which environment, variables to use. And then we return a config object that is visible for every feature file. And all values of this feature file are visible.
}
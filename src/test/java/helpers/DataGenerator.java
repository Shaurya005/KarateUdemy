package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator {
    
    public static String getRandomEmail() 
    {
        Faker faker = new Faker();

        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";

        return email;
    }

    public static String getRandomUsername() 
    {
        Faker faker = new Faker();

        String username = faker.name().username();

        return username;
    }
    
    public String getRandomUsername2() 
    {
        Faker faker = new Faker();

        String username = faker.name().username();

        return username;
    }

    public static JSONObject getRandomArticleValues() 
    {
        Faker faker = new Faker();

        // Inside of our awesome fakre library, I found a nice method called Game of Thrones and this Game of Thrones return different strings for us, such as character, city and for our body, We will use a quote from this movie.
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();

        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);

        return json;
    }
}

package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.junit5.Karate;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class ConduitTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:conduitApp") // So I want to point out that the path for the classpath starts from folder Java.
        // So source/test/java and then beginning of our path, the first folder in our path is conduitApp.
                //.outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    // Let's quickly summarize what we discussed in this lesson. So if you want to set up the thread count for the parallel execution, you can easily set this value here in the Karate Runner.
    // But please make sure that you are not overloading your system and not stressing your system so your test are fast enough.
    // If you want to avoid a certain parallel execution for the scenarios or the scenarios outline, you can use the flag @parallel=false and karate will not run this particular feature or scenario outline in parallel.

    // @Karate.Test
    // Karate tesTags() {
    //     return Karate.run().relativeTo(getClass());
    // }

    // @Karate.Test
    // Karate testTags() {
    //     return Karate.run().tags("@debug").relativeTo(getClass());
    // }

}

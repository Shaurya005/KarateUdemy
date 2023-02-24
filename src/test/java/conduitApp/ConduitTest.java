package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.junit5.Karate;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

class ConduitTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:conduitApp") // So I want to point out that the path for the classpath starts from folder Java.
        // So source/test/java and then beginning of our path, the first folder in our path is conduitApp.
                .outputCucumberJson(true)
                .parallel(5);
                generateReport(results.getReportDir());
                assertTrue(results.getFailCount() == 0, results.getErrorMessages());
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

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "conduitApp");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

}

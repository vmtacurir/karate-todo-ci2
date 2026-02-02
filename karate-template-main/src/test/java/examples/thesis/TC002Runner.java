package examples.thesis;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class TC002Runner {
    
    @Test
    void testTC002() {
        Results results = Runner.path("classpath:examples/thesis/TC-API-002-get-by-id.feature")
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

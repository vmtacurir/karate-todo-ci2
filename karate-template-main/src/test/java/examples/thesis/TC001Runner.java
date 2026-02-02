package examples.thesis;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class TC001Runner {
    
    @Test
    void testTC001() {
        Results results = Runner.path("classpath:examples/thesis/TC-API-001-create-and-verify-persistence.feature")
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

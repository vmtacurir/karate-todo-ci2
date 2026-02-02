package examples.thesis;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class TC011Runner {
    
    @Test
    void testTC011() {
        Results results = Runner.path("classpath:examples/thesis/TC-API-011-multiple-tasks-data-driven.feature")
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

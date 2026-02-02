package examples.thesis;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class TC004Runner {
    
    @Test
    void testTC004() {
        Results results = Runner.path("classpath:examples/thesis/TC-API-004-update-status.feature")
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

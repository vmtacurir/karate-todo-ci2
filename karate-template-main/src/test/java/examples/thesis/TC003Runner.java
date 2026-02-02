package examples.thesis;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class TC003Runner {
    
    @Test
    void testTC003() {
        Results results = Runner.path("classpath:examples/thesis/TC-API-003-list-all-todos.feature")
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

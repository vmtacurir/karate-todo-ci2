package examples.thesis;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class ThesisRunner {
    
    @Test
    void testAllThesisSequential() {
        Results results = Runner.path("classpath:examples/thesis")
                .parallel(1); // Ejecuta uno por uno
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

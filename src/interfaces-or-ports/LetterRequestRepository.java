// PORT (P1): the core logic saves and finds requests only through this interface.
// Adapter: DbLetterRequestRepository (JPA, outside the core).
import java.util.Optional;

public interface LetterRequestRepository {
    void save(LetterRequest request);
    Optional<LetterRequest> findById(String id);
}

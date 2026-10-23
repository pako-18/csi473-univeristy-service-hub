// PORT (P4, ADR-002): saved "email to send" notes, written in the same transaction as the letter.
// Adapter: DbEmailOutbox.
import java.util.Optional;

public interface EmailOutbox {
    void queue(String letterId, String studentEmail);
    Optional<String> nextPending();
    void markSent(String id);
    void markFailed(String id);
}

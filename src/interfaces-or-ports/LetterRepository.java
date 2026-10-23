// PORT (P1): letters and verification codes (FR-13, FR-14, UC-07).
// Adapter: DbLetterRepository.
import java.util.Optional;

public interface LetterRepository {
    void save(Letter letter);
    Optional<Letter> findByCode(String code);
}

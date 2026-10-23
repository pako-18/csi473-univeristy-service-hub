$d = "src\interfaces-or-ports"
New-Item $d -ItemType Directory -Force | Out-Null

@'
// Placeholder domain types so the ports compile.
// Real fields come from models/domain-model.mmd and must be kept in sync with it.
record LetterRequest(String id, String studentId, String status, String reason) {}
record Letter(String id, String requestId, String verificationCode, java.time.LocalDate issuedOn) {}
record StudentRecord(String studentId, String programmeCode) {}
record Programme(String code, int requiredCredits) {}
record CompletionResult(boolean eligible, java.util.List<String> outstandingItems) {}
record RuleResult(boolean met, String detail) {}
record VerificationResult(boolean valid, java.time.LocalDate issuedOn) {}
'@ | Set-Content "$d\DomainTypes.java" -Encoding ascii

@'
// PORT (P1): the core logic saves and finds requests only through this interface.
// Adapter: DbLetterRequestRepository (JPA, outside the core).
import java.util.Optional;

public interface LetterRequestRepository {
    void save(LetterRequest request);
    Optional<LetterRequest> findById(String id);
}
'@ | Set-Content "$d\LetterRequestRepository.java" -Encoding ascii

@'
// PORT (P1): letters and verification codes (FR-13, FR-14, UC-07).
// Adapter: DbLetterRepository.
import java.util.Optional;

public interface LetterRepository {
    void save(Letter letter);
    Optional<Letter> findByCode(String code);
}
'@ | Set-Content "$d\LetterRepository.java" -Encoding ascii

@'
// PORT (P2): the only door to student academic records (FR-02, UC-03).
// Adapter: RecordsSystemAdapter (test data in the prototype, replaceable later).
public interface StudentRecordsGateway {
    StudentRecord getRecord(String studentId);
    Programme getProgramme(String studentId);
}
'@ | Set-Content "$d\StudentRecordsGateway.java" -Encoding ascii

@'
// PORT (P3): turns a Letter into PDF bytes (FR-11, UC-06).
// Adapter: PdfLetterRenderer (PDF library lives only in the adapter).
public interface LetterRenderer {
    byte[] render(Letter letter, StudentRecord record);
}
'@ | Set-Content "$d\LetterRenderer.java" -Encoding ascii

@'
// PORT (P4): sends the letter email (FR-12).
// Used by EmailRetryWorker, not directly by LetterIssuanceService (see ADR-002).
// Adapter: EmailSender.
public interface NotificationSender {
    void sendLetter(String studentEmail, byte[] pdfBytes);
}
'@ | Set-Content "$d\NotificationSender.java" -Encoding ascii

@'
// PORT (P4, ADR-002): saved "email to send" notes, written in the same transaction as the letter.
// Adapter: DbEmailOutbox.
import java.util.Optional;

public interface EmailOutbox {
    void queue(String letterId, String studentEmail);
    Optional<String> nextPending();
    void markSent(String id);
    void markFailed(String id);
}
'@ | Set-Content "$d\EmailOutbox.java" -Encoding ascii

@'
// PORT (P4): append-only audit trail (FR-15). Adapter: DbAuditLog.
public interface AuditLog {
    void record(String actor, String action);
}
'@ | Set-Content "$d\AuditLog.java" -Encoding ascii

@'
// PORT (P5, Strategy): one class per eligibility check (FR-04 to FR-06).
// Implementations: CreditsRule, CompulsoryModulesRule, ElectiveCreditsRule.
public interface EligibilityRule {
    RuleResult evaluate(StudentRecord record, Programme programme);
}
'@ | Set-Content "$d\EligibilityRule.java" -Encoding ascii

@'
// Core class (P5): runs every EligibilityRule and collects what is outstanding (FR-07, FR-08).
// Depends only on the EligibilityRule interface.
import java.util.ArrayList;
import java.util.List;

public class CompletionChecker {
    private final List<EligibilityRule> rules;

    public CompletionChecker(List<EligibilityRule> rules) {
        this.rules = rules;
    }

    public CompletionResult check(StudentRecord record, Programme programme) {
        List<String> outstanding = new ArrayList<>();
        for (EligibilityRule rule : rules) {
            RuleResult result = rule.evaluate(record, programme);
            if (!result.met()) {
                outstanding.add(result.detail());
            }
        }
        return new CompletionResult(outstanding.isEmpty(), outstanding);
    }
}
'@ | Set-Content "$d\CompletionChecker.java" -Encoding ascii

@'
// Core application service. Every dependency is an interface (port) passed in
// through the constructor, so no concrete adapter is created here.
public class LetterIssuanceService {
    private final LetterRequestRepository requests;
    private final LetterRepository letters;
    private final StudentRecordsGateway records;
    private final CompletionChecker checker;
    private final LetterRenderer renderer;
    private final EmailOutbox outbox;
    private final AuditLog audit;

    public LetterIssuanceService(LetterRequestRepository requests,
                                 LetterRepository letters,
                                 StudentRecordsGateway records,
                                 CompletionChecker checker,
                                 LetterRenderer renderer,
                                 EmailOutbox outbox,
                                 AuditLog audit) {
        this.requests = requests;
        this.letters = letters;
        this.records = records;
        this.checker = checker;
        this.renderer = renderer;
        this.outbox = outbox;
        this.audit = audit;
    }

    // UC-02 step 1: student submits a request.
    public LetterRequest requestLetter(String studentId) {
        throw new UnsupportedOperationException("TODO");
    }

    // UC-02 / UC-03 / UC-06: the Registry Officer's check passes, so the letter is issued automatically.
    public Letter verifyAndIssue(String requestId, String officerId) {
        // 1. load the request (requests.findById)
        // 2. get record and programme (records.getRecord / getProgramme)
        // 3. run the check (checker.check)
        // 4. not eligible: save the reason, audit it, stop
        // 5. eligible: create Letter with a unique code, save it (letters.save)
        // 6. render the PDF (renderer.render) and queue the email (outbox.queue)
        // 7. audit the issuing (audit.record)
        throw new UnsupportedOperationException("TODO");
    }
}
'@ | Set-Content "$d\LetterIssuanceService.java" -Encoding ascii

dir $d
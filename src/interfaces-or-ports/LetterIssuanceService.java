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

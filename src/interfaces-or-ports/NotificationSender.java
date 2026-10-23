// PORT (P4): sends the letter email (FR-12).
// Used by EmailRetryWorker, not directly by LetterIssuanceService (see ADR-002).
// Adapter: EmailSender.
public interface NotificationSender {
    void sendLetter(String studentEmail, byte[] pdfBytes);
}

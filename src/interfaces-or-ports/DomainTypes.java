// Placeholder domain types so the ports compile.
// Real fields come from models/domain-model.mmd and must be kept in sync with it.
record LetterRequest(String id, String studentId, String status, String reason) {}
record Letter(String id, String requestId, String verificationCode, java.time.LocalDate issuedOn) {}
record StudentRecord(String studentId, String programmeCode) {}
record Programme(String code, int requiredCredits) {}
record CompletionResult(boolean eligible, java.util.List<String> outstandingItems) {}
record RuleResult(boolean met, String detail) {}
record VerificationResult(boolean valid, java.time.LocalDate issuedOn) {}

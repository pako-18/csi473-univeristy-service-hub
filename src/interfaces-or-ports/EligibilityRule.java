// PORT (P5, Strategy): one class per eligibility check (FR-04 to FR-06).
// Implementations: CreditsRule, CompulsoryModulesRule, ElectiveCreditsRule.
public interface EligibilityRule {
    RuleResult evaluate(StudentRecord record, Programme programme);
}

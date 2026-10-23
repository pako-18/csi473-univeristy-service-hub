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

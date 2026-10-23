// PORT (P4): append-only audit trail (FR-15). Adapter: DbAuditLog.
public interface AuditLog {
    void record(String actor, String action);
}

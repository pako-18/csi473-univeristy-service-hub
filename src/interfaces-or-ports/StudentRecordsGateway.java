// PORT (P2): the only door to student academic records (FR-02, UC-03).
// Adapter: RecordsSystemAdapter (test data in the prototype, replaceable later).
public interface StudentRecordsGateway {
    StudentRecord getRecord(String studentId);
    Programme getProgramme(String studentId);
}

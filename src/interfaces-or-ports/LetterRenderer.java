// PORT (P3): turns a Letter into PDF bytes (FR-11, UC-06).
// Adapter: PdfLetterRenderer (PDF library lives only in the adapter).
public interface LetterRenderer {
    byte[] render(Letter letter, StudentRecord record);
}

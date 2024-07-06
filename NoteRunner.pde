class NoteRunner {
  private int justFrame;
  private Note note;
  private Ring ring;
  private NoteJudge noteJudge;
  private JudgeDisplay judgeDisplay;

  public NoteRunner(PVector coordinate, int justFrame) {
    this.justFrame = justFrame;
    note = new Note(coordinate);
    ring = new Ring(note, justFrame);
    noteJudge = new NoteJudge(note, justFrame);
    judgeDisplay = new JudgeDisplay(note);
  }

  public void run() {
    note.run();
    ring.run();
    judgeDisplay.run(noteJudge.run());
  }
}

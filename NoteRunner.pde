class NoteRunner {
  private Note note;
  private Ring ring;
  private NoteJudge noteJudge;
  private JudgeDisplay judgeDisplay;
  private int index;

  public NoteRunner(PVector coordinate, int index) {
    note = new Note(coordinate);
    ring = new Ring(note);
    noteJudge = new NoteJudge(note);
    judgeDisplay = new JudgeDisplay(note);
    this.index = index;
  }

  public void run() {
    note.run();
    ring.run(index);
    noteJudge.run();
    judgeDisplay.run();
  }
  
  
}

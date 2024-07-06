class NoteRunner {
  final private int JUST_FRAME;
  final private int FINISH_FRAME;
  final private int TEXT_FINISH_FRAME;
  private Note note;
  private Ring ring;
  private NoteJudge noteJudge;
  private JudgeDisplay judgeDisplay;

  public NoteRunner(PVector coordinate, int justFrame) {
    JUST_FRAME = justFrame;
    FINISH_FRAME = ROOP_FRAME/2+BAD_FRAME;
    note = new Note(coordinate);
    ring = new Ring(note, JUST_FRAME);
    noteJudge = new NoteJudge(note, JUST_FRAME);
    judgeDisplay = new JudgeDisplay(note);
    TEXT_FINISH_FRAME = ROOP_FRAME/2+BAD_FRAME+judgeDisplay.getDisplayDurationFrame();
  }

  public void run() {
    note.run();
    ring.run();
    judgeDisplay.run(noteJudge.run());
    
    if (roopingFrameCount == FINISH_FRAME) {
      killNote();
      killRing();
    }
    if (roopingFrameCount == TEXT_FINISH_FRAME) {
      killNoteJudge();
      killJudgeDisplay();
    }
  }
  
  private void killNote()         { note = null; }
  private void killRing()         { ring = null; }
  private void killNoteJudge()    { noteJudge = null; }
  private void killJudgeDisplay() { judgeDisplay = null; }
}

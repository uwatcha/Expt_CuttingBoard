class NoteRunner {
  final private int SHOW_FRAME;
  final private int JUST_FRAME;
  final private int HIDE_FRAME;
  final private int KILL_FRAME;
  private Note note;
  private Line line;
  private NoteJudge noteJudge;
  private JudgeOutput judgeOutput;

  public NoteRunner(PVector coordinate, int showFrame, int justFrame) {
    SHOW_FRAME = showFrame;
    JUST_FRAME = justFrame;
    HIDE_FRAME = JUST_FRAME + BAD_FRAME;
    KILL_FRAME = HIDE_FRAME + JUDGE_DISPLAY_DURATION;
    
    note = new Note(coordinate);
    line = new Line(note, SHOW_FRAME, JUST_FRAME);
    noteJudge = new NoteJudge(note, JUST_FRAME);
    judgeOutput = new JudgeOutput(note);
  }

  public void run() {
    if (SHOW_FRAME <= frame&&frame <= KILL_FRAME) {
      if (line!=null) { line.run(); }
      if (note!=null) { note.run(); }
      Judgment judge = null;
      if (noteJudge!=null) {
        judge = noteJudge.run();
      }
      if (judgeOutput!=null) {
        judgeOutput.run(judge);
      }
    
      if (frame == HIDE_FRAME) {
        killNote();
        killLine();
        killNoteJudge();
      }
      if (frame == KILL_FRAME) {
        killJudgeOutput();
      }
    }
  }
  
  private void killNote() {
    note.killField();
    note = null;
  }
  private void killLine() {
    line = null;
  }
  private void killNoteJudge() {
    noteJudge.killField();
    noteJudge = null;
  }
  private void killJudgeOutput() {
    judgeOutput.killField();
    judgeOutput = null;
  }
  
  public int getShowFrame() { return SHOW_FRAME; }
  public int getKillFrame() { return KILL_FRAME; }
}

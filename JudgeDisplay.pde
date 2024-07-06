class JudgeDisplay {
  final String GOOD_TEXT = "GOOD!!";
  final String NICE_TEXT = "NICE!";
  final String BAD_TEXT = "BAD...";
  final int    DISPLAY_DURATION_FRAME = 30;
  final float  OFFSET = 200;
  PVector coordinate;
  int startFrame;
  Note note;
  Judgment judgment;

  JudgeDisplay(Note note) {
    this.note = note;
    coordinate = new PVector(note.getCoordinate().x + OFFSET, note.getCoordinate().y - OFFSET);
    startFrame = -1;
  }

  public void run(Judgment judgment) {
    setJudgment(judgment);
    display();
    reset();
  }

  private void setJudgment(Judgment judgment) {
    if (judgment != null) {
      startFrame = roopingFrameCount;
      this.judgment = judgment;
    }
  }
  
  private void display() {
    if (judgment==null) { return; }
    
    switch (judgment) {
    case Good:
      judgmentText(GOOD_TEXT);
      break;
    case Nice:
      judgmentText(NICE_TEXT);
      break;
    case Bad:
      judgmentText(BAD_TEXT);
      break;
    }
  }

  private void reset() {
    if (judgment!=null && (roopingFrameCount-startFrame) >= DISPLAY_DURATION_FRAME) {
      startFrame = -1;
      judgment = null;
    }
  }
  
  private void judgmentText(String text) {
    textDisplay(text, coordinate, JUDGE_DISPLAY, WHITE);
  }
  
  private int getDisplayDurationFrame() { return DISPLAY_DURATION_FRAME; }
}

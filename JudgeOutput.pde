class JudgeOutput {
  final private String GOOD_TEXT = "GOOD!!";
  final private String NICE_TEXT = "NICE!";
  final private String BAD_TEXT = "BAD...";
  final private float  OFFSET = 200;
  private PVector coordinate;
  private int startFrame;
  private Judgment judgment;

  JudgeOutput(PApplet parent, Note note) {
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
      startFrame = frame;
      this.judgment = judgment;
    }
  }
  
  private void display() {
    if (judgment==null) { return; }
    
    switch (judgment) {
    case Good:
      judgmentText(GOOD_TEXT);
      //soundEffect.playGood();
      break;
    case Nice:
      judgmentText(NICE_TEXT);
      break;
    case Bad:
      judgmentText(BAD_TEXT);
      //soundEffect.playBad();
      break;
    }
  }

  private void reset() {
    if (judgment!=null && (frame-startFrame) >= JUDGE_DISPLAY_DURATION) {
      startFrame = -1;
      judgment = null;
    }
  }
  
  private void judgmentText(String text) {
    textDisplay(text, coordinate, JUDGE_DISPLAY, WHITE);
  }  
}

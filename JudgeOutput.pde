class JudgeOutput {
  final private String GOOD_TEXT = "GOOD!!";
  final private String NICE_TEXT = "NICE!";
  final private String BAD_TEXT = "BAD...";
  final private float  OFFSET = 200;
  private PVector coordinate;
  private int startFrame;
  private Judgment judgment;
  private SoundEffect soundEffect;

  JudgeOutput(Note note) {
    coordinate = new PVector(note.getCoordinate().x + OFFSET, note.getCoordinate().y - OFFSET);
    startFrame = -1;
    soundEffect = new SoundEffect();
  }

  public void run(Judgment judgment) {
    setJudgment(judgment);
    display();
    reset();
  }
  
  public void killField() {
    coordinate = null;
    judgment = null;
    soundEffect = null;
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
      soundEffect.playGood();
      //playGoodSE();
      break;
    case Nice:
      judgmentText(NICE_TEXT);
      soundEffect.playNice();
      //playNiceSE();
      break;
    case Bad:
      judgmentText(BAD_TEXT);
      soundEffect.playBad();
      //playBadSE();
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

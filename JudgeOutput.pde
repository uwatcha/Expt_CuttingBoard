class JudgeOutput {
  final private String GOOD_TEXT = "GOOD!!";
  final private String NICE_TEXT = "NICE!";
  final private String BAD_TEXT = "BAD...";
  final int JUDGE_TEXT_SIZE = 70;
  final private PVector COORD = new PVector(width-250, 400);
  private PImage image;
  private String text;
  private int startFrame;
  private Judgment judgment;
  private boolean soundEffectHasPlayed;

  JudgeOutput() {
    text = "";
    startFrame = -1;
    soundEffectHasPlayed = false;
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
    if (image!=null) {
      image(image, COORD.x, COORD.y);
    }
    displayText(text, COORD.x, COORD.y-250, JUDGE_TEXT_SIZE, BLACK);
    if (judgment==null) { return; }
    
    switch (judgment) {
    case Good:
      image = goodImage;
      text = GOOD_TEXT;
      if (!soundEffectHasPlayed) {
        playGoodSE();
        soundEffectHasPlayed = true;
        println("Good");
      }
      break;
    case Nice:
      image = niceImage;
      text = NICE_TEXT;
      if (!soundEffectHasPlayed) {
        playNiceSE();
        soundEffectHasPlayed = true;
        println("Nice");
      }
      break;
    case Bad:
      image = badImage;
      text = BAD_TEXT;
      if (!soundEffectHasPlayed) {
        playBadSE();
        soundEffectHasPlayed = true;
        println("Bad");
      }
      break;
    }
  }

  private void reset() {
    if (judgment!=null && (frame-startFrame) >= JUDGE_DISPLAY_DURATION) {
      startFrame = -1;
      soundEffectHasPlayed = false;
      judgment = null;
    }
  }
}

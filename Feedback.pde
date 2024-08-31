//TODO: 使わないならそもそも初期化しないようにした方がいい？
class Feedback {
  final private String GOOD_TEXT = "GOOD!!";
  final private String NICE_TEXT = "NICE!";
  final private String BAD_TEXT = "BAD...";
  final int JUDGE_TEXT_SIZE = 70;
  final private int X = width-250;
  final private int Y = 400;
  private boolean isActive;
  private PImage image;
  private String text;
  private int startFrame;
  private Judgment judgment;
  private boolean soundEffectHasPlayed;

  Feedback() {
    setIsActive();
    text = "";
    startFrame = -1;
    soundEffectHasPlayed = false;
  }

  public void run(Judgment judgment) {
    setJudgment(judgment);
    display();
    reset();
  }

  public void setIsActive() {
    isActive = faciSettings.myGetBoolean(isActiveFeedback);
  }

  private void setJudgment(Judgment judgment) {
    if (judgment != null) {
      startFrame = playingFrame;
      this.judgment = judgment;
    }
  }

  private void display() {
    if (isActive) {
      if (image!=null) {
        image(image, X, Y);
      }
      displayText(text, X, Y-250, JUDGE_TEXT_SIZE, BLACK);
      if (judgment==null) {
        return;
      }

      switch (judgment) {
      case Good:
        image = goodImage;
        text = GOOD_TEXT;
        if (!soundEffectHasPlayed) {
          playGoodSE();
          soundEffectHasPlayed = true;
        }
        break;
      case Nice:
        image = niceImage;
        text = NICE_TEXT;
        if (!soundEffectHasPlayed) {
          playNiceSE();
          soundEffectHasPlayed = true;
        }
        break;
      case Bad:
        image = badImage;
        text = BAD_TEXT;
        if (!soundEffectHasPlayed) {
          playBadSE();
          soundEffectHasPlayed = true;
        }
        break;
      }
    }
  }

  private void reset() {
    if (judgment!=null && (playingFrame-startFrame) >= JUDGE_DISPLAY_DURATION) {
      startFrame = -1;
      soundEffectHasPlayed = false;
      judgment = null;
    }
  }
}

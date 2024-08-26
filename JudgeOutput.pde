//class JudgeOutput {
//  final private String GOOD_TEXT = "GOOD!!";
//  final private String NICE_TEXT = "NICE!";
//  final private String BAD_TEXT = "BAD...";
//  final private float  OFFSET = 200;
//  private PVector coord;
//  private int startFrame;
//  private Judgment judgment;
//  private boolean soundEffectHasPlayed;

//  JudgeOutput(Note note) {
//    coord = new PVector(note.getcoord().x + OFFSET, note.getcoord().y - OFFSET);
//    startFrame = -1;
//    soundEffectHasPlayed = false;
//  }

//  public void run(Judgment judgment) {
//    setJudgment(judgment);
//    display();
//    reset();
//  }
  
//  public void killField() {
//    coord = null;
//    judgment = null;
//  }

//  private void setJudgment(Judgment judgment) {
//    if (judgment != null) {
//      startFrame = frame;
//      this.judgment = judgment;
//    }
//  }
  
//  private void display() {
//    if (judgment==null) { return; }
    
//    switch (judgment) {
//    case Good:
//      judgmentText(GOOD_TEXT);
//      if (!soundEffectHasPlayed) {
//        playGoodSE();
//        soundEffectHasPlayed = true;
//      }
//      break;
//    case Nice:
//      judgmentText(NICE_TEXT);
//      if (!soundEffectHasPlayed) {
//        playNiceSE();
//        soundEffectHasPlayed = true;
//      }
//      break;
//    case Bad:
//      judgmentText(BAD_TEXT);
//      if (!soundEffectHasPlayed) {
//        playBadSE();
//        soundEffectHasPlayed = true;
//      }
//      break;
//    }
//  }

//  private void reset() {
//    if (judgment!=null && (frame-startFrame) >= JUDGE_DISPLAY_DURATION) {
//      startFrame = -1;
//      judgment = null;
//    }
//  }
  
//  private void judgmentText(String text) {
//    displayText(text, coord, JUDGE_TEXT_SIZE, WHITE);
//  }  
//}

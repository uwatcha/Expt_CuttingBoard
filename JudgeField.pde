class JudgeField {
  private static final int TOP_LEFT_X = 0;
  private final int TOP_LEFT_Y = height/2;
  private final int WIDTH = width;
  private final int HEIGHT = height/2;
  private int justMillis;
  private Judgment judgment;
  private int timingDiff;
  private ArrayList<Object> rtn;

  public JudgeField() {
    justMillis = FIELD_RESET_VALUE;
    judgment = Judgment.None;
    timingDiff = FIELD_RESET_VALUE;
    rtn = new ArrayList<Object>();
  }

  public ArrayList<Object> run() {
    calcJustMillis();
    judgeTouchTiming();
    if (judgment != Judgment.None) {
      rtn.add(JUST_MILLIS_INDEX, justMillis);
      rtn.add(TIMING_DIFF_INDEX, timingDiff);
      rtn.add(JUDGMENT_INDEX, judgment);
      rtn.add(POSITION_X_INDEX, actionPosition[0]);
      rtn.add(POSITION_Y_INDEX, actionPosition[1]);
    } else {
      rtn = new ArrayList<Object>();
    }
    display();
    return rtn;
  }

  public void display() {
    displayRect(TOP_LEFT_X, TOP_LEFT_Y, WIDTH, HEIGHT, 0, CLEAR_GREY);
  }
  
  public int getJustMillis() { return justMillis; }
  
  private void judgeTouchTiming() {
    if (isTouched()) {
      if (isNowWithinRange(0, GOOD_MILLIS)) {
        judgment = Judgment.Good;
      } else if (isNowWithinRange(GOOD_MILLIS, NICE_MILLIS)) {
        judgment = Judgment.Nice;
      } else if (isNowWithinRange(NICE_MILLIS, Integer.MAX_VALUE)) {
        judgment = Judgment.Bad;
      } else {
        judgment = Judgment.None;
      }
    } else {
      judgment = Judgment.None;
    }
  }
  
  private void calcJustMillis() {
    int loopCount = playingMillis()/touchIntervalMillis;
    int loopRemainder = playingMillis()%touchIntervalMillis;
    if (loopRemainder >= touchIntervalMillis/2) {
      loopCount++;
    }
    justMillis = loopCount*touchIntervalMillis;
    //println("justMillis: "+justMillis);
  }

  private boolean isNowWithinRange(int lowerBoundMillis, int upperBoundMillis) {
    timingDiff = playingMillis()-justMillis;
    return (lowerBoundMillis <= abs(timingDiff)&&abs(timingDiff) <= upperBoundMillis);
  }

  private boolean isTouched() {
    if (action==Action.Down) {
      if (isTouchInField()) {
        return true;
      }
    }
    return false;
  }
  
  public boolean isTouchInField() {
    return rectTouchJudge(TOP_LEFT_X, TOP_LEFT_Y, TOP_LEFT_X+WIDTH, TOP_LEFT_Y+HEIGHT, actionPosition[0], actionPosition[1]);
  }
}

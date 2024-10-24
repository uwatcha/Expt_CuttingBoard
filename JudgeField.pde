//TODO: 画面上に複数の指が触れている場合を想定したコードに書き直す
//ex)画面上部に触れている状態で画面下部をタッチすると、１回目は判定されるが、２回目は反応しない

class JudgeField {
  final int TOP_LEFT_X = 0;
  final int TOP_LEFT_Y = height/2;
  final int WIDTH = width;
  final int HEIGHT = height/2;
  private int justFrame;
  private Judgment judgment;
  private int timingDiff;
  private ArrayList<Object> rtn;

  public JudgeField() {
    justFrame = FIELD_RESET_VALUE;
    judgment = Judgment.None;
    timingDiff = FIELD_RESET_VALUE;
    rtn = new ArrayList<Object>();
  }

  public ArrayList<Object> run() {
    calcJustFrame();
    judgeTouchTiming();
    if (judgment != Judgment.None) {
      rtn.add(JUST_FRAME_INDEX, justFrame);
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
  
  public int getJustFrame() { return justFrame; }
  
  private void judgeTouchTiming() {
    if (isTouched()) {
      if (isNowWithinRange(         0, GOOD_FRAME)) {
        judgment = Judgment.Good;
      } else if (isNowWithinRange(GOOD_FRAME, NICE_FRAME)) {
        judgment = Judgment.Nice;
      } else if (isNowWithinRange(NICE_FRAME, Integer.MAX_VALUE)) {
        judgment = Judgment.Bad;
      } else {
        judgment = Judgment.None;
      }
    } else {
      judgment = Judgment.None;
    }
  }
  
  private void calcJustFrame() {
    int frameLoopCount = playingFrame/(int)touchIntervalFrame;
    int frameRemainder = playingFrame%(int)touchIntervalFrame;
    if (frameRemainder >= touchIntervalFrame/2) {
      frameLoopCount++;
    }
    justFrame = frameLoopCount*(int)touchIntervalFrame;
  }

  private boolean isNowWithinRange(int lowerBoundFrame, int upperBoundFrame) {
    timingDiff = playingFrame-justFrame;
    return (lowerBoundFrame <= abs(timingDiff)&&abs(timingDiff) <= upperBoundFrame);
  }

  private boolean isTouched() {
    if (actionID==MotionEvent.ACTION_DOWN) {
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

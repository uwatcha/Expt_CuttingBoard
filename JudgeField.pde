//TODO: 画面上に複数の指が触れている場合を想定したコードに書き直す
//ex)画面上部に触れている状態で画面下部をタッチすると、１回目は判定されるが、２回目は反応しない

class JudgeField {
  final int TOP_LEFT_X = 0;
  final int TOP_LEFT_Y = height/2;
  final int WIDTH = width;
  final int HEIGHT = height/2;
  private boolean hasTouched;
  private int justFrame;
  private int timingDiff;
  public JudgeField() {
    hasTouched = false;
  }

  public Judgment run() {
    display();
    resetHasTouched();
    Judgment j = judgeTouchTiming();
    if (j != null) println(j);
    return j;
  }
  
  public void display() {
    displayRect(TOP_LEFT_X, TOP_LEFT_Y, WIDTH, HEIGHT, 0, CLEAR_GREY);
  }
  
  public int getJustFrame() { return justFrame; }
  public int getTimingDiff() { return timingDiff; }
  
  private Judgment judgeTouchTiming() {
    if (getTouchedPointer() != null) {
           if (isNowWithinRange(         0, GOOD_FRAME))         { return Judgment.Good; } 
      else if (isNowWithinRange(GOOD_FRAME, NICE_FRAME))         { return Judgment.Nice; }
      else if (isNowWithinRange(NICE_FRAME, Integer.MAX_VALUE))  { return Judgment.Bad;  } 
      else                                                       { return null; }
    } else {
      return null;
    }
  }
  
  private boolean isNowWithinRange(int lowerBoundFrame, int upperBoundFrame) {
    int frameLoopCount = playingFrame/TOUCH_INTERVAL;
    int frameRemainder = playingFrame%TOUCH_INTERVAL;
    if (frameRemainder >= TOUCH_INTERVAL/2) {
      frameLoopCount++;
    }
    justFrame = frameLoopCount*TOUCH_INTERVAL;
    timingDiff = abs(playingFrame-justFrame);
    return (lowerBoundFrame <= timingDiff&&timingDiff <= upperBoundFrame);
  }
    
  private processing.event.TouchEvent.Pointer getTouchedPointer() {
    for (processing.event.TouchEvent.Pointer touch : touches) {
      if ((TOP_LEFT_X <= touch.x&&touch.x <= TOP_LEFT_X+WIDTH) && (TOP_LEFT_Y <= touch.y&&touch.y <= TOP_LEFT_Y+HEIGHT)) {
        if (!hasTouched) {
          hasTouched = true;
          return touch;
        } else {
          return null;
        }
      }
    }
    return null;
  }
  
  private void resetHasTouched() {
    if (hasTouched && touches.length==0) {
      hasTouched = false;
    }
  }
}

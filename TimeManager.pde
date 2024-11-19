//TODO: ゲーム開始前のメーターが１周する時間と、ゲージの１ループにかかる時間にどちらもintervalという言葉を使っているので修正する
class TimeManager {
  public final int START_INTERVAL = 1000;
  private int touchIntervalMillis;
  private int lastPlayingMillisSum;
  private int playStartMillis;
  private int thisTurnPlayingMillis;
  private int intervalStartMillis;

  TimeManager () {
    setTouchIntervalMillis();
    lastPlayingMillisSum = 0;
    playStartMillis = 0;
    thisTurnPlayingMillis = 0;
    intervalStartMillis = INT_RESET_VALUE;
  }
  
  public void run() {
    if (currentScreen==ScreenType.Playing) {
      setThisTurnPlayingMillis();
    }
    //println("================================");
    //println("getPlayingMillis(): "+getPlayingMillis());
    //println("getLoopPlayingMillis(): "+getLoopPlayingMillis());
    //println("thisTurnPlayingMillis(): "+thisTurnPlayingMillis);
    //println("playStartMillis: "+playStartMillis);
  }
  
  public void setTouchIntervalMillis() {
    touchIntervalMillis = 1000*4*FRAME_RATE/faciSettings.myGetInt(bpm);
  }
  
  private void resetMillis() {
    playStartMillis = 0;
    intervalStartMillis = INT_RESET_VALUE;
    thisTurnPlayingMillis = 0;
  }

  public int getTouchIntervalMillis() {
    return touchIntervalMillis;
  }

  public int getPlayingMillis() {
    return lastPlayingMillisSum + thisTurnPlayingMillis;
  }

  private void setThisTurnPlayingMillis() {
    thisTurnPlayingMillis = millis() - playStartMillis;
  }

  public int getLoopPlayingMillis() {
    return getPlayingMillis()%touchIntervalMillis;
  }

  public int getIntervalMillis() {
    if (intervalStartMillis!=INT_RESET_VALUE) {
      return millis()-intervalStartMillis;
    } else {
      return INT_RESET_VALUE;
    }
  }

  public void setIntervalStartMillis() {
    intervalStartMillis = millis();
  }

  public void setPlayStartMillis() {
    playStartMillis = millis();
  }

  public void pauseTimeManager() {
    lastPlayingMillisSum += thisTurnPlayingMillis;
    resetMillis();
  }

  public void resetTimeManager() {
    lastPlayingMillisSum = 0;
    resetMillis();
  }
}

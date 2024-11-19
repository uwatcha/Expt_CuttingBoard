//TODO: ゲーム開始前のメーターが１周する時間と、ゲージの１ループにかかる時間にどちらもintervalという言葉を使っているので修正する
class TimeManager {
  private final int TOUCH_INTERVAL_MILLIS;
  public final int START_INTERVAL = 1000;
  private int lastPlayingMillisSum;
  private int playStartMillis;
  private int intervalStartMillis;

  TimeManager () {
    TOUCH_INTERVAL_MILLIS = 1000*4*FRAME_RATE/faciSettings.myGetInt(bpm);
    lastPlayingMillisSum = 0;
    playStartMillis = 0;
    intervalStartMillis = INT_RESET_VALUE;
  }

  public void run() {
    println("==================================================");
    println("lastPlayingMillisSum: "+lastPlayingMillisSum);
    println("playStartMillis: "+playStartMillis);
    //println("intervalStartMillis: "+intervalStartMillis);
    //println("thisTurnPlayingMillis: "+getThisTurnPlayingMillis());
    //println("touchIntervalMillis"+getTouchIntervalMillis());
    println("playingMillis: "+getPlayingMillis());
    println("loopPlayingMillis: "+getLoopPlayingMillis());
    //println("intervalMillis: "+getIntervalMillis());
    
    //lastFrameScreen = currentScreen;
  }

  private void resetStartMillis() {
    playStartMillis = 0;
    intervalStartMillis = INT_RESET_VALUE;
  }

  public int getTouchIntervalMillis() {
    return TOUCH_INTERVAL_MILLIS;
  }

  public int getPlayingMillis() {
    if (currentScreen==ScreenType.Playing) {
      return lastPlayingMillisSum + getThisTurnPlayingMillis();
    } else {
      return INT_RESET_VALUE;
    }
  }

  private int getThisTurnPlayingMillis() {
    if (currentScreen==ScreenType.Playing) {
      return millis() - playStartMillis;
    } else {
      return 0;
    }
  }

  public int getLoopPlayingMillis() {
    return getPlayingMillis()%TOUCH_INTERVAL_MILLIS;
  }

  public int getIntervalMillis() {
    if (intervalStartMillis!=INT_RESET_VALUE) {
      return millis()-intervalStartMillis;
    } else {
      return INT_RESET_VALUE;
    }
  }

  public void setIntervalStartMillis() {
    println("setIntervalStartMillis() called");
    intervalStartMillis = millis();
  }

  public void setPlayStartMillis() {
    println("setPlayStartMillis() called");
    playStartMillis = millis();
  }

  public void pauseTimeManager() {
    println("pauseTimeManager() called");
    lastPlayingMillisSum += getThisTurnPlayingMillis();
    resetStartMillis();
  }

  public void resetTimeManager() {
    println("resetTimeManager() called");
    lastPlayingMillisSum = 0;
    resetStartMillis();
  }
}

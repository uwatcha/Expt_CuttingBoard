//TODO: ゲーム開始前のメーターが１周する時間と、ゲージの１ループにかかる時間にどちらもintervalという言葉を使っているので修正する
class TimeManager {
  private final int TOUCH_INTERVAL_MILLIS;
  public final int START_INTERVAL = 1000;
  private int lastPlayingMillisSum;
  private int playStartMillis;
  private int thisTurnPlayingMillis;
  private int intervalStartMillis;

  TimeManager (int bpm) {
    TOUCH_INTERVAL_MILLIS = 1000*4*FRAME_RATE/bpm;
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
  
  private void resetMillis() {
    playStartMillis = 0;
    intervalStartMillis = INT_RESET_VALUE;
    thisTurnPlayingMillis = 0;
  }

  public int getTouchIntervalMillis() {
    return TOUCH_INTERVAL_MILLIS;
  }

  public int getPlayingMillis() {
    return lastPlayingMillisSum + thisTurnPlayingMillis;
  }

  private void setThisTurnPlayingMillis() {
    thisTurnPlayingMillis = millis() - playStartMillis;
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

abstract class Screen {
  final int SCREEN_TITLE_SIZE = 150;
  Screen() {
  }

  abstract public void run();
}

class TitleScreen extends Screen {
  TitleScreen() {
  }

  @Override
    public void run() {
    background(woodImage);
    displayText("タブレットまな板", width/2, height/6, SCREEN_TITLE_SIZE, BLACK);
    settingsButton.run();
    startButton.run();
  }
}

class SettingsScreen extends Screen {
  SettingsScreen() {
  }

  @Override
    public void run() {
    background(woodImage);
    displayText("Settings", width/2, height/6, SCREEN_TITLE_SIZE, BLACK);
    settingsToTitleButton.run();
    feedbackToggleButton.run();
    gaugeToggleButton.run();
    bpmSlider.run();
  }
}

class PlayingScreen extends Screen {

  ArrayList<Object> judgeFieldValues;
  int logJustMillis;
  int logTimingDiff;
  float logTouchPositionX, logTouchPositionY;
  Judgment judgment;
  boolean playingFirstLoop;

  PlayingScreen() {
    judgment = Judgment.None;
    playingFirstLoop = true;
  }

  @Override
    public void run() {
    background(woodImage);
    playingToTitleButton.run();
    if (intervalMillis() < START_INTERVAL) {
      interval();
    } else {
      playing();
    }
  }
  private void interval() {
    displayArcRing(width/2, height/4, 125, 0, map(intervalMillis(), 0, START_INTERVAL, 0, TWO_PI), 40, LIGHT_GREEN);
    gauge.displayFrame();
    judgeField.display();
  }
  private void playing() {
    if (playingFirstLoop) {
      playStartMillis = millis();
      setTouchIntervalMillis();
      playingFirstLoop = false;
    }

    if (timingSEChecker.isMatched(loopPlayingMillis(), touchIntervalMillis/2)) {
      timingSE.play();
    }

    gauge.run();
    judgeFieldValues = judgeField.run();
    
    logOutput();
  }

  //TODO: スクリーンをオブジェクト化&スクリーンのInitialize()で呼び出す
  //TODO: 現在はフラグで一度だけ呼び出してるので、修正する。
  private void setTouchIntervalMillis() {
    touchIntervalMillis = 1000*4*FRAME_RATE/faciSettings.myGetInt(bpm);
    //本来なら以下のように計算するが、簡略化できるので直接計算している。
    //int touchIntervalFrame = 4*FRAME_RATE/faciSettings.myGetInt(bpm);
    //touchIntervalMillis = framesToMillis(touchIntervalFrame);
  }

  private void logOutput() {
    if (judgeFieldValues.size()!=0) {
      logJustMillis = (int)judgeFieldValues.get(JUST_MILLIS_INDEX);
      logTimingDiff = (int)judgeFieldValues.get(TIMING_DIFF_INDEX);
      judgment = (Judgment)judgeFieldValues.get(JUDGMENT_INDEX);
      logTouchPositionX = (float)judgeFieldValues.get(POSITION_X_INDEX);
      logTouchPositionY = (float)judgeFieldValues.get(POSITION_Y_INDEX);
    }

    if (action==Action.Down && judgeField.isTouchInField()) {
      generalCSV.createRecord(action, logJustMillis, logTimingDiff, judgment, actionPosition[0], actionPosition[1]);
      actionCSV.createRecord(action, logJustMillis, actionPosition[0], actionPosition[1]);
      touchCSV.createRecord(logJustMillis, logTimingDiff, judgment, logTouchPositionX, logTouchPositionY);
    }

    feedback.run(judgment);

    if (action==Action.Up && judgeField.isTouchInField() && judgment!=Judgment.None) {
      generalCSV.createRecord(action, logJustMillis, logTimingDiff, judgment, actionPosition[0], actionPosition[1]);
      actionCSV.createRecord(action, logJustMillis, actionPosition[0], actionPosition[1]);
      judgeFieldValues = new ArrayList<Object>();
      logJustMillis = FIELD_RESET_VALUE;
      logTimingDiff = FIELD_RESET_VALUE;
      judgment = Judgment.None;
      logTouchPositionX = FIELD_RESET_VALUE;
      logTouchPositionY = FIELD_RESET_VALUE;
    }
    if (justMillisChecker.isMatched(judgeField.getJustMillis(), playingMillis()) && !playingFirstLoop) {
      playHitSE();
      generalCSV.createJustMillisRecord(judgeField.getJustMillis());
      actionCSV.createJustMillisRecord(judgeField.getJustMillis());
      touchCSV.createJustMillisRecord(judgeField.getJustMillis());
    }
  }
}

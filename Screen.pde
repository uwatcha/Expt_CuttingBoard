abstract class Screen {
  protected final int SCREEN_TITLE_SIZE = 150;
  protected final int START_INTERVAL = 1000;
  Screen() {
  }

  abstract public void run();
}

class TitleScreen extends Screen {
  TitleScreen() {
    super();
  }

  @Override
    public void run() {
    background(woodImage);
    displayText("タブレットまな板", width/2, height/6, SCREEN_TITLE_SIZE);
    settingsButton.run();
    startButton.run();
  }
}

class SettingsScreen extends Screen {
  SettingsScreen() {
    super();
  }

  @Override
    public void run() {
    background(woodImage);
    displayText("Settings", width/2, height/6, SCREEN_TITLE_SIZE);
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
    super();
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
    displayArcRing(width/2, height/4, 125, 0, map(intervalMillis(), 0, START_INTERVAL, 0, TWO_PI), 40, colors.LIGHT_GREEN);
    gauge.displayFrame();
    judgeField.display();
  }
  private void playing() {
    if (playingFirstLoop) {
      playStartMillis = millis();
      setTouchIntervalMillis();
    }

    if (timingSEChecker.isMatched(loopPlayingMillis(), touchIntervalMillis/2)) {
      timingSE.play();
    }

    gauge.run();
    judgeFieldValues = judgeField.run();
    
    logOutput();
    if (playingFirstLoop) {
      playingFirstLoop = false;
    }
  }

  private void setTouchIntervalMillis() {
    touchIntervalMillis = 1000*4*FRAME_RATE/faciSettings.myGetInt(bpm);
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

class PauseScreen extends Screen {
  private PauseToPlayingButton pauseToPlayingButton;
  private PlayingToTitleButton playingToTitleButton;
  PauseScreen() {
    super();
    pauseToPlayingButton = new PauseToPlayingButton();
    playingToTitleButton = new PlayingToTitleButton();
  }
  
  public void run() {
    background(woodImage);
    displayText("停止中", width/2, height/6, SCREEN_TITLE_SIZE);
    pauseToPlayingButton.run();
    playingToTitleButton.run();
  }
}

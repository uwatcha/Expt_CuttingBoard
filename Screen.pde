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
  boolean playingFirstLoop;

  PlayingScreen() {
    super();
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
    judgeField.run();

    logOutput();
    if (playingFirstLoop) {
      playingFirstLoop = false;
    }
  }

  private void setTouchIntervalMillis() {
    touchIntervalMillis = 1000*4*FRAME_RATE/faciSettings.myGetInt(bpm);
  }

  private void logOutput() {
    HashMap<Field, Object> generalFields = judgeField.getGeneralCSVFields();
    if (action==Action.Down && judgeField.isTouchInField()) {
      generalCSV.createRecord(generalFields);
      touchCSV.createRecord(judgeField.getTouchCSVFields());
      actionCSV.createRecord(judgeField.getActionCSVFields());
    }

    feedback.run(generalFields.containsKey(Field.Judgment) ? (Judgment)generalFields.get(Field.Judgment) : Judgment.None);

    if (action==Action.Up) {
    }
    if (action==Action.Up && judgeField.isTouchInField()) {
      generalCSV.createRecord(generalFields);
      actionCSV.createRecord(judgeField.getActionCSVFields());
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

abstract class Screen {
  protected final int SCREEN_TITLE_SIZE = 150;
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

class IntervalScreen extends Screen {
  IntervalScreen() {
    super();
  }

  @Override
    public void run() {
    background(woodImage);
    displayArcRing(width/2, height/4, 125, 0, map(timeManager.getIntervalMillis(), 0, timeManager.START_INTERVAL, 0, TWO_PI), 40, colors.LIGHT_GREEN);
    gauge.run();
    judgeField.display();

    if (justMillisChecker.isMatched(timeManager.getIntervalMillis(), timeManager.START_INTERVAL)) {
      currentScreen = ScreenType.Playing;
      timeManager.setPlayStartMillis();
    }
  }
}

//---------------------------------------------------------------------------------------------------------------

class PlayingScreen extends Screen {
  private boolean playingFirstLoop;
  private GeneralCSV generalCSV;

  PlayingScreen() {
    super();
    playingFirstLoop = true;
    generalCSV = new GeneralCSV();
  }

  @Override
    public void run() {
    background(woodImage);
    playingToTitleButton.run();
    playingToPauseButton.run();

    if (currentScreen == ScreenType.Playing) {
      if (timingSEChecker.isMatched(timeManager.getLoopPlayingMillis(), timeManager.getTouchIntervalMillis()/2)) {
        timingSE.play();
      }

      gauge.run();
      judgeField.run();

      logOutput();

      if (playingFirstLoop) {
        playingFirstLoop = false;
      }
    }
  }

  public void start() {
    currentScreen = ScreenType.Interval;
    generalCSV.createFile();
    timeManager.setIntervalStartMillis();
    playingFirstLoop = true;
  }

  public void resume() {
    currentScreen = ScreenType.Interval;
    generalCSV.reopenFile();
    timeManager.setIntervalStartMillis();
  }

  public void pause() {
    currentScreen = ScreenType.Pause;
    generalCSV.closeFile();
    timeManager.pauseTimeManager();
  }

  public void quit() {
    currentScreen = ScreenType.Title;
    generalCSV.closeFile();
    timeManager.resetTimeManager();
    feedback.reset();
  }

  private void logOutput() {
    HashMap<Field, Object> generalFields = judgeField.getGeneralCSVFieldValues();
    if (action==Action.Down && judgeField.isTouchInField()) {
      generalCSV.createRecord(generalFields);
    }

    feedback.run(generalFields.containsKey(Field.Judgment) ? (Judgment)generalFields.get(Field.Judgment) : Judgment.None);

    //TODO: タッチダウンが成功した後、領域外でタッチアップするのを受け付けるようにする
    //ここのjudgeField.isTouchInField()を消すと、createRecordに初期状態のHashMapが渡ってエラーが起こる
    if (action==Action.Up && judgeField.isTouchInField()) {
      generalCSV.createRecord(generalFields);
    }
    if (justMillisChecker.isMatched(timeManager.getPlayingMillis(), judgeField.getJustMillis()) && !playingFirstLoop) {
      println("playingMillis: "+timeManager.getPlayingMillis());
      println("justMillis: "+judgeField.getJustMillis());
      playHitSE();
      generalCSV.createJustMillisRecord(judgeField.getJustMillis());
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

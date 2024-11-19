//TODO: IntervalScreenを作る
//TODO: PlayingScreenに入るたびに様々な項目をリセットする（bpmなど）
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

//---------------------------------------------------------------------------------------------------------------

class PlayingScreen extends Screen {
  private GeneralCSV generalCSV;
  private boolean playingFirstLoop;

  PlayingScreen() {
    super();
    generalCSV = new GeneralCSV();
    playingFirstLoop = true;
  }

  @Override
    public void run() {
    background(woodImage);
    playingToTitleButton.run();
    playingToPauseButton.run();
    if (timeManager.getIntervalMillis() < timeManager.START_INTERVAL) {
      interval();
    } else {
      playing();
    }
  }

  public void start() {
    currentScreen = ScreenType.Playing;
    generalCSV.createFile();
    timeManager.setIntervalStartMillis();
    playingFirstLoop = true;
  }
  
  public void resume() {
    currentScreen = ScreenType.Playing;
    generalCSV.reopenFile();
    timeManager.setIntervalStartMillis();
    playingFirstLoop = true;
  }
  
  public void pause() {
    currentScreen = ScreenType.Pause;
    generalCSV.closeFile();
    timeManager.pauseTimeManager();
  }

  public void quit() {
    println("quit() called.");
    currentScreen = ScreenType.Title;
    generalCSV.closeFile();
    timeManager.resetTimeManager();
  }

  private void interval() {
    displayArcRing(width/2, height/4, 125, 0, map(timeManager.getIntervalMillis(), 0, timeManager.START_INTERVAL, 0, TWO_PI), 40, colors.LIGHT_GREEN);
    gauge.displayFrame();
    judgeField.display();
  }
  private void playing() {
    if (playingFirstLoop) {
      timeManager.setPlayStartMillis();
    }
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

  private void logOutput() {
    HashMap<Field, Object> generalFields = judgeField.getGeneralCSVFieldValues();
    if (action==Action.Down && judgeField.isTouchInField()) {
      generalCSV.createRecord(generalFields);
    }

    feedback.run(generalFields.containsKey(Field.Judgment) ? (Judgment)generalFields.get(Field.Judgment) : Judgment.None);

    if (action==Action.Up) {
    }
    //TODO: タッチダウンが成功した後、領域外でタッチアップするのを受け付けるようにする
    if (action==Action.Up && judgeField.isTouchInField()) {
      generalCSV.createRecord(generalFields);
    }
    if (justMillisChecker.isMatched(timeManager.getPlayingMillis(), judgeField.getJustMillis()) && !playingFirstLoop) {
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

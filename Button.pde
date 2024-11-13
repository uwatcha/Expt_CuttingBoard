abstract class Button {
  protected final int X;
  protected final int Y;
  protected int WIDTH;
  protected int HEIGHT;

  Button(int x, int y, int w, int h) {
    X = x;
    Y = y;
    WIDTH = w;
    HEIGHT = h;
  }

  protected void run() {
    display();
    if (action==Action.Down) {
      if (rectTouchJudge(X, Y, WIDTH, HEIGHT, actionPosition[0], actionPosition[1])) {
        effect();
      }
    }
  }

  abstract protected void display();
  abstract protected void effect();
}

//------------------------------------------------------------------------------------------------------------------------------------------

class StartButton extends Button {

  StartButton() {
    super(width/2-600, height*4/7, 1200, 120);
  }

  @Override
    protected void display() {
    displayLine(X, Y, X+WIDTH, Y);
    displayText("Game Start", X+WIDTH/2, Y+HEIGHT/2, HEIGHT);
    displayLine(X, Y+HEIGHT, X+WIDTH, Y+HEIGHT);
  }

  @Override
    protected void effect() {
    currentScreen = ScreenType.Playing;
    intervalStartMillis = millis();
    playingScreen.createFiles();
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------
//TODO: 押したらエラーが出る
class SettingsButton extends Button {
  private final ScreenType TARGET_SCR = ScreenType.Settings;
  private static final int ROUND = 30;

  SettingsButton() {
    super(width-200-50, 50, 200, 200);
    gearImage.resize((int)WIDTH, (int)HEIGHT);
  }

  @Override
    protected void display() {
    displayRoundedRect(X, Y, WIDTH, HEIGHT, ROUND, 0, colors.WHITE, colors.BLACK);
    image(gearImage, X+WIDTH/2, Y+HEIGHT/2);
  }

  @Override
    protected void effect() {
    currentScreen = TARGET_SCR;
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class PauseToPlayingButton extends Button {
  PauseToPlayingButton() {
    super(width/2-600, height*4/7, 1200, 120);
  }

  @Override
    protected void display() {
    displayLine(X, Y, X+WIDTH, Y);
    displayText("Game Restart", X+WIDTH/2, Y+HEIGHT/2, HEIGHT);
    displayLine(X, Y+HEIGHT, X+WIDTH, Y+HEIGHT);
  }
  
  @Override
    protected void effect() {
      currentScreen = ScreenType.Playing;
    }
}

//------------------------------------------------------------------------------------------------------------------------------------------

abstract class ScreenBackButton extends Button {
  private static final int STROKE_WEIGHT = 20;
  private final int ARROW_TIP_X = X+WIDTH/6;
  private final int ARROW_TIP_Y = Y+HEIGHT/2;
  private static final int ARROW_TIP_WIDTH = 50;
  private static final int ARROW_TIP_RADIUS = 50;
  private static final int ARROW_LENGTH = 150;
  private final ScreenType TARGET_SCR;

  ScreenBackButton(ScreenType targetS) {
    super(50, 50, 150, 200);
    TARGET_SCR = targetS;
  }

  @Override
    protected void display() {
    displayLine(ARROW_TIP_X, ARROW_TIP_Y, ARROW_TIP_X+ARROW_TIP_WIDTH, ARROW_TIP_Y-ARROW_TIP_RADIUS, STROKE_WEIGHT);
    displayLine(ARROW_TIP_X, ARROW_TIP_Y, ARROW_TIP_X+ARROW_LENGTH, ARROW_TIP_Y, STROKE_WEIGHT);
    displayLine(ARROW_TIP_X, ARROW_TIP_Y, ARROW_TIP_X+ARROW_TIP_WIDTH, ARROW_TIP_Y+ARROW_TIP_RADIUS, STROKE_WEIGHT);
  }

  @Override
    protected void effect() {
    currentScreen = TARGET_SCR;
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class SettingsToTitleButton extends ScreenBackButton {

  SettingsToTitleButton() {
    super(ScreenType.Title);
  }

  @Override
    protected void effect() {
    super.effect();
    faciSettings.saveJSON();
    feedback.setIsActive();
    gauge.setIsActive();
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class PlayingToTitleButton extends ScreenBackButton {

  PlayingToTitleButton () {
    super(ScreenType.Title);
  }

  @Override
    protected void effect() {
    super.effect();
    playingScreen.closeFiles();
    isContinueWriting = false;
  }
}

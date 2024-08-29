final int SCREEN_TITLE_SIZE = 150;

void titleScreen() {
  background(woodImage);
  displayText("タブレットまな板", width/2, height/6, SCREEN_TITLE_SIZE, BLACK);
  settingsButton.run();
}

void settingsScreen() {
  background(woodImage);
  displayText("Settings", width/2, height/6, SCREEN_TITLE_SIZE, BLACK);
  settingsToTitleButton.run();
  feedbackToggleButton.run();
}

void playingScreen() {
  background(woodImage);
  frame = frameCount-1;
  loopFrame = loopFrame+1<TOUCH_INTERVAL ? loopFrame+1 : 0;
  
  if (loopFrame==TOUCH_INTERVAL/2) {
    println("half");
  }
  if (loopFrame+SOUND_LAG_BUFFER==TOUCH_INTERVAL/2) {
    timingSE.play();
  }
  gauge.run();
  judgeOutput.run(judgeField.run());
}

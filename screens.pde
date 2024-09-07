final int SCREEN_TITLE_SIZE = 150;
//TODO: 全てsetupで初期化するのではなく、各画面で必要な変数だけを初期化し、その画面から出たらメモリ解放する方がいい？

void titleScreen() {
  background(woodImage);
  displayText("タブレットまな板", width/2, height/6, SCREEN_TITLE_SIZE, BLACK);
  settingsButton.run();
  startButton.run();
}

void settingsScreen() {
  background(woodImage);
  displayText("Settings", width/2, height/6, SCREEN_TITLE_SIZE, BLACK);
  settingsToTitleButton.run();
  feedbackToggleButton.run();
  gaugeToggleButton.run();
}

void playingScreen() {
  background(woodImage);  
  playingToTitleButton.run();
  if (frameCount-playStartFrame < START_INTERVAL) {
    displayArcRing(width/2, height/4, 125, 0, map(frameCount-playStartFrame, 0, START_INTERVAL, 0, TWO_PI), 40, LIGHT_GREEN);
    gauge.displayFrame();
    judgeField.display();
  } else {
    playingFrame++;
    loopFrame = loopFrame+1<TOUCH_INTERVAL ? loopFrame+1 : 0;
  
    if (loopFrame==TOUCH_INTERVAL/2) {
      println("half");
    }
    
    if (loopFrame==TOUCH_INTERVAL/2) {
      timingSE.play();
    }
    Judgment j = judgeField.run();
    gauge.run();
    feedback.run(j);
    if (j!=null) {
      csvObject.createRecord(j);
    }
  }
}

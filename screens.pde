void titleScreen() {
}

void settingsScreen() {
  image(woodImage, 0, 0);
  displayText("Setting", new PVector(width/2, height*3/4), 50, BLACK);
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

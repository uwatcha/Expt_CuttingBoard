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

  
  gauge.run();
  judgeField.run();
}

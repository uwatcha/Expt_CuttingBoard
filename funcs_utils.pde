//Text-------------------------------------------------------------------------------------------------------------------------------------------------
void displayText(String text, float x, float y, int textSize, color textColor) {
  textSize(textSize);
  fill(textColor);
  text(text, x, y);
}
void displayText(String text, float x, float y, int textSize) {
  displayText(text, x, y, textSize, BLACK);
}

//Circle-----------------------------------------------------------------------------------------------------------------------------------------------
void displayRing(PVector coord, float r, float strokeWeight, color ringColor) {
  noFill();
  mySetStroke(strokeWeight, ringColor);
  circle(coord.x, coord.y, r*2);
}

void displayArcRing(float x, float y, float r, float startPI, float endPI, float strokeWeight, color ringColor) {
  noFill();
  mySetStroke(strokeWeight, ringColor);
  //startPIが0の時、3時ではなく12時の方向の方が直感的。
  arc(x, y, 2*r, 2*r, startPI-HALF_PI, endPI-HALF_PI);
}

//Rect, Square-----------------------------------------------------------------------------------------------------------------------------------------
void displayRect(float x, float y, float w, float h, float strokeWeight, color squareColor, color strokeColor) {
  mySetStroke(strokeWeight, strokeColor);
  fill(squareColor);
  rect(x, y, w, h);
}
void displayRect(float x, float y, float rectWidth, float rectHeight, float strokeWeight, color squareColor) {
  displayRect(x, y, rectWidth, rectHeight, strokeWeight, squareColor, BLACK);
}

void displaySquare(float x, float y, float size, float strokeWeight, color squareColor, color strokeColor) {
  mySetStroke(strokeWeight, strokeColor);
  fill(squareColor);
  square(x, y, size);
}

void displayRoundedRect(float x, float y, float w, float h, float r, float strokeWeight, color squareColor, color strokeColor) {
  mySetStroke(strokeWeight, strokeColor);
  fill(squareColor);
  rect(x, y, w, h, r);
}

//Line-------------------------------------------------------------------------------------------------------------------------------------------------
void displayLine(float x1, float y1, float x2, float y2, float strokeWeight, color lineColor) {
  strokeWeight(strokeWeight);
  stroke(lineColor);
  line(x1, y1, x2, y2);
}
void displayLine(float x1, float y1, float x2, float y2, float strokeWeight) {
  displayLine(x1, y1, x2, y2, strokeWeight, BLACK);
}
void displayLine(float x1, float y1, float x2, float y2) {
  displayLine(x1, y1, x2, y2, STROKE_DEFAULT, BLACK);
}
void displayVerticalLine(float x, float strokeWeight, color lineColor) {
  mySetStroke(strokeWeight, lineColor);
  line(x, 0, x, height);
}

//OtherShapes-----------------------------------------------------------------------------------------------------------------------------------------------
void mySetStroke(float strokeWeight, color strokeColor) {
  if (strokeWeight!=0) {
    strokeWeight(strokeWeight);
    stroke(strokeColor);
  } else {
    noStroke();
  }
}

//Time------------------------------------------------------------------------------------------------------------------------------------------------------
float secToFrames(float sec) {
  return FRAME_RATE*sec;
}

int intervalMillis() {
  if (intervalStartMillis!=FIELD_RESET_VALUE) {
    return millis()-intervalStartMillis;
  } else {
    return 0;
  }
}

int playingMillis() {
  if (playStartMillis!=FIELD_RESET_VALUE) {
    return millis()-playStartMillis;
  } else {
    return 0;
  }
}

int loopPlayingMillis() {
  return playingMillis()%touchIntervalMillis;
}

int framesToMillis(int frame) {
  return 1000*frame/FRAME_RATE;
}

//TODO: スクリーンをオブジェクト化&スクリーンのInitialize()で呼び出す
//TODO: 現在はフラグで一度だけ呼び出してるので、修正する。
void setTouchIntervalMillis() {
  touchIntervalMillis = 1000*4*FRAME_RATE/faciSettings.myGetInt(bpm);
  //本来なら以下のように計算するが、簡略化できるので直接計算している。
  //int touchIntervalFrame = 4*FRAME_RATE/faciSettings.myGetInt(bpm);
  //touchIntervalMillis = framesToMillis(touchIntervalFrame);
}

//Others------------------------------------------------------------------------------------------------------------------------------------------------------
boolean rectTouchJudge(float x, float y, float w, float h, float touchX, float touchY) {
  return (x <= touchX&&touchX <= x+w) && (y <= touchY&&touchY <= y+h);
}

void closeFiles() {
  generalCSV.closeFile();
  touchCSV.closeFile();
  actionCSV.closeFile();
}

//developer----------------------------------------------------------------------------------------------------------------------------------------------------
void appHaltButton() {
  int x = 50;
  int y = 200;
  int w = 200;
  int h = 200;
  pauseImage.resize(w, h);
  image(pauseImage, x+w/2, y+h/2);
  if (rectTouchJudge(x, y, w, h, actionPosition[0], actionPosition[1])) {
    println("break");
  }
}

//actionID==2147483647の出力が連続するときに出力しない関数だが、今後汎用的にする
boolean hasPrintedRESETVALUE = false;
void myPrintln(int actionID) {
  if(actionID==2147483647) {
    if (!hasPrintedRESETVALUE) {
      hasPrintedRESETVALUE = true;
      println("draw("+actionID+")");
    }
  } else {
    hasPrintedRESETVALUE = false;
    println("draw("+actionID+")");
  }
}

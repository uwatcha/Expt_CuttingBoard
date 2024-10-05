//Text-------------------------------------------------------------------------------------------------------------------------------------------------
void displayText(String text, int x, int y, int textSize, color textColor) {
  textSize(textSize);
  fill(textColor);
  text(text, x, y);
}
void displayText(String text, int x, int y, int textSize) {
  displayText(text, x, y, textSize, BLACK);
}

//Circle-----------------------------------------------------------------------------------------------------------------------------------------------
void displayRing(PVector coord, int r, int strokeWeight, color ringColor) {
  noFill();
  mySetStroke(strokeWeight, ringColor);
  circle(coord.x, coord.y, r*2);
}

void displayArcRing(int x, int y, int r, float startPI, float endPI, int strokeWeight, int ringColor) {
  noFill();
  mySetStroke(strokeWeight, ringColor);
  //startPIが0の時、3時ではなく12時の方向の方が直感的。
  arc(x, y, 2*r, 2*r, startPI-HALF_PI, endPI-HALF_PI);
}

//Rect, Square-----------------------------------------------------------------------------------------------------------------------------------------
void displayRect(int x, int y, int w, int h, int strokeWeight, color squareColor, color strokeColor) {
  mySetStroke(strokeWeight, strokeColor);
  fill(squareColor);
  rect(x, y, w, h);
}
void displayRect(int x, int y, int rectWidth, int rectHeight, int strokeWeight, color squareColor) {
  displayRect(x, y, rectWidth, rectHeight, strokeWeight, squareColor, BLACK);
}

void displaySquare(int x, int y, int size, int strokeWeight, color squareColor, color strokeColor) {
  mySetStroke(strokeWeight, strokeColor);
  fill(squareColor);
  square(x, y, size);
}

void displayRoundedRect(int x, int y, int w, int h, int r, int strokeWeight, color squareColor, color strokeColor) {
  mySetStroke(strokeWeight, strokeColor);
  fill(squareColor);
  rect(x, y, w, h, r);
}

//Line-------------------------------------------------------------------------------------------------------------------------------------------------
void displayLine(int x1, int y1, int x2, int y2, int strokeWeight, color lineColor) {
  strokeWeight(strokeWeight);
  stroke(lineColor);
  line(x1, y1, x2, y2);
}
void displayLine(int x1, int y1, int x2, int y2, int strokeWeight) {
  displayLine(x1, y1, x2, y2, strokeWeight, BLACK);
}
void displayLine(int x1, int y1, int x2, int y2) {
  displayLine(x1, y1, x2, y2, STROKE_DEFAULT, BLACK);
}
void displayVerticalLine(int x, int strokeWeight, color lineColor) {
  mySetStroke(strokeWeight, lineColor);
  line(x, 0, x, height);
}

//Others-----------------------------------------------------------------------------------------------------------------------------------------------
void mySetStroke(int strokeWeight, color strokeColor) {
  if (strokeWeight!=0) {
    strokeWeight(strokeWeight);
    stroke(strokeColor);
  } else {
    noStroke();
  }
}

boolean rectTouchJudge(int x, int y, int w, int h, float touchX, float touchY) {
  return (x <= touchX&&touchX <= x+w) && (y <= touchY&&touchY <= y+h);
}

float sec(float sec) {
  return FRAME_RATE*sec;
}

String getTime() {
  return nf(year(), 4)+"-"+nf(month(), 2)+"-"+nf(day(), 2)+"--"+nf(hour(), 2)+"-"+nf(minute(), 2);
}

String getGeneralExportPath() {
  return EXPORT_PATH+File.separator+"general"+File.separator+getTime()+"_general.csv";
}

String getTouchExportPath() {
  return EXPORT_PATH+File.separator+"touch"+File.separator+getTime()+"_touch.csv";
}

String getActionExportPath() {
  return EXPORT_PATH+File.separator+"action"+File.separator+getTime()+"_action.csv";
}

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
//boolean hasPrintedRESETVALUE = false;
//void myPrintln(int actionID) {
//  if(actionID==2147483647) {
//    if (!hasPrintedRESETVALUE) {
//      hasPrintedRESETVALUE = true;
//      println("draw("+actionID+")");
//    }
//  } else {
//    hasPrintedRESETVALUE = false;
//    println("draw("+actionID+")");
//  }
//}

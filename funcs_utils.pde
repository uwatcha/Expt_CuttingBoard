void displayText(String text, int x, int y, int textSize, color textColor) {
  textSize(textSize);
  fill(textColor);
  text(text, x, y);
}

void displayRing(PVector coord, int r, int strokeWeight, color ringColor) {
  noFill();
  mySetStroke(strokeWeight, ringColor);
  circle(coord.x, coord.y, r*2);
}

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

void displayLine(int x1, int y1, int x2, int y2, int strokeWeight, color lineColor) {
  strokeWeight(strokeWeight);
  stroke(lineColor);
  line(x1, y1, x2, y2);
}
void displayLine(int x1, int y1, int x2, int y2, int strokeWeight) {
  displayLine(x1, y1, x2, y2, strokeWeight, BLACK);
}

void displayVerticalLine(int x, int strokeWeight, color lineColor) {
  mySetStroke(strokeWeight, lineColor);
  line(x, 0, x, height);
}

void mySetStroke(int strokeWeight,color strokeColor) {
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

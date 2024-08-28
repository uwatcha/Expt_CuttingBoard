void displayText(String text, PVector coord, int textSize, color textColor) {
  textSize(textSize);
  fill(textColor);
  text(text, coord.x, coord.y);
}

void displayRing(PVector coord, float r, float strokeWeight, color ringColor) {
  noFill();
  mySetStroke(strokeWeight, ringColor);
  circle(coord.x, coord.y, r*2);
}

void displayRect(PVector coord, float rectWidth, float rectHeight, float strokeWeight, color squareColor, color strokeColor) {
  mySetStroke(strokeWeight, strokeColor);
  fill(squareColor);
  rect(coord.x, coord.y, rectWidth, rectHeight);
}
void displayRect(PVector coord, float rectWidth, float rectHeight, float strokeWeight, color squareColor) {
  displayRect(coord, rectWidth, rectHeight, strokeWeight, squareColor, BLACK);
}

void displaySquare(PVector coord, float size, float strokeWeight, color squareColor, color strokeColor) {
  mySetStroke(strokeWeight, strokeColor);
  fill(squareColor);
  square(coord.x, coord.y, size);
}

void displayVerticalLine(float x, float strokeWeight, color lineColor) {
  mySetStroke(strokeWeight, lineColor);
  line(x, 0, x, height);
}

void mySetStroke(float strokeWeight,color strokeColor) {
  println("-----------------");
  println("strokeWeight: "+strokeWeight);
  if (strokeWeight!=0) {
    strokeWeight(strokeWeight);
    stroke(strokeColor);
  } else {
    println("noStroke");
    noStroke();
  }
}

boolean rectTouchJudge(float x, float y, float w, float h, float touchX, float touchY) {
  return (x <= touchX&&touchX <= x+w) && (y <= touchY&&touchY <= y+h);
}

float sec(float sec) {
  return FRAME_RATE*sec;
}

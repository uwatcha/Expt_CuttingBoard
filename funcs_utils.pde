void displayText(String text, PVector coord, int textSize, color textColor) {
  textSize(textSize);
  fill(textColor);
  text(text, coord.x, coord.y);
}

void displayRing(PVector coord, float r, float strokeWeight, color circleColor) {
  noFill();
  strokeWeight(strokeWeight);
  stroke(circleColor);
  circle(coord.x, coord.y, r*2);
}

void displayRect(PVector coord, float rectWidth, float rectHeight, color squareColor) {
  fill(squareColor);
  rect(coord.x, coord.y, rectWidth, rectHeight);
}

void displaySquare(PVector coord, float size, color squareColor) {
  fill(squareColor);
  square(coord.x, coord.y, size);
}

void displayVerticalLine(float x, float strokeWeight, color lineColor) {
  strokeWeight(strokeWeight);
  stroke(lineColor);
  line(x, 0, x, height);
}

float sec(float sec) {
  return FRAME_RATE*sec;
}

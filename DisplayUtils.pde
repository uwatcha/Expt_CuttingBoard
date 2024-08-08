void displayText(String text, PVector coordinate, int textSize, color textColor) {
  textSize(textSize);
  fill(textColor);
  text(text, coordinate.x, coordinate.y);
}

void displayRing(PVector coordinate, float r, float strokeWeight, color circleColor) {
  noFill();
  strokeWeight(strokeWeight);
  stroke(circleColor);
  circle(coordinate.x, coordinate.y, r*2);
}

void displayVerticalLine(float x, float strokeWeight, color lineColor) {
  strokeWeight(strokeWeight);
  stroke(lineColor);
  line(x, 0, x, height);
}

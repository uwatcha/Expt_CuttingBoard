void textDisplay(String text, PVector coordinate, int textSize, color textColor) {
  textSize(textSize);
  fill(textColor);
  text(text, coordinate.x, coordinate.y);
}

void circleDisplay(PVector coordinate, float r, float strokeWeight, color circleColor) {
  strokeWeight(strokeWeight);
  fill(circleColor);
  circle(coordinate.x, coordinate.y, r);
}

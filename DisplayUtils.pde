void textDisplay(String text, PVector coordinate, int textSize, color textColor) {
  textSize(textSize);
  fill(textColor);
  text(text, coordinate.x, coordinate.y);
}

void ringDisplay(PVector coordinate, float r, float strokeWeight, color circleColor) {
  noFill();
  strokeWeight(strokeWeight);
  stroke(circleColor);
  circle(coordinate.x, coordinate.y, r*2);
}

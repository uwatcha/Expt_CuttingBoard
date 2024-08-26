void displayText(String text, PVector coord, int textSize, color textColor) {
  textSize(textSize);
  fill(textColor);
  text(text, coord.x, coord.y);
}

void displayRing(PVector coord, float r, float strokeWeight, color circleColor) {
  noFill();
  setStrokeWeight(strokeWeight);
  stroke(circleColor);
  circle(coord.x, coord.y, r*2);
}

void displayRect(PVector coord, float rectWidth, float rectHeight, float strokeWeight, color squareColor) {
  fill(squareColor);
  rect(coord.x, coord.y, rectWidth, rectHeight);
}

void displaySquare(PVector coord, float size, float strokeWeight, color squareColor) {
  setStrokeWeight(strokeWeight);
  fill(squareColor);
  square(coord.x, coord.y, size);
}

void displayVerticalLine(float x, float strokeWeight, color lineColor) {
  setStrokeWeight(strokeWeight);
  stroke(lineColor);
  line(x, 0, x, height);
}

void setStrokeWeight(float strokeWeight) {
  if (strokeWeight!=0) {
    strokeWeight(strokeWeight);
  } else {
    noStroke();
  }
}

float sec(float sec) {
  return FRAME_RATE*sec;
}

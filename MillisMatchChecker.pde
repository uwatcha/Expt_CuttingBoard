//TODO: TimeManagerに組み込む

class MillisMatchChecker {
  private final float TOLERANCE_MILLIS = 1000/FRAME_RATE;
  private boolean isTriggered = false;
  private int matchedMillis = INT_RESET_VALUE;

  MillisMatchChecker() {
  }
  public boolean isMatched(int checkedMillis, int referenceMillis) {
    if (!isTriggered && abs(checkedMillis-referenceMillis) < TOLERANCE_MILLIS) {
      isTriggered = true;
      matchedMillis = millis();
      return true;
    } else if (isTriggered && millis()-matchedMillis >= TOLERANCE_MILLIS) {
      isTriggered = false;
      return false;
    } else {
      return false;
    }
  }
}

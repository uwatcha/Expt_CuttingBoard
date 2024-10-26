class MillisMatchChecker {
  final int TOLERANCE_MILLIS = 1000/FRAME_RATE;
  private boolean isTriggered = false;

  MillisMatchChecker() {
  }

  public boolean isMatched(int checkedMillis, int referenceMillis) {
    if (!isTriggered && abs(checkedMillis-referenceMillis) < TOLERANCE_MILLIS) {
      isTriggered = true;
      return true;
    } else if (isTriggered && checkedMillis-referenceMillis >= TOLERANCE_MILLIS) {
      isTriggered = false;
      return false;
    } else {
      return false;
    }
  }
}

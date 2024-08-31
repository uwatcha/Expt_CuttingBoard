boolean isTouch, isTouchDown, isTouchUp;

@Override
  public boolean surfaceTouchEvent(MotionEvent event) {
  switch (event.getAction()) {
  case MotionEvent.ACTION_DOWN:
    isTouchDown = true;
    break;
  case MotionEvent.ACTION_UP:
    isTouchUp = true;
    break;
  default:
    isTouch = isTouchDown = isTouchUp = false;
    break;
  }
  return super.surfaceTouchEvent(event);
}

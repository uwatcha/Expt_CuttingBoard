@Override
  public boolean surfaceTouchEvent(MotionEvent event) {
  switch (event.getAction()) {
  case MotionEvent.ACTION_DOWN:
    isTouchDown = true;
    break;
  case MotionEvent.ACTION_UP:
    isTouchUp = true;
    break;
  case MotionEvent.ACTION_POINTER_DOWN:
    isPointerTouchDown = true;
    break;
  case MotionEvent.ACTION_POINTER_UP:
    isPointerTouchUp = true;
    break;
  default:
    isTouch = isTouchDown = isTouchUp = isPointerTouchDown = isPointerTouchUp = false;
    break;
  }
  return super.surfaceTouchEvent(event);
}

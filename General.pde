boolean isTouchDown(MotionEvent event) {
  if (event.getAction() == event.ACTION_DOWN) {
    return true;
  } else return false;
}

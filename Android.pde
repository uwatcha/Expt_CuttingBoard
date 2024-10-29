@Override
  public boolean surfaceTouchEvent(MotionEvent event) {
  actionIdFromAndroid = event.getActionMasked();
  actionPosition[0] = event.getX(event.getPointerCount()-1);
  actionPosition[1] = event.getY(event.getPointerCount()-1);
  return super.surfaceTouchEvent(event);
}

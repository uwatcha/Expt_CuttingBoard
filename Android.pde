@Override
  public boolean surfaceTouchEvent(MotionEvent event) {
  actionID = event.getActionMasked();
  if (actionID==MotionEvent.ACTION_DOWN) {
    //println("surface Touch Down--------------------------------");
  }
  actionPosition[0] = event.getX(event.getPointerCount()-1);
  actionPosition[1] = event.getY(event.getPointerCount()-1);
  return super.surfaceTouchEvent(event);
}

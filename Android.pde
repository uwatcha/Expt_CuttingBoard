boolean isTouch, isTouchDown, isTouchUp, isPointerTouchDown, isPointerTouchUp;

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

@Override
  void onPause() {
  println("onPause()");
  println("isRunning: "+isRunning);
  super.onPause();
  isRunning = false;
  audioManager.stopMusic();
  println("isRunning: "+isRunning);
  // バックグラウンドに遷移したと判断する処理
  // 例: タイマーを開始し、一定時間後にonResume()が呼ばれなければバックグラウンドと判断
}

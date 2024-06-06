@Override
  public boolean surfaceTouchEvent(MotionEvent event) {
  points.clear();
  pIndex = event.getActionIndex();   //Pointer配列の位置
  pId = event.getPointerId( pIndex );//Pointer ID
  for (int i = 0; i < event.getPointerCount(); i++) {
    point = new PVector(event.getX(i), event.getY(i), event.getSize(i));
    points.add(point);
    count = event.getPointerCount();
    actionID = event.getAction();
    actionMASK = MotionEvent.ACTION_MASK;
  }

  if (event.getActionMasked() == MotionEvent.ACTION_UP) {
    points.clear();
  }

  switch (actionID/* & actionMASK*/) {  // タッチ UP/ DOWN / MOVE発生時のフラグ管理
  case MotionEvent.ACTION_POINTER_DOWN:
    touch_pdown = true;
    break;
  case MotionEvent.ACTION_DOWN:
    //pointx[pId] = point.x;
    touch_down = true;
    break;
  case MotionEvent.ACTION_UP:
    touch_up = true;
    break;
  case MotionEvent.ACTION_POINTER_UP:
    touch_pup = true;
    break;
  default:
    touch_pdown = touch_pup = touch_down = touch_up = false;
    break;
  }
  return super.surfaceTouchEvent(event);
}

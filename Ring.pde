//class Ring {
//  final private color COLOR = RING;
//  final private float INITIAL_RADIUS;
//  final private float STROKE = 12;
//  final private float SHRINK_SPEED;
//  final private int   JUST_FRAME;
//  private PVector coord;
//  private float radius;

//  public Ring(Note note, int showFrame, int justFrame) {
//    INITIAL_RADIUS = note.getRadius() * 4;
//    JUST_FRAME = justFrame;
//    coord = note.getcoord();
//    radius = INITIAL_RADIUS;
//    SHRINK_SPEED = (INITIAL_RADIUS-note.getRadius())/(justFrame-showFrame); //距離÷時間
//  }
  
//  public void killField() {
//    coord = null;
//  }

//  public void run() {
//    if (isActive()) {
//      shrink();
//      display();
//    }
//  }

//  private void display() {
//    displayRing(coord, radius, STROKE, COLOR);
//  }
//  private void shrink() {
//    radius -= SHRINK_SPEED;
//  }
//  private boolean isActive() {
//    return frame <= JUST_FRAME+BAD_FRAME;
//  }
//}

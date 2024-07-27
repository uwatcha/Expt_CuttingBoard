class NoteCreater {
  final private PVector coordinate;
  final private int showFrame;
  final private int justFrame;
  
  public NoteCreater(PVector coordinate, int showFrame, int justFrame) {
    this.coordinate = coordinate;
    this.showFrame = showFrame;
    this.justFrame = justFrame;
  }
  
  public NoteRunner create() {
    return new NoteRunner(coordinate, showFrame, justFrame);
  }
}

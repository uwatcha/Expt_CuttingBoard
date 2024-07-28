//これはテスト用に規則的にノーツを並べるためのもの
void noteSetup() {
  PVector coordinate;
  int showFrame, justFrame;

  for (int i=0; i<notes.length; i++) {
    if (i%2==0) {
      coordinate = new PVector(width/4, height/4);
      showFrame = 10 + i/2*150;
    } else {
      coordinate = new PVector(width/4, height*3/4);
      showFrame = 10 + i/2*150 + 20;
    }

    justFrame = showFrame+90;

    notes[i] = new NoteCreater(coordinate, showFrame, justFrame);
  }
}

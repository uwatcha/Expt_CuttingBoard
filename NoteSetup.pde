void makeNotes() {
  for (int i=0; i<notes.length; i++) {
    notes[i] = new NoteCreater(vectors.get(i%vectors.size()), showFrames.get(i), justFrames.get(i));
  }
}

void makeVectors() {
  vectors.add(new PVector(width/4, height/4));
  vectors.add(new PVector(width/4, height*3/4));
}

void makeShowFrames() {
  for (int i=0; i<notes.length; i++) {
    if (i%2==0) {
      showFrames.add(10 + i/2*150);
    } else {
      showFrames.add(10 + i/2*150 + 20);
    }
  }
}

void makeJustFrames() {
  for (Integer showFrame: showFrames) {
    justFrames.add(showFrame+90);
  }
}

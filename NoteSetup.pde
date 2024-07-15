void makeNotes() {
  for (int i=0; i<notes.length; i++) {
    notes[i] = new NoteRunner(this, vectors.get(i%vectors.size()), createFrames.get(i), justFrames.get(i));
  }
}

void makeVectors() {
  vectors.add(new PVector(width/4, height/4));
  vectors.add(new PVector(width/4, height*3/4));
}

void makeShowFrames() {
  for (int i=0; i<notes.length; i++) {
    if (i%2==0) {
      createFrames.add(10 + i/2*150);
    } else {
      createFrames.add(10 + i/2*150 + 20);
    }
  }
}

void makeJustFrames() {
  for (Integer createFrame: createFrames) {
    justFrames.add(createFrame+90);
  }
}

//これはテスト用に規則的にノーツを並べるためのもの
void noteSetup() {
  PVector coordinate;
  int showFrame, justFrame;

  for (int i=0; i<notes.length; i++) {
    if (i%2==0) {
      coordinate = new PVector(width*3/4, height/4);
      showFrame = 10 + i/2*150;
    } else {
      coordinate = new PVector(width*3/4, height*3/4);
      showFrame = 10 + i/2*150 + 10;
    }

    justFrame = showFrame+90;

    notes[i] = new NoteCreater(coordinate, showFrame, justFrame);
  }
}

//notesから現在のフレームで呼び出すノーツをrunningNotesに入れる。
void notesAddToRunningList() {
  for (int i=noteLoadIndex; i<notes.length; i++) {
    if (frame == notes[i].getShowFrame()) {
      runningNotes.add(notes[i].create());
    } else if (frame < notes[i].getShowFrame()) { //新しくfor文がはじまったときに、runningNotesに追加すべきnoteのインデックスを記録している。こうすることで、notesを毎回先頭からチェックしなくて良くなる。
      noteLoadIndex = i;
      break;
    }
  }
}

//runningNotesに表示期限を迎えたノーツがあれば削除する
void notesRunAndRemoveFromRunningList() {
  for (int i=0; i<runningNotes.size(); i++) {
    if (runningNotes.get(i).getKillFrame() < frame) {
      runningNotes.remove(runningNotes.get(i--));
      continue;
    } else {
      runningNotes.get(i).run();
    }
  }
}

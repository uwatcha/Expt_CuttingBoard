void playGoodSE() {
  for (int i=0; i<5; i++) {
    if (!goodSEPool[i].isPlaying()) {
      goodSEPool[i].play();
      break;
    }
  }
}
void playNiceSE() {
  for (int i=0; i<5; i++) {
    if (!niceSEPool[i].isPlaying()) {
      niceSEPool[i].play();
      break;
    }
  }
}
void playBadSE() {
  for (int i=0; i<10; i++) {
    if (!badSEPool[i].isPlaying()) {
      badSEPool[i].play();
      break;
    }
  }
}
void playHitSE() {
  for (int i=0; i<5; i++) {
    if (!hitSEPool[i].isPlaying()) {
      hitSEPool[i].play();
      break;
    }
  }
}

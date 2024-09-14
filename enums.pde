enum Judgment {
  Good,
  Nice,
  Bad, 
  None
}

// draw()内でswitch()で画面を切り替えるため
enum Screen {
  Title,
  Settings,
  Playing
}

enum Field {
  TouchTiming,
  CorrectTiming,
  TimingDiff,
  Judgment,
  TouchAction,
  TouchPositionX,
  TouchPositionY
}

enum Judgment {
  Good,
  Nice,
  Bad, 
  None
}

enum ScreenType {
  Title,
  Settings,
  Interval,
  Playing,
  Pause
}

enum Field {
  Action,
  ActualTiming,
  TargetTiming,
  TimingDiff,
  Judgment,
  TouchAction,
  TouchPositionX,
  TouchPositionY
}

enum Fruit {
  APPLE("赤"),
  BANANA("黄色"),
  GRAPE("紫");

  private final String csolor;

  Fruit(String coslor) {
    this.csolor = coslor;
  }

  public String getColor() {
    return csolor;
  }
}

enum Action {
  Down,
  Up,
  Other
}

class Waypoint {
  private final PVector location;
  private final boolean endpoint; // ex. waypoints inside the train, exits from the platform
  // we want different waypoints for people entering the train than exiting the train
  private final Intention intention;
  private ArrayList<Waypoint> nextOptions;
  
  Waypoint (PVector location, Intention intention, boolean endpoint) {
    this.location = location;
    this.endpoint = endpoint;
    this.intention = intention;
    this.nextOptions = new ArrayList<Waypoint>();
  }
  
  void addNextOption(Waypoint that) {
    this.nextOptions.add(that);
  }
  
  void draw() {
    noStroke();
    circle(this.location.x, this.location.y, 8);
    switch(this.intention) {
      case ENTERING:
      fill(0, 255, 0, 75); break;
      case EXITING:
      fill(255, 0, 0, 75); break;
      default:
      throw new RuntimeException("why?");
    }
    System.out.println(this.location);
  }
}

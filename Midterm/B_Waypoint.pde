class Waypoint {
  PVector location;
  boolean endpoint; // ex. waypoints inside the train, exits from the platform
  // we want different waypoints for people entering the train than exiting the train
  Intention intention;
  ArrayList<Waypoint> nextOptions;
  
  Waypoint (PVector location, Intention intention, boolean endpoint) {
    this.location = location;
    this.endpoint = endpoint;
    this.intention = intention;
    this.nextOptions = new ArrayList<Waypoint>();
  }
  
  void addNextOption(Waypoint that) {
    this.nextOptions.add(that);
  }
}

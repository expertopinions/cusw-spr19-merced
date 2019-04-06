/* Behavior questions
 * what should happen if a stationary person is pushed into or out of the train?
 */

class Person {
  private PVector location, velocity, acceleration;
  private final float radius; // TODO: and personalSpaceIndex
  private Intention intention;
  private Waypoint nearestWaypoint;
  private boolean inTrain;
  // whether the Person is currently trying to enter/exit the train
  
  Person(Intention intention, boolean inTrain, HashSet<Waypoint> waypoints) {
    this.intention = intention;
    this.inTrain = inTrain;
    
    this.radius = 4;
    this.location = spawn();
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
    
    this.nearestWaypoint = this.findFirstWaypoint(waypoints);
  }
  
  /**
   * Finds a place to spawn this Person.
   */
  PVector spawn() {
    if (inTrain) {
      return train.getRandomLocation(radius);
    }
    else return platform.getRandomLocation(radius);
  }
  
  /**
   * Finds the closest waypoint to the initial location of the Person.
   * Requires that waypoints is non-empty
   */
  Waypoint findFirstWaypoint(HashSet<Waypoint> waypoints) {
    float smallestDistance = Float.POSITIVE_INFINITY;
    Waypoint nearestWaypoint = null;
    
    for (Waypoint w : waypoints) {
      if (! (w.intention == this.intention)) {
        continue;
      }
      float distance = dist(this.location.x, this.location.y, w.location.x, w.location.y);
      if (distance < smallestDistance) {
        smallestDistance = distance;
        nearestWaypoint = w;
      }
    }
    
    return nearestWaypoint;
  }
  
  Waypoint findNextWaypoint() {
    if (nearestWaypoint.endpoint || nearestWaypoint == null || intention == Intention.STATIONARY) {
      intention = Intention.STATIONARY;
      return null;
    }
    
    ArrayList<Waypoint> waypoints = nearestWaypoint.nextOptions;
    int numWaypoints = waypoints.size();
    return waypoints.get((int)random(numWaypoints));
  }
  
  void setLocation(float dx, float dy) {
    this.location.x = dx;
    this.location.y = dy;
  }
  
  void setVelocity(float vx, float vy) {
    this.velocity.x = vx;
    this.velocity.y = vy;
  }
  
  void setAcceleration(float ax, float ay) {
    this.acceleration.x = ax;
    this.acceleration.y = ay;
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
  }
  
  void draw() {
    circle(location.x, location.y, radius);
    switch(this.intention) {
      case ENTERING:
      stroke(0, 255, 255);
      case EXITING:
      stroke(255, 206, 0);
      default:
      stroke(200);
    }
    fill(0);
    circle(location.x, location.y, radius);
  }
}

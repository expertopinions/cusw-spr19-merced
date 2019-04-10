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
  
  Person(Intention intention, boolean inTrain, ArrayList<Waypoint> waypoints) {
    this.intention = intention;
    this.inTrain = inTrain;
    
    this.radius = 30;
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
  Waypoint findFirstWaypoint(ArrayList<Waypoint> waypoints) {
    float smallestDistance = Float.POSITIVE_INFINITY;
    Waypoint nearestWaypoint = null;
    
    for (Waypoint w : waypoints) {
      if (! (w.intention == this.intention && w.type == WaypointType.START) ) {
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
    if (nearestWaypoint.type == WaypointType.END ||
        nearestWaypoint == null ||
        intention == Intention.STATIONARY) {
      intention = Intention.STATIONARY;
      return null;
    }
    
    ArrayList<Waypoint> nextWaypoints = nearestWaypoint.nextOptions;
    int index = (int)random(nextWaypoints.size());
    return nextWaypoints.get(index);
  }
  
  void updateWaypoint() {
    if (nearestWaypoint == null) return;
    
    float distanceToWaypoint = dist(location.x, location.y,
            nearestWaypoint.location.x, nearestWaypoint.location.y);
    if (distanceToWaypoint < radius) {
      nearestWaypoint = findNextWaypoint();
    }
  }
  
  void collisionDetection(ArrayList<Person> people, Train train) {
    
    for (Person p : people) {
      if (p == this) continue;
      
      if (this.location.dist(p.location) < 2 * radius) {
        PVector displacement = this.displacementVector(p.location);
        PVector force = displacement.setMag(300/displacement.magSq());
        this.acceleration.sub(force);
      }
    }
    
    PVector nearestTrainPoint = train.nearestPointOnTrain(this.location);
    if (this.location.dist(nearestTrainPoint) < 1.1 * radius) {
      PVector displacement = this.displacementVector(nearestTrainPoint);
      PVector force = displacement.setMag(50/displacement.magSq());
      this.acceleration.sub(force);
    }
  }
  
  void defaultVelocity() {
    if (intention == Intention.STATIONARY) {
      this.velocity = new PVector(0,0);
    }
    else {
      PVector displacement = this.displacementVector(this.nearestWaypoint.location);
      this.velocity = displacement.setMag(1);
    }
  }
  
  /**
   * Switches the intention of a person if they've been accidentally booted into
   * or out of a train
   */
  private void switchIntention(boolean actuallyInTrain) {
    if (inTrain == actuallyInTrain) return;
    
    else if (intention == Intention.STATIONARY && actuallyInTrain) {
      intention = Intention.EXITING;
      nearestWaypoint = findFirstWaypoint(waypoints);
    }
    
    else if (intention == Intention.STATIONARY && ! actuallyInTrain) {
      intention = Intention.ENTERING;
      nearestWaypoint = findFirstWaypoint(waypoints);
    }
  }
  
  PVector displacementVector(PVector that) {
    float dx = that.x - this.location.x;
    float dy = that.y - this.location.y;
    return new PVector(dx, dy);
  }
  
  void update(ArrayList<Person> people, Train train) {
    // reset acceleration before applying all the forces
    this.acceleration = new PVector(0,0);
    defaultVelocity();
    collisionDetection(people, train);
    velocity.add(acceleration);
    location.add(velocity);
    updateWaypoint();
    
    boolean actuallyInTrain = train.contains(this.location);
    switchIntention(actuallyInTrain);
    inTrain = actuallyInTrain;
  }
  
  void draw() {
    strokeWeight(3);
    switch(this.intention) {
      case STATIONARY:
      stroke(200); break;
      case ENTERING:
      stroke(0, 255, 255); break;
      case EXITING:
      stroke(255, 206, 0); break;
      default:
      break;
    }
    fill(0);
    circle(location.x, location.y, radius);
  }
}

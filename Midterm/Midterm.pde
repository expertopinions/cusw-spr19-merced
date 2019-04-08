import java.util.HashSet;

ArrayList<Waypoint> waypoints = new ArrayList<Waypoint>();
public ArrayList<Person> people;
public Train train;
public Platform platform;

void setup() {
  train = getTrain();
  platform = getPlatform();
  waypoints = getWaypoints();
  people = getPeople();
  System.out.println(waypoints.get(16).location);
  System.out.println(waypoints.get(18).location);
}

//int frames = 0;
void draw() {
  background(0); //<>//
  int index = 0;
  for (Waypoint w : waypoints) {
    print(index + " " + w.intention + " ");
    w.draw();
    index++;
  }
  train.draw();
  //int persons = 0;
  //for (Person p : people) {
  //  //System.out.println(frames + " " + persons);
  //  p.draw();
  //  //persons++;
  //}
  //frames++;
}

void settings() {
  smooth(4);
  size(800, 600);
}

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
}

//int frames = 0;
void draw() {
  background(0);
  for (Waypoint w : waypoints) {
    w.draw();
  }
  
  for (Person p : people) {
    p.draw();
  }
  
  train.draw();
}

void settings() {
  smooth(4);
  size(800, 600);
}

import java.util.HashSet;

HashSet<Waypoint> waypoints = new HashSet<Waypoint>();
public ArrayList<Person> people;
public Train train;
public Platform platform;

void setup() {
  size(800, 600);
  train = getTrain();
  platform = getPlatform();
  System.out.println(train.points.size());
}

void draw() {
  background(0);
  train.draw();
}

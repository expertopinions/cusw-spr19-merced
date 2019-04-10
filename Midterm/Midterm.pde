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

int frames = 0;
void draw() {
  int stillMoving = 0;
  background(0);
  for (Waypoint w : waypoints) {
    w.draw();
  }
  
  for (Person p : people) {
    p.update(people, train);
  }
  
  for (Person p : people) {
    p.draw();
    stillMoving += p.intention == Intention.ENTERING ? 1 : 0;
  }
  
  train.draw();
  
  PFont f = createFont("Monaco", 18, true);
  textFont(f, 18);
  textAlign(LEFT);
  fill(255);
  text("time: " + frames / 3600 + "'" + String.format("%02d", frames / 60)
    + "\"" + String.format("%02d", frames % 60) + "f" , 0, 575);
  
  if (stillMoving > 0) frames++;
}

void settings() {
  smooth(4);
  size(800, 600);
}

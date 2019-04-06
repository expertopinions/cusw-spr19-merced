import java.util.HashSet;

HashSet<Waypoint> waypoints = new HashSet<Waypoint>();
public ArrayList<Person> people;
public Train train;
public Platform platform;

void setup() {
  size(800, 600);
  ArrayList<ArrayList<PVector>> openings = new ArrayList<ArrayList<PVector>>();
  ArrayList<PVector> opening1 = new ArrayList<PVector>();
  opening1.add(new PVector(200, 200));
  opening1.add(new PVector(300, 200));
  openings.add(opening1);
  train = new Train(new PVector(100, 100), new PVector(500, 200), openings);
  System.out.println(train.points.size());
  
  Waypoint w = new Waypoint(new PVector(250, 210), Intention.EXITING, false);
  waypoints.add(w);
  people.add(new Person(Intention.EXITING, true, waypoints));
}

void draw() {
  background(0);
  train.draw();
  for (Person p : people) {
    p.draw();
  }
}

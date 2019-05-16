import java.util.HashSet;

ArrayList<Waypoint> waypoints = new ArrayList<Waypoint>();
public ArrayList<Person> people;
public Train train;
public SpawnZones spawnZones;
// waits for all people to exit the train before entering
public boolean patient = true;
// walks toward the center of the train
public boolean courteous = false;

void setup() {
  train = getTrain();
  spawnZones = getSpawnZones(patient);
  waypoints = getWaypoints();
  people = getPeopleControlled();
}

int frames = 0;
int anim = 0;
void draw() {
  int stillEntering = 0;
  background(255);
  //for (Waypoint w : waypoints) {
  //  w.draw();
  //}

  for (Person p : people) {
    p.update(people, train);
  }

  for (Person p : people) {
    p.draw();
    boolean wrongPlace = (p.intention == Intention.ENTERING && ! p.inTrain)
                      || (p.intention == Intention.EXITING && p.inTrain);
    stillEntering += (wrongPlace) ? 1 : 0;
  }

  train.draw();

  PFont f = createFont("Helvetica Neue", 18, true);
  textFont(f, 18);
  textAlign(LEFT);
  fill(0);
  //text(frames / 3600 + "'" + String.format("%02d", frames / 60)
  //  + "\"" + String.format("%02d", frames % 60) + "f", 100, 50);
  text("frames: " + frames, 100, 50);

  if (stillEntering > 0) frames++;
  
  saveFrame("frames/"+String.format("%04d",anim)+".tga");
  anim++;
}

void settings() {
  smooth(4);
  size(800, 400);
}

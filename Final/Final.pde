import java.util.HashSet;

ArrayList<Waypoint> waypoints = new ArrayList<Waypoint>();
public ArrayList<Person> people;
public Train train;
public SpawnZones spawnZones;
// waits for all people to exit the train before entering
public boolean patient;
public boolean PATIENT_DEFAULT = false;
// walks toward the center of the train
public boolean courteous;

boolean run;  // run simulation
boolean step; // run simulation only one step
boolean saveFrames; // save images to file
int frames;
int anim;

void init(boolean _patient) {
  // waits for all people to exit the train before entering
  patient = _patient;
  // walks toward the center of the train
  courteous = false;

  train = getTrain();
  spawnZones = getSpawnZones(patient);
  waypoints = getWaypoints();
  people = getPeopleControlled();
  
  frames = 0;
  anim = 0;
  
  toggleRun(false);
  toggleStep(false);
  toggleSaveFrames(false);
}

void setup() {
  init(PATIENT_DEFAULT);
}


void draw() {
  int stillEntering = 0;
  background(255);
  //for (Waypoint w : waypoints) {
  //  w.draw();
  //}

  if(run || step) {
    for (Person p : people) {
      p.update(people, train);
    }
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
  
  if(run || step) {
    
    if(stillEntering > 0) 
      frames++;
  
    if(saveFrames) {
      saveFrame("frames/"+String.format("%04d",anim)+".tga");
      anim++;
    }
    
    toggleStep(false);
  }
}

void settings() {
  smooth(4);
  size(800, 400);
}

void keyPressed() {
  switch(key) {
    case '1':
      println("Set up impatient people");
      init(false);
      break;
    case '2':
      println("Set up patient people");
      init(true);
      break;
    case 'r':
      toggleRun(!run);
      break;
    case 't':
      toggleStep(!step);
      break;
    case 's':
      toggleSaveFrames(!saveFrames);
      break;
  }
}

void toggleSaveFrames(boolean _saveFrames) {
  saveFrames = _saveFrames;
  println("Saving Frames: " + saveFrames);
}

void toggleRun(boolean _run) {
  run = _run;
  println("Run Simulation: " + run);
}

void toggleStep(boolean _step) {
  step = _step;
  println("Step Simulation: " + step);
}

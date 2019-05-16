Train getTrain() {
  ArrayList<ArrayList<PVector>> openings = getOpenings();
  return new Train(new PVector(100, 100), new PVector(700, 200), openings);
}

Platform getPlatform() {
  return new Platform(new PVector(100, 200), new PVector(700, 300));
}

SpawnZones getSpawnZones(boolean patient) {
  SpawnZones result = new SpawnZones();
  if (patient) {
    result.add(getPlatform());
    return result;
  }
  else {
    result.add(new Platform(new PVector(85, 200), new PVector(175, 300)));
    result.add(new Platform(new PVector(255, 200), new PVector(360, 300)));
    result.add(new Platform(new PVector(440, 200), new PVector(545, 300)));
    result.add(new Platform(new PVector(625, 200), new PVector(725, 300)));
    return result;
  }
}

ArrayList<ArrayList<PVector>> getOpenings() {
  ArrayList<ArrayList<PVector>> openings = new ArrayList<ArrayList<PVector>>();

  ArrayList<PVector> opening1 = new ArrayList<PVector>();
  opening1.add(new PVector(360, 200));
  opening1.add(new PVector(440, 200));
  openings.add(opening1);

  ArrayList<PVector> opening2 = new ArrayList<PVector>();
  opening2.add(new PVector(175, 200));
  opening2.add(new PVector(255, 200));
  openings.add(opening2);

  ArrayList<PVector> opening3 = new ArrayList<PVector>();
  opening3.add(new PVector(545, 200));
  opening3.add(new PVector(625, 200));
  openings.add(opening3);

  return openings;
}

ArrayList<Waypoint> getWaypointsSmall() {
  ArrayList<Waypoint> waypointList = new ArrayList<Waypoint>();

  Waypoint w0 = new Waypoint(new PVector(215, 190), Intention.EXITING, WaypointType.START);
  Waypoint w1 = new Waypoint(new PVector(400, 190), Intention.ENTERING, WaypointType.START);
  waypointList.add(w0); // 0
  waypointList.add(w1); // 1

  return waypointList;
}

ArrayList<Person> getPeopleSmall() {
  ArrayList<Person> people = new ArrayList<Person>();
  people.add(new Person(Intention.ENTERING, false, waypoints, patient));
  people.add(new Person(Intention.ENTERING, false, waypoints, patient));
  return people;
}

ArrayList<Waypoint> getWaypoints() {
  ArrayList<Waypoint> waypointList = new ArrayList<Waypoint>();

  // waypoints just before the entrance
  waypointList.add(new Waypoint(new PVector(205, 190), Intention.ENTERING, WaypointType.START)); // 0
  waypointList.add(new Waypoint(new PVector(390, 190), Intention.ENTERING, WaypointType.START)); // 1
  waypointList.add(new Waypoint(new PVector(575, 190), Intention.ENTERING, WaypointType.START)); // 2

  // waypoints just after the entrance
  waypointList.add(new Waypoint(new PVector(225, 210), Intention.EXITING, WaypointType.START)); // 3
  waypointList.add(new Waypoint(new PVector(410, 210), Intention.EXITING, WaypointType.START));
  waypointList.add(new Waypoint(new PVector(595, 210), Intention.EXITING, WaypointType.START));

  // waypoints well into the entrance
  waypointList.add(new Waypoint(new PVector(215, 150), Intention.ENTERING, WaypointType.MIDDLE)); // 6
  waypointList.add(new Waypoint(new PVector(400, 150), Intention.ENTERING, WaypointType.MIDDLE));
  waypointList.add(new Waypoint(new PVector(585, 150), Intention.ENTERING, WaypointType.MIDDLE));

  // waypoints for people in the train to get out of the way
  waypointList.add(new Waypoint(new PVector(150, 115), Intention.ENTERING, WaypointType.END)); // 9
  waypointList.add(new Waypoint(new PVector(308, 115), Intention.ENTERING, WaypointType.END));
  waypointList.add(new Waypoint(new PVector(492, 115), Intention.ENTERING, WaypointType.END));
  waypointList.add(new Waypoint(new PVector(650, 115), Intention.ENTERING, WaypointType.END));

  // waypoints well into the platform
  waypointList.add(new Waypoint(new PVector(215, 280), Intention.EXITING, WaypointType.MIDDLE)); // 13
  waypointList.add(new Waypoint(new PVector(400, 280), Intention.EXITING, WaypointType.MIDDLE));
  waypointList.add(new Waypoint(new PVector(585, 280), Intention.EXITING, WaypointType.MIDDLE));

  // waypoints to "exit" the platform
  waypointList.add(new Waypoint(new PVector(100, 325), Intention.EXITING, WaypointType.END)); // 16
  waypointList.add(new Waypoint(new PVector(400, 325), Intention.EXITING, WaypointType.END));
  waypointList.add(new Waypoint(new PVector(700, 325), Intention.EXITING, WaypointType.END));

  // more waypoints for people in the train to get out of the way
  waypointList.add(new Waypoint(new PVector(150, 185), Intention.ENTERING, WaypointType.END)); // 19
  waypointList.add(new Waypoint(new PVector(308, 185), Intention.ENTERING, WaypointType.END));
  waypointList.add(new Waypoint(new PVector(492, 185), Intention.ENTERING, WaypointType.END));
  waypointList.add(new Waypoint(new PVector(650, 185), Intention.ENTERING, WaypointType.END));

  if (! courteous) {
  // waypoints for people who suck
    waypointList.add(new Waypoint(new PVector(200, 150), Intention.ENTERING, WaypointType.END)); // 23
    waypointList.add(new Waypoint(new PVector(230, 150), Intention.ENTERING, WaypointType.END));
    waypointList.add(new Waypoint(new PVector(385, 150), Intention.ENTERING, WaypointType.END));
    waypointList.add(new Waypoint(new PVector(415, 150), Intention.ENTERING, WaypointType.END));
    waypointList.add(new Waypoint(new PVector(570, 150), Intention.ENTERING, WaypointType.END));
    waypointList.add(new Waypoint(new PVector(600, 150), Intention.ENTERING, WaypointType.END));
  }


  // linking the waypoints using a whole host of magic numbers
  waypointList.get(0).addNextOption(waypointList.get(6));
  waypointList.get(1).addNextOption(waypointList.get(7));
  waypointList.get(2).addNextOption(waypointList.get(8));

  waypointList.get(3).addNextOption(waypointList.get(13));
  waypointList.get(4).addNextOption(waypointList.get(14));
  waypointList.get(5).addNextOption(waypointList.get(15));

  waypointList.get(6).addNextOption(waypointList.get(9));
  waypointList.get(6).addNextOption(waypointList.get(10));
  waypointList.get(7).addNextOption(waypointList.get(10));
  waypointList.get(7).addNextOption(waypointList.get(11));
  waypointList.get(8).addNextOption(waypointList.get(11));
  waypointList.get(8).addNextOption(waypointList.get(12));

  waypointList.get(13).addNextOption(waypointList.get(16));
  waypointList.get(14).addNextOption(waypointList.get(17));
  waypointList.get(15).addNextOption(waypointList.get(18));

  waypointList.get(6).addNextOption(waypointList.get(19));
  waypointList.get(6).addNextOption(waypointList.get(20));
  waypointList.get(7).addNextOption(waypointList.get(20));
  waypointList.get(7).addNextOption(waypointList.get(21));
  waypointList.get(8).addNextOption(waypointList.get(21));
  waypointList.get(8).addNextOption(waypointList.get(22));
  
  if (! courteous) {
    waypointList.get(6).addNextOption(waypointList.get(23));
    waypointList.get(6).addNextOption(waypointList.get(24));
    waypointList.get(7).addNextOption(waypointList.get(25));
    waypointList.get(7).addNextOption(waypointList.get(26));
    waypointList.get(8).addNextOption(waypointList.get(27));
    waypointList.get(8).addNextOption(waypointList.get(28));
  }

  return waypointList;
}

ArrayList<Person> getPeople() {
  return getPeople(20, 20, .5, .5);
}

ArrayList<Person> getPeople(int numInTrain, int numOutsideTrain, double p_exit, double p_enter) {
  ArrayList<Person> people = new ArrayList<Person>();

  for (int i = 0; i < numInTrain; i++) {
    Intention intention;
    if (p_exit > random(1)) {
      intention = Intention.EXITING;
    } else intention = Intention.STATIONARY;

    people.add(new Person(intention, true, waypoints, patient));
  }

  for (int i = 0; i < numOutsideTrain; i++) {
    Intention intention;
    if (p_enter > random(1)) {
      intention = Intention.ENTERING;
    } else intention = Intention.STATIONARY;

    people.add(new Person(intention, false, waypoints, patient));
  }

  return people;
}

ArrayList<Person> getPeopleControlled() {
  ArrayList<Person> people = new ArrayList<Person>();
  
  int[] xs = {115, 155, 270, 330, 465, 505, 640, 680};
  int[] ys = {118, 149, 182, 218, 249, 282};
  
  for (int x : xs) {
    for (int y : ys) {
      Intention intention;
      boolean inTrain = y < 200;
      if (x > 115 && x < 680 && inTrain) intention = Intention.EXITING;
      else if (x > 115 && x < 680) intention = Intention.ENTERING;
      else intention = Intention.STATIONARY;
      
      people.add(new Person(intention, inTrain, waypoints, patient, new PVector(x,y)));
    }
  }
  
  return people;
}

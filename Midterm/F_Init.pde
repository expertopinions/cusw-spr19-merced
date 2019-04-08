Train getTrain() {
  ArrayList<ArrayList<PVector>> openings = getOpenings();
  return new Train(new PVector(100, 100), new PVector(700, 200), openings);
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

Platform getPlatform() {
  return new Platform(new PVector(100, 200), new PVector(700, 600));
}

HashSet<Waypoint> getWaypoints() {
  HashSet<Waypoint> result = new HashSet<Waypoint>();
  
  return result;
}

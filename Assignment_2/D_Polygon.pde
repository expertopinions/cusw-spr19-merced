ArrayList<Polygon> polygons;

class Polygon {
  PShape p;
  ArrayList<PVector> coordinates;
  
  Polygon() {
    coordinates = new ArrayList<PVector>();
  }  
  
  Polygon(ArrayList<PVector> coords) {
    coordinates = coords;
    makeShape();
  }
  
  void makeShape() {
    p = createShape();
    p.beginShape();
    p.fill(0);
    p.strokeWeight(.5);
    p.stroke(255);
    for (PVector c : coordinates) {
      PVector screenLocation = map.getScreenLocation(c);
      p.vertex(screenLocation.x, screenLocation.y);
    }
    p.endShape();
  }
  
  void draw() {
    shape(p, 0, 0);
  }
}

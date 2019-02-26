ArrayList<POI> pois;

class POI{
  // coordinate
  private PVector coord;
  
  // lat/lon vals
  private float lat;
  private float lon;
  
  POI(float _lat, float _lon) {
    this.lat = _lat;
    this.lon = _lon;
    coord = new PVector(lat, lon);
  }
  
  void draw() {
    PVector screenLocation = map.getScreenLocation(coord);
    noStroke();
    fill(poiFill);
    circle(screenLocation.x, screenLocation.y, 6);
  }
}

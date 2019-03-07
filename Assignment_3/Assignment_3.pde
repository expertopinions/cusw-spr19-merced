// partial cook county coordinates
// -87.81 to -87.52 long, 41.74 to 42.16 lat
// score: B08301e2 / B08301e1 (proportion of people who took a car, truck or van to work)

ArrayList<Polygon> blockGroupPolygons;
PVector chicagoCoord = new PVector(41.87, -87.63);
PVector chicagoLocation;
MercatorMap map;

void setup() {
  blockGroupPolygons = new ArrayList<Polygon>();
  size(600, 800);
  map = new MercatorMap(width, height, 42.16, 41.74, -87.81, -87.52, 0);
  chicagoLocation = map.getScreenLocation(chicagoCoord);
  loadData();
  parseData();
}

void draw() {
  
  background(128);
  for (Polygon p : blockGroupPolygons) {
    p.draw();
  }
  
  drawInfo();
  
  fill(255);
  text("Chicago", chicagoLocation.x, chicagoLocation.y);
}

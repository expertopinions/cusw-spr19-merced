// This is heavily based on the code from Tutorial 2 

//First make a blank map 
MercatorMap map;
PImage background;
boolean showBus = false;
boolean showMetro = false;
boolean showBicycle = false;

void setup(){
  size(920, 660);
  
  //Intiailize your data structures early in setup 
  map = new MercatorMap(width, height, 45.51759, 45.51171, -73.56649, -73.55480, 0);
  pois = new ArrayList<POI>();
  polygons = new ArrayList<Polygon>();
  ways = new ArrayList<Way>();
  
  loadData();
  parseData();
}

void draw(){
  image(background, 0, 0);
  
  for (Way w : ways) {
    if (w.type.equals("bus") && showBus) {
      w.draw();
    }
    if (w.type.contains("line") && showMetro) {
      w.draw();
    }
    if (w.type.contains("bicycle") && showBicycle) {
      w.draw();
    }
  }
  
  drawInfo();
}

void keyPressed() {
  if (key == 'b') { // bus route
    showBus = !showBus;
  }
  if (key == 's') { // subway route
    showMetro = !showMetro;
  }
  if (key == 'c') { // bicycle route
    showBicycle = !showBicycle;
  }
}

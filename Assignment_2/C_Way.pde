ArrayList<Way> ways; 

class Way{
  ArrayList<PVector> coordinates;
  private String type;
  
  Way(ArrayList<PVector> coords, String type) {
    coordinates = coords;
    this.type = type;
  }
  
  void draw() {
    strokeWeight(4);
    
    if (type.equals("bus")) stroke(busFill);
    else if (type.equals("green line")) stroke(greenFill);
    else if (type.equals("orange line")) stroke(orangeFill);
    else if (type.equals("yellow line")) stroke(yellowFill);
    else if (type.equals("bicycle")) stroke(bicycleFill);
    
    for (int i = 0; i < coordinates.size()-1; i++) {
      PVector screenStart = map.getScreenLocation(coordinates.get(i));
      PVector screenEnd = map.getScreenLocation(coordinates.get(i+1));
      line(screenStart.x, screenStart.y, screenEnd.x, screenEnd.y);
    }
    noStroke(); // prevents strokes around everything that's not a road
  }
}

class Person {
  
  String name;
  String year;
  PVector screenLocation;
  final int diameter = 30;
  boolean locked;
  
  Person(String _name, String _year) {
    this.name = _name;
    this.year = _year;
    screenLocation = new PVector(width/2, height/2);
  }
  
  void randomLocation() {
    screenLocation = new PVector(random(width), random(height));
  }
  
  float cursorDistanceSquared() {
    float xDistance = abs(mouseX - screenLocation.x);
    float yDistance = abs(mouseY - screenLocation.y);
    return pow(xDistance, 2) + pow(yDistance, 2);
  }
  
  boolean hoverEvent() {
    float radiusSquared = pow(diameter / 2, 2);
    if (cursorDistanceSquared() < radiusSquared) {
      return true;
    }
    return false;
  }
  
  boolean checkSelection() {
    locked = hoverEvent();
    return locked;
  }
  
  void update() {
    if (locked) {
      screenLocation = new PVector(mouseX, mouseY);
    }
  }
  
  void draw() {
    noStroke();
    if (hoverEvent()) {
      fill(230, 195, 80);
    }
    else {
      fill(30);
    }
    
    ellipse(screenLocation.x, screenLocation.y, diameter, diameter);
    
    text(name + "\nYear: " + year, screenLocation.x + 20, screenLocation.y + 30);
  }
    
}

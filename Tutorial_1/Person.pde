class Person {
  
  String name;
  String year;
  PVector screenLocation;
  
  Person(String _name, String _year) {
    name = _name;
    year = _year;
    screenLocation = new PVector(width/2, height/2);
  }
  
  void randomLocation() {
    screenLocation = new PVector(random(width), random(height));
  }
  
  void draw() {
    noStroke();
    fill(30);
    
    ellipse(screenLocation.x, screenLocation.y, 30, 30);
    
    text(name + "\nYear: " + year, screenLocation.x + 20, screenLocation.y + 30);
  }
    
}

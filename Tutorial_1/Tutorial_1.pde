ArrayList<Person> people;
ArrayList<Connection> friends;
 
 void setup() {
   size(800, 600);
   initialize();
 }
 
 void draw() {
   background(128);
   //noStroke();
   //fill(192);
   //ellipse(mouseX,mouseY,mouseX,mouseY);
   
   for (Person p : people) {
     p.update();
     p.draw();
   }
   
   for (Connection c : friends) {
     c.draw();
   }
 }
 
 void initialize() {
   people = new ArrayList<Person>();
   friends = new ArrayList<Connection>();
   
   for (int i = 0; i < 10; i++) {
     Person p = new Person("Person " + i, str(int(random(1,5))));
     p.randomLocation();
     people.add(p);
   }
   
   for (Person origin : people) {
     for (Person destination : people) {
       if (origin.year.equals(destination.year) && !origin.name.equals(destination.name)) {
         Connection c = new Connection(origin, destination, "frand");
         friends.add(c);
       }
     }
   }
 }
 
 void mousePressed() {
   for (Person p : people) {
     if (p.checkSelection()) {
       break;
     }
   }
 }
 
 void mouseReleased() {
   for (Person p : people) {
     p.locked = false;
   }
 }
 
 void keyPressed() {
   initialize();
 }

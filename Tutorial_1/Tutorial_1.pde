ArrayList<Person> people;
 
 void setup() {
   size(800, 600);
   
   people = new ArrayList<Person>();
   
   for (int i = 0; i < 10; i++) {
     Person p = new Person("Person " + i, str(int(random(1,5))));
     p.randomLocation();
     people.add(p);
   }
 }
 
 void draw() {
   background(128);
   
   noStroke();
   fill(192);
   ellipse(mouseX,mouseY,mouseX,mouseY);
   
   for (Person p : people) {
     p.draw();
   }
 }

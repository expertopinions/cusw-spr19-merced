float hue = 0;
float saturation = 0;
float value = 1;

void setup() {
  size(640,360);
}

void draw() {
  colorMode(HSB, 1.0);
  background(0);
  
  PFont f = createFont("Monaco", 128, true);
  textFont(f, 128);
  textAlign(CENTER);
  text(hour() + ":" + String.format("%02d", minute())
  + ":" + String.format("%02d", second()), width/2, height/2+32);
  
  PFont g = createFont("Monaco", 12, true);
  textFont(g, 12);
  textAlign(LEFT);
  text("hue: " + hue + "  saturation: " + saturation + " value: " + value, 0, height-3);
}

void keyPressed() {
  if (key == 'r') { // clock turns red
    hue = 0;
    saturation = 1;
    value = 1;
    fill(hue, saturation, value);
  }
  else if (key == 'g') { // clock turns green
    hue = .33;
    saturation = 1;
    value = .75;
    fill(hue, saturation, value);
  }
  else if (key == 'b') { // clock turns blue
    hue = 228./360;
    saturation = .88;
    value = 1;
    fill(hue, saturation, value);
  }
  else if (key == 'w') { // clock turns white
    hue = 0;
    saturation = 0;
    value = 1;
    fill(hue, saturation, value);
  }
  else if (key == 'c') {
    // while c is pressed, hue & saturation are controlled by mouse
    hue = norm(mouseX, 0, width);
    saturation = norm(mouseY, 0, height);
    value = 1.;
    fill(hue, saturation, value);
  }
}

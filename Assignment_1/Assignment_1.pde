void setup() {
  size(640,360);
}

void draw() {
  background(0);
  
  PFont f = createFont("Monaco", 128, true);
  textFont(f, 128);
  textAlign(CENTER);
  text(hour() + ":" + String.format("%02d", minute())
  + ":" + String.format("%02d", second()), width/2, height/2+32);
}

void keyTyped() {
  if (key == 'r') {
    colorMode(RGB);
    fill(255,0,0);
  }
  else if (key == 'g') {
    colorMode(RGB);
    fill(0,192,0);
  }
  else if (key == 'b') {
    colorMode(RGB);
    fill(30,75,255);
  }
  else if (key == 'w') {
    colorMode(RGB);
    fill(255);
  }
  else if (key == 'c') {
    colorMode(HSB, 1.0);
    float hue = norm(mouseX, 0, displayWidth);
    float saturation = norm(mouseY, 0, displayHeight);
    fill(hue, saturation*.5, 1.);
  }
}

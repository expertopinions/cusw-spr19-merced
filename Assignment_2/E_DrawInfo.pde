color poiFill = color(255, 99, 71);
color busFill = color(0, 192, 255);
color greenFill = color(0, 192, 0);
color orangeFill = color(255, 128, 0);
color yellowFill = color(255, 255, 0);
color bicycleFill = color(255, 0, 170);
color roadColor = color(128);

void drawInfo(){
  fill(0);
  rect(20, 20, 125, 110);
  textSize(16);
  fill(busFill);
  text("Bus Route (b)", 25, 40);
  fill(greenFill);
  text("Green Line (s)", 25, 60);
  fill(yellowFill);
  text("Yellow Line (s)", 25, 80);
  fill(orangeFill);
  text("Orange Line (s)", 25, 100);
  fill(bicycleFill);
  text("Bicycle Path (c)", 25, 120);
}

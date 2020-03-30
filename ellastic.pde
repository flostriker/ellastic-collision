Pop ballen;

float kinetischeEnergie = 0;

void setup() {
  size(600, 600);
  ballen = new Pop(2);
  ballen.veranderMassa(0, 10000);
  ballen.veranderMassa(1, 200);
}

void draw() {
  background(0);
  ballen.update();
  ballen.collision();
  ballen.beweeg();
  ballen.toon();
  if (ballen.getkinetischeEnergie() != kinetischeEnergie) {
    kinetischeEnergie = ballen.getkinetischeEnergie();
    println(kinetischeEnergie);
  }
  //println(frameRate);
}

void mousePressed() {
  for (Bal b : ballen.ballen) {
    if (dist(mouseX, mouseY, b.positie.x, b.positie.y) <= b.radius) {
      b.isGeactiveerd = true;
    }
  }
}

void mouseReleased() {
  for (Bal b : ballen.ballen) {
    if (b.isGeactiveerd) {
      println(b.berekenMuissnelheid());
    }
    b.isGeactiveerd = false;
  }
}

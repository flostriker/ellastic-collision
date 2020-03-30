class Bal {
  PVector positie, snelheid;
  float momentum;
  float massa, radius;
  boolean isGeactiveerd;
  ArrayList<Boolean> toegestaneBotsingen;

  Bal(int size) {
    positie = new PVector(random(50, width - 50), random(50, height - 50));
    snelheid = new PVector(4, 8);
    massa = (int)random(200, 20000);
    isGeactiveerd = false;
    toegestaneBotsingen = new ArrayList<Boolean>();
    for (int i = 0; i < size; i += 1) {
      toegestaneBotsingen.add(true);
    }
    radius = sqrt(massa);
  }

  void toon() {
    ellipseMode(RADIUS);
    fill(255);
    noStroke();
    ellipse(positie.x, positie.y, radius, radius);
  }

  void beweeg() {
    if (positie.x >= width - radius || positie.x <= radius) {
      snelheid.x *= -1;
    }
    if (positie.y >= height - radius || positie.y <= radius) {
      snelheid.y *= -1;
    }
    positie.add(snelheid);
    if (keyPressed && key == ' ') {
      snelheid.set(0, 0);
    }
    positie.x = constrain(positie.x, radius, width - radius);
    positie.y = constrain(positie.y, radius, height - radius);
  }

  void update() {
    radius = sqrt(massa);
    if (isGeactiveerd) {
      positie.set(mouseX, mouseY);
    }
  }

  PVector berekenMuissnelheid() {
    snelheid.set(mouseX - pmouseX, mouseY - pmouseY);
    return snelheid;
  }

  float getkinetischeEnergie() {
    return 0.5 * massa * snelheid.magSq();
  }
}

class Pop {
  ArrayList<Bal> ballen;

  Pop(int size) {
    ballen = new ArrayList<Bal>();
    for (int i = 0; i < size; i += 1) {
      ballen.add(new Bal(size));
    }
  }

  void toon() {
    for (Bal b : ballen) {
      b.toon();
    }
  }

  void update() {
    for (Bal b : ballen) {
      b.update();
    }
  }

  void beweeg() {
    for (Bal b : ballen) {
      b.beweeg();
    }
  }

  void collision() {
    for (int i = 0; i < ballen.size() - 1; i += 1) {
      for (int j = i + 1; j < ballen.size(); j += 1) {
        if (hasColided(ballen.get(i), ballen.get(j), i, j)) {
          directions(ballen.get(i), ballen.get(j));
          ballen.get(i).toegestaneBotsingen.set(j, false);
          ballen.get(j).toegestaneBotsingen.set(i, false);
        }
      }
    }
  }

  boolean hasColided(Bal b1, Bal b2, int i, int j) {
    boolean isAllowed = b1.toegestaneBotsingen.get(j) && b2.toegestaneBotsingen.get(i);
    boolean inRange = dist(b1.positie.x, b1.positie.y, b2.positie.x, b2.positie.y) <= b1.radius + b2.radius;
    if (!inRange) {
      b1.toegestaneBotsingen.set(j, true);
      b2.toegestaneBotsingen.set(i, true);
    }
    return isAllowed && inRange;
  }


  void directions(Bal b1, Bal b2) {
    PVector v1 = new PVector();
    PVector v2 = new PVector();


    PVector x1x2 = new PVector();
    PVector.sub(b1.positie, b2.positie, x1x2);
    PVector v1v2 = new PVector();
    PVector.sub(b1.snelheid, b2.snelheid, v1v2);

    float massaCalc1 = (2 * b2.massa) / ((float)(b1.massa + b2.massa));
    float vectorCalc1 = PVector.dot(v1v2, x1x2) / x1x2.magSq();
    float mult1 = massaCalc1 * vectorCalc1;

    PVector.sub(b1.snelheid, x1x2.mult(mult1), v1);


    PVector x2x1 = new PVector();
    PVector.sub(b2.positie, b1.positie, x2x1);
    PVector v2v1 = new PVector();
    PVector.sub(b2.snelheid, b1.snelheid, v2v1);

    float massaCalc2 = (2 * b1.massa) / ((float)(b2.massa + b1.massa));
    float vectorCalc2 = PVector.dot(v2v1, x2x1) / x2x1.magSq();
    float mult2 = massaCalc2 * vectorCalc2;

    PVector.sub(b2.snelheid, x2x1.mult(mult2), v2);

    b1.snelheid.set(v1);
    b2.snelheid.set(v2);
  }

  float getkinetischeEnergie() {
    float sum = 0;
    for (Bal b : ballen) {
      sum += b.getkinetischeEnergie();
    }
    return sum;
  }
  
  void veranderSnelheid(int index, PVector nieuweSnelheid){
    ballen.get(index).snelheid = nieuweSnelheid;
  }
  
  void veranderMassa(int index, float nieuweMassa){
    ballen.get(index).massa = nieuweMassa;
  }
}

class Shape {
  Particle[] ps;
  float hue;
  float hueSpeed;
  float weight;

  Shape(int count, float speed, float speedDelta, float startHue, float hueSpeed, float weight) {
    this.hue = startHue;
    this.hueSpeed = hueSpeed;
    this.weight = weight;
    ps = new Particle[count];
    for (int i = 0; i != count; ps[i++] = new Particle(speed, speedDelta, weight/2f));
  }

  void update(float delta) {
    for (Particle p : ps) {
      p.update(delta);
    }
  }

  void render() {
    hue = (hue + hueSpeed) % 360;
    canvas.stroke(color(hue, 90, 80));
    canvas.strokeWeight(weight);
    canvas.strokeJoin(ROUND);
    canvas.noFill();
    canvas.beginShape();
    for (Particle p : ps) {
      PVector pos = p.getPos();
      canvas.vertex(pos.x, pos.y);
    }
    canvas.endShape(CLOSE);
  }
}

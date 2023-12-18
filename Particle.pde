class Particle {
  PVector pos;
  PVector vel;

  float speed;
  float speedDelta;
  float radius;

  Particle(float speed, float speedDelta, float radius) {
    this.speed = speed;
    this.speedDelta = speedDelta;
    this.radius = radius;
    pos = new PVector(random(width), random(height));
    vel = PVector.random2D();
    vel.setMag(this.speed);
  }

  PVector getPos() {
    return pos.copy();
  }

  void update(float delta) {
    pos.add(PVector.mult(vel, delta));
    
    if (pos.x > width - radius) {
      vel.x *= -1f;
      pos.x = width - radius;
      randSpeed();
    }
    if (pos.x < radius) {
      vel.x *= -1f;
      pos.x = radius;
      randSpeed();
    }
    if (pos.y > height - radius) {
      vel.y *= -1f;
      pos.y = height - radius;
      randSpeed();
    }
    if (pos.y < radius) {
      vel.y *= -1f;
      pos.y = radius;
      randSpeed();
    }
  }

  void randSpeed() {
    vel.setMag(random(speed - speedDelta, speed + speedDelta));
  }
}

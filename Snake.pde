class Snake {
  PVector head;
  PVector nextPosition;
  float speed;
  int scale;
  PVector direction = new PVector(0, 0), prevDirection;
  int lastMs = 0;
  ArrayList<PVector> tail = new ArrayList<PVector>();
  
  Snake(int x, int y, float speed, int scale) {
    head = new PVector(x, y);
    this.speed = speed;
    this.scale = scale;
  }
  
  void show() {
    fill(185);
    rect(round(head.x) * scale, round(head.y) * scale, scale, scale);
    
    fill(200);
    for (PVector v : tail) {
      rect(v.x * scale, v.y * scale, scale, scale); 
    }
  }
  
  void calcNextPosition() {
    nextPosition = new PVector(head.x + speed * deltaTime() * direction.x, head.y + speed * deltaTime() * direction.y);
    
    lastMs = millis();
  }
  
  void updatePosition() {
    if (tail.size() > 0) {
      if (round(head.x) != round(nextPosition.x) || round(head.y) != round(nextPosition.y)) {
        for (int i = (tail.size() - 1); i > 0; i--) {
          tail.set(i, tail.get(i - 1));
        }
        tail.set(0, new PVector(round(head.x), round(head.y)));
      }
    }
    
    head =  new PVector(nextPosition.x, nextPosition.y);
  }

  void setDirection(PVector direction) {
    if (this.direction != direction)
      prevDirection = this.direction;
    this.direction = direction; 
  }

  float deltaTime() {
    return float(millis() - lastMs) / 1000;
  }

  void grow(int x, int y) {
    tail.add(new PVector(x - direction.x, y - direction.y));
  }
}

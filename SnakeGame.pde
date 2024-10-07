GameManager manager;

void setup() {
  surface.setTitle("SNAKE by filomar");
  size(800, 800);
  noStroke();
  
  manager = new GameManager(100, 20, 5, 2, 7);
}

void draw() { 
  manager.updateGame();
}

void keyPressed() {
  PVector direction = new PVector(0, 0);
  
  if (key == 'w') {
    direction.x = 0;
    direction.y = -1;
  }
  if (key == 's') {
    direction.x = 0;
    direction.y = 1;
  }
  if (key == 'a') {
    direction.x = -1;
    direction.y = 0;
  }
  if (key == 'd') {
    direction.x = 1;
    direction.y = 0;
  }
  
  if (manager.gameOver && key == ' ') {
    manager.restart();
  }
  
  if (direction.x == 0 && direction.y == 0)
    return;
  else
    manager.setDirection(direction);
}

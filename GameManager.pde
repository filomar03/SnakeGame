class GameManager {
  int screenSize, gridSize, cellSize;
  
  float speed;
  Snake snake;
  
  int elapsedSinceFoodSpawn = 0;
  float spawnTime, spawnRandomness;
  
  int maxSimFood, currentFoodCount = 0;
  Food[] food;
  
  float normalTextSize;
  
  boolean gameOver = false;
  
  int score = 0;
  
  GameManager(int gridSize, float speed, float spawnTime, float spawnRandomness, int maxSimFood) {
    this.screenSize = min(width, height);
    this.gridSize = gridSize;
    this.cellSize = floor(screenSize / gridSize);
    surface.setSize(gridSize * cellSize, gridSize * cellSize);
    normalTextSize = gridSize * cellSize / 20;
    
    this.spawnTime = spawnTime;
    this.spawnRandomness = spawnRandomness;
    
    this.maxSimFood = maxSimFood;
    food = new Food[maxSimFood];
     
    this.speed = speed;
    this.snake = new Snake(int(random(0, gridSize)), int(random(0, gridSize)), speed, cellSize);
  }
  
  void updateGame() {
    drawBoard();
    
    if (!gameOver) {
      foodSpawnHandling();
      snake.calcNextPosition();
      if (checkCollisions(round(snake.nextPosition.x), round(snake.nextPosition.y)) < 2) {
        snake.updatePosition();     
      } else {
        gameOver = true;
      }
    }
 
    showFood();
    snake.show();
    showScore();

    if (gameOver) {
      displayGameOver(); 
    }
  }
  
  void drawBoard() {
    fill(50);
    rect(0, 0, cellSize * gridSize, cellSize * gridSize);
  }
  
  void setDirection(PVector direction) { 
    snake.setDirection(direction);
  }
  
  void foodSpawnHandling() {
    if (currentFoodCount < maxSimFood) {
      if (snake.direction.x == 0 && snake.direction.y == 0) {
        elapsedSinceFoodSpawn = millis() / 1000;
      } else {
        if (millis() / 1000 - elapsedSinceFoodSpawn >= random(spawnTime - spawnRandomness, spawnTime + spawnRandomness)) {
          elapsedSinceFoodSpawn = millis() / 1000;
          spawnFood();
        }
      }
    }
  }
  
  void spawnFood() {
    int i = 0;
    for (Food _food : food) {
      if (_food == null) {  
        food[i] = new Food(int(random(0, gridSize)), int(random(0, gridSize)), cellSize);
        currentFoodCount++;
        return;
      } 
      i++;
    }
  }
  
  void showFood() {
    for (Food food : food) {
        if (food != null) 
          food.show();
    } 
  }
  
  int checkCollisions(int x, int y) {
    int i = 0;
    for (Food food : food) {
      if (food != null) {
        if (x == food.x && y == food.y) {
          eat(i);
          return 1;
        }
      }
      i++;
    }
    
    if (x < 0 || x > gridSize - 1 || y < 0 || y > gridSize - 1)
      return 2;
    
    for (PVector v : snake.tail) {
      if (x == v.x && y == v.y) {
          return 3;
      }
    }
      
    return 0;
  }
  
  void eat(int index) {
    snake.grow(food[index].x, food[index].y);
    food[index] = null;
    currentFoodCount--;
    score++;
  }
  
  void displayGameOver() {
    fill(0, opacityNormalize(0.5));
    rect(0, 0, gridSize * cellSize, gridSize * cellSize);
    
    String gameOverText = "GAME OVER";
    fill(255, 0, 0);
    textSize(normalTextSize);
    text(gameOverText, gridSize * cellSize / 2 - textWidth(gameOverText) / 2, gridSize * cellSize / 2);
    
    String restartInstructionText = "press space to restart";
    fill(255);
    textSize(normalTextSize / 3 * 2);
    text(restartInstructionText, gridSize * cellSize / 2 - textWidth(restartInstructionText) / 2, gridSize * cellSize / 2 + normalTextSize);
  }
  
  void restart() {
    for (int i = 0; i < food.length; i++) {
      food[i] = null;
    }
    currentFoodCount = 0;
    elapsedSinceFoodSpawn = 0;  
    
    snake = new Snake(int(random(0, gridSize)), int(random(0, gridSize)), speed, cellSize);
    
    score = 0;
    
    gameOver = false;
  }
  
  void showScore() {
    fill(0, 255, 0, opacityNormalize(0.5));
    textSize(normalTextSize);
    text(score, 16, 12 + textAscent());
  }
  
  int opacityNormalize(float o) {
    constrain(o, 0, 1);
    o = 1 - o;
    return round(o * 255); 
  }
}

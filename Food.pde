class Food {
  int x, y;
  int scale;
  
  Food(int x, int y, int scale) {
    this.x = x;
    this.y = y;
    this.scale = scale;
  }
  
  void show() {
    fill(255, 0, 0);
    circle(x * scale + scale / 2, y * scale + scale / 2, scale);
  }
}

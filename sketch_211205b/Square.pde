class Square {
  int topLeftX;
  int topLeftY;
  int indexX, indexY;
  int colours = 255;
  boolean active;
  int x, y, r, g, b, cycle, cycleChange;
  Square(int tlx, int tly, int indexXNum, int indexYNum) {
    topLeftX = tlx;
    topLeftY = tly;
    active = false;
    indexX = indexXNum;
    indexY = indexYNum;
    x = (int)random(width-220) + 110;
    y = (int)random(height-220) + 110;
    r = (int)random(256);
    g = (int)random(256);
    b = (int)random(256);
  }
  void update() {
    if (mouseX > topLeftX && mouseY > topLeftY && mouseX < topLeftX+100 && mouseY < topLeftY+100 && click) {
      click = false;
      if (active == true) {
        active = false;
        colours = 255;
      } else {
        active = true; 
        colours = 0;
      }
    }
  }
  void initializeCircles(boolean sustain) {
    cycle = 200;
    if (sustain) {
      cycleChange = 1;
    } else {
      cycleChange = 5;
    }
  }
  void drawCircles() {
    stroke(50, 50, 50);
    fill(r, g, b);
    ellipse(x, y, cycle, cycle);
    if (cycle > 0) {
      cycle -= cycleChange;
    } else {
      cycle = 0;
    }
  }
  boolean getActive() {
    return active;
  }
  int getColours() {
    return colours;
  }
  int getX() {
    return topLeftX;
  }
  int getY() {
    return topLeftY;
  }
  int getIndexY() {
    return indexY;
  }
  int getIndexX() {
    return indexX;
  }
}

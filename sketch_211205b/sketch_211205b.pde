import themidibus.*;

MidiBus myBus;
int channel = 0;
int pitch = 0, velocity = 100;
int note = 50;
boolean increase = true, decrease = true;
int num = 0;
Square[] squares;
boolean click = false;
int barX = 0;
int barIndex = 1;
int sliderY = 400;
boolean button = false;
boolean controls = false;
boolean showArt = false;

void setup() {
  size(1900, 1000, P2D);
  int num = 0;
  int indexY = height / 100;
  squares = new Square[180];
  for (int i = 1; i < height; i+= 100) {
    int indexX = 1;
    for (int j = 1; j < width - 100; j+= 100) {
      squares[num] = new Square(j, i, indexX, indexY);
      num++;
      indexX++;
    }
    indexY--;
  }
  MidiBus.list();
  myBus = new MidiBus(this, -1, 1);
}

void draw() {
  background(0);
  for (Square square : squares) {
    square.update();
    stroke(0, 0, 0);
    fill(square.getColours(), 255, square.getColours());
    rect(square.getX(), square.getY(), 100, 100);
    if (square.getX() <= barX && square.getX()+5 >= barX && square.getActive()) {
      myBus.sendNoteOn(channel, square.getIndexY()+50, velocity);
      square.initializeCircles(button);  
    }
    if (!button) {
      if (square.getX()+90 <= barX && square.getActive() && square.getIndexX() == barIndex) {
        myBus.sendNoteOff(channel, square.getIndexY()+50, velocity);
      }
    }
  }
  stroke(255, 0, 0);
  line(barX, 0, barX, height);
  barX += 5;
  if (barX > width - 100) {
    barIndex = 0;
    barX = 0;
  }
  if (barX % 100 == 0) {
    barIndex++;
  }
  stroke(0);
  fill(50, 50, 50);
  rect(1801, 0, 99, height);
  fill(255, 255, 255);
  textSize(35);
  text("VOL", 1815, 375);
  textSize(20);
  text("SUSTAIN", 1810, 185);
  textSize(16);
  text("PRESS 'd'\nTO VIEW\nCONTROLS", 1810, 50);
  fill(0, 0, 0);
  rect(1835, 400, 30, 500);
  fill(255, 0, 0);
  rect(1825, sliderY - 15, 50, 30);
  velocity = (900 - sliderY) / 5;
  if (mouseX >= 1825 && mouseX <= 1875 && mouseY >= 200 && mouseY <= 300 && click) {
    click = false;
    if (button) {
      button = false;
    } else {
      button = true;
    }
  }
  if (button) {
    fill(75, 200, 75);
    rect(1825, 200, 50, 50);
  } else {
    fill(75, 75, 75);
    rect(1825, 200, 50, 50);
  }
  if (controls) {
    background(50, 50, 50);
    fill(255, 255, 255);
    textSize(50);
    text("W / S to increase / decrease volume", 50, 100);
    text("Q / A to increase / decrease volume faster", 50, 200);
    text("Click the button under SUSTAIN to make the notes last longer", 50, 300);
    text("Click squares to create notes, click squares again to remove notes", 50, 400);
    text("Press 'e' to view the shapes created from the music you make", 50, 500);
    text("Press 'd' again to go back to the studio", 50, 700);
  }
  if (showArt) {
    background(0, 0, 0);
    for (Square square : squares) {
    square.drawCircles();
    }
  }
}

void mouseClicked() {
  click = true;
}

void keyPressed() {
  if (key == 'w') {
    if (sliderY > 400) {
      sliderY -= 5;
    }
  }
  if (key == 's') {
    if (sliderY < 900) {
      sliderY += 5;
    }
  }
  if (key == 'q') {
    if (sliderY > 400) {
      sliderY -= 50;
      if (sliderY < 400) {
        sliderY = 400;
      }
    }
  }
  if (key == 'a') {
    if (sliderY < 900) {
      sliderY += 50;
      if (sliderY > 900) {
        sliderY = 900;
      }
    }
  }
  if (key == 'd') {
    if (controls) {
      controls = false;
    } else {
    controls = true;
    }
  }
  if (key == 'e') {
    if (showArt) {
      showArt = false;
    } else {
    showArt = true;
    }
  }
}

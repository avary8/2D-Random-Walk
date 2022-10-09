import controlP5.*;
ControlP5 cp5;
controlP5.Button startButton;
controlP5.Toggle colorToggle;
controlP5.Toggle gradualToggle;
controlP5.Slider iterSlider;
controlP5.Slider stepCountSlider;
int bgColor = color(120, 155, 180);
Walk walk;

public void setup() {
  size(800, 800);
  background(bgColor);
  cp5 = new ControlP5(this);
  buttonInit();//initializes all buttons, toggles, and sliders
  walk = new Walk();
}

void draw() {
  float ites = 0;
  if (walk.steps < walk.iters) {//steps taken doesn't exceed user set value
    if (gradualToggle.getValue() == 1.0) {
      ites = walk.stepCount;
    } else {
      ites = walk.iters;
    }
    int i = 0;
    while (i < walk.iters && i < ites) {
      walk.step();
      walk.display();
      i++;
    }
  }
}

class Walk {
  int x, y, steps;
  float stepCount, iters, colorBool;
  Walk() {
    x = width/2;
    y = height/2;
    steps = 0;
    stepCount = 0;
    iters = 0;
    colorBool = 0;
  }

  void display () {
    float newStroke = 0;
    steps++;
    if (colorBool == 1.0) {//condition for color walk, otherwise black
      newStroke = map(steps, 0, iters, 0, 255);
    }
    stroke (newStroke);
    point(x, y);
  }

  void step () {
    /*the random step function
     0 - up
     1 - down
     2 - left
     3 - right
     */
    int choice = int (random(4));
    if (choice == 0) {
      y++;
    } else if (choice == 1) {
      y--;
    } else if (choice == 2) {
      x--;
    } else {
      x++;
    }
    //ensures values stay inside the screen
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }
}

void buttonInit() {
  startButton = cp5.addButton("startButton")
    .setLabel("Start")
    .setColorLabel(255)
    .setPosition(10, 20)
    .setSize(90, 30)
    ;
  startButton.getCaptionLabel().setSize(startButton.getHeight()/2);

  gradualToggle = cp5.addToggle("gradualToggle")
    .setLabel("Gradual")
    .setColorLabel(255)
    .setPosition(120, 20)
    .setSize(int(startButton.getWidth() / 2.5f), int(startButton.getHeight() / 1.5f))
    .setValue(false)
    .setMode(ControlP5.DEFAULT)
    ;

  colorToggle = cp5.addToggle("colorToggle")
    .setLabel("Color")
    .setColorLabel(255)
    .setPosition(166, 20)
    .setSize(int(startButton.getWidth() / 2.5f), int(startButton.getHeight() / 1.5f))
    .setValue(false)
    .setMode(ControlP5.DEFAULT)
    ;

  iterSlider = cp5.addSlider("iterSlider")
    .setLabel ("Iterations")
    .setPosition(222, 20)
    .setRange(1000, 500000)
    //.setNumberOfTickMarks(500000)
    //.showTickMarks(false)
    .setSize(int (startButton.getWidth() * 4.5f), startButton.getHeight())
    ;
  iterSlider.getCaptionLabel().setSize(int(startButton.getHeight()/1.7f));

  stepCountSlider = cp5.addSlider("stepCountSlider")
    .setLabel ("Step Count")
    .setPosition(222, 20 + iterSlider.getHeight())
    .setRange(1, 1000)
    .setNumberOfTickMarks(1000)
    .showTickMarks(false)
    .setSize(int (startButton.getWidth() * 4.5f), startButton.getHeight())
    ;
  stepCountSlider.getCaptionLabel().setSize(int(startButton.getHeight()/1.7f));

  startButton.bringToFront();
  gradualToggle.bringToFront();
  colorToggle.bringToFront();
  iterSlider.bringToFront();
}

void startButton() {
  background(bgColor);
  walk.x = width/2;
  walk.y = height/2;
  walk.steps = 0;
  walk.stepCount = stepCountSlider.getValue();
  walk.iters = iterSlider.getValue();
  walk.colorBool = colorToggle.getValue();
}

void iterSlider() {
  iterSlider.setValue(round(iterSlider.getValue()));
}

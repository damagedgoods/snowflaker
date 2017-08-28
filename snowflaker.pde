SnowFlakerUI controls;
SnowFlakerController controller;
boolean dragging = false;
ArrayList shapes;
int numSectors = 16;
int clickCounter = 0;

int countImage = 0;
Line currentLine;
Circle currentCircle;
Arc currentArc;
int MODE_LINES = 0;
int MODE_CIRCLES = 1;
int MODE_ARCS = 2;
int mode = MODE_LINES;
boolean preview = false;
int currentWeight = 1;
int currentColor = 0;
int currentPalette = 0;
int currentBackground = 0;
Message currentMessage;
color[] colors = {color(250,208,137), color(255,156,91), color(245,99,74), color(237,48,60),color(59,129,131)};
color[] backgrounds = {color(255), color(30)};

boolean grid = false;
int gridStep = 10;

void setup() {  
  background(backgrounds[currentBackground]);
  shapes = new ArrayList();
  controls = new SnowFlakerUI();
  controller = new SnowFlakerController();
  size(680,680);  
  currentMessage = new Message("Start drawing", 400);
  frameRate(24);
}

void draw() {  
  background(backgrounds[currentBackground]);
  translate(width/2, height/2);  
  
  int x = mouseX-width/2;
  int y = mouseY-height/2;
  if (grid) {
    x = int(x / gridStep)*gridStep;
    y = int(y / gridStep)*gridStep;
  }

  if (dragging) {
    if (mode == MODE_LINES) {
      currentLine.x2 = x;
      currentLine.y2 = y;   
    } else if (mode == MODE_CIRCLES) {
      currentCircle.r = dist(x, y, currentCircle.x, currentCircle.y);  
    } else if (mode == MODE_ARCS) {
      currentArc.x2 = x;
      currentArc.y2 = y;   
    }
  }

  float baseAngle = (2*PI/numSectors);
  
  for (int j=1; j<=numSectors; j++) {
    pushMatrix();
    float angle = j*baseAngle;
    if ((j % 2) == 1) {
      scale(-1,1);
    }
    rotate(angle);    
    for (int i=0;i<shapes.size();i++) {
      Shape s = (Shape)shapes.get(i);
      s.display();
    }    
    if (dragging) {
      if (mode == MODE_LINES) {
        currentLine.display();
      } else if (mode == MODE_CIRCLES) {
        currentCircle.display();
      } else if (mode == MODE_ARCS) {
        currentArc.display();
      }      
    }
    
    popMatrix();
  }
  
  // Pinto los ejes
  if (!preview) {
    for (int j=1; j<=numSectors; j++) {
      pushMatrix();
      rotate(baseAngle*j+baseAngle/2);
      stroke(200);
      strokeWeight(0.5);
      line(0,0,300,300);
      popMatrix();
    }
  }

  translate(-width/2, -height/2);  

  if (currentMessage != null) {
    currentMessage.display();
    currentMessage.update();
    if (currentMessage.life < 0) {
      currentMessage = null;
    }
  }    
    
  if (grid && !preview) {
    for (int i=0; i<width/gridStep; i++) {
      for (int j=0; j<height/gridStep; j++) {
        fill(100);
        noStroke();        
        ellipseMode(CENTER);
        ellipse(i*gridStep, j*gridStep, 1, 1);
      }          
    }    
  }
  
  if (!preview) {
    controls.display();
  }    
    
  if (mouseY > height - controls.BUTTON_HEIGHT) {
    cursor(HAND);
  } else {
    cursor(CROSS);
  }
  
}

void mousePressed() {
  
  if (mouseY > height - controls.BUTTON_HEIGHT) {
    return;
  }
  
  dragging = true;
  int x = mouseX-width/2;  
  int y = mouseY - height/2;
  if (grid) {
    x = int(x / gridStep)*gridStep;
    y = int(y / gridStep)*gridStep;
  }
  
  if (mode == MODE_LINES) {
    currentLine = new Line(x, y, x, y);
    currentLine.weight = currentWeight;
    currentLine.c = colors[currentColor];
  } else if (mode == MODE_CIRCLES) {
    currentCircle = new Circle(x, y, 0);
    currentCircle.weight = currentWeight;
    currentCircle.c = colors[currentColor];
  } else if (mode == MODE_ARCS) {
    currentArc = new Arc(x, y, x,y);
    currentArc.weight = currentWeight;
    currentArc.c = colors[currentColor];
  }
}


void mouseClicked() {
  clickCounter++;
  if (mouseY > height - controls.BUTTON_HEIGHT) {
    controller.processClick();
    return;
  }
}


void mouseReleased() {
  if (mouseY > height - controls.BUTTON_HEIGHT) return;
  dragging = false;  
  if (mode == MODE_LINES) {
    shapes.add(currentLine);
  } else if (mode == MODE_CIRCLES) {
    shapes.add(currentCircle);
  } else if (mode == MODE_ARCS) {
    shapes.add(currentArc);
  }  
}

void keyPressed() {
  // Cambiar para utilizar el controller
  
  if (key == 'x') {
    shapes = new ArrayList();
  } else if (key == '1') {
    mode = MODE_LINES;
  } else if (key == '2') {
    mode = MODE_CIRCLES;
  } else if (key == '3') {
    mode = MODE_ARCS;        
  } else if (key == 'q') {
    numSectors+=4;
  } else if (key == 'a') {
    numSectors-=4;
    if (numSectors <4) numSectors = 4; 
  } else if (key == 'w') {
    println("Previous weight: "+currentWeight);
    currentWeight += 2;
    if (currentWeight == 9 ) currentWeight = 1;
    println("New weight: "+currentWeight);
  } else if (key == 'c') {
    currentColor++;
    if (currentColor >= colors.length) {
      currentColor = 0;
    }
  } else if (key == 'g') {
    println("grid");
    grid = !grid;
  } else if (key == 'z') {
    shapes.remove(shapes.size()-1);
  } else if (key == 's') {
    preview = true;
    draw();
    String name = "snowflake"+countImage+".tif";
    save(name);
    countImage++;
    preview= false;
  } else if (key == 'b') {
    currentBackground++;
    if (currentBackground >= backgrounds.length) {
      currentBackground = 0;
    }    
  } else if (key == ' ') {
    preview = true;
  }    
} 

void keyReleased() {
  preview = false;
}
class Arc extends Shape{
  
  int x1;
  int y1;
  int x2;
  int y2;
  float start = 0;
  float stop = PI;
  int weight = 2;
  color c = color(0,0,100);
  
  Arc(int _x1, int _y1, int _x2, int _y2) {
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2;
  }
  
  void display() {
    stroke(c);
    strokeWeight(weight);
    noFill();
    beginShape();
    float currentDist = dist(x1, y1, x2, y2);
    curveVertex(x1, y1-3*(y2-y1));
    curveVertex(x1, y1);
    curveVertex(x2, y2);
    curveVertex(x2+3*(x2-x1), y2);
    endShape();
  }

}
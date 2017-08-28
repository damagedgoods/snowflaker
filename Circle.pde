class Circle extends Shape{
  
  int x;
  int y;
  float r;
  int weight = 2;
  color c = color(0,0,100);
  
  Circle(int _x, int _y, float _r) {
    x = _x;
    y = _y;
    r = _r;    
  }
  
  void display() {
    stroke(c);
    strokeWeight(weight);
    noFill();
    ellipse(x, y, r, r);
  }

}
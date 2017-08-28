class Message {

  String txt;
  int life;
  
  Message(String _txt, int _life) {
    txt = _txt;
    if (_life < 0) {
      life = 1000;
    } else {
      life = _life;
    }
  }
  
  void update() {
    life-=2;
  }
  
  void display() {
      if (!preview) {
      fill(122, life);
      textAlign(CENTER);
      textSize(16);
      text(txt, width/2, 35);
    }
  }
}
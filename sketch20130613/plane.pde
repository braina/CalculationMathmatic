class plane {
  int cX, cY;
  int unit;

  plane() {
    cX=width/2;
    cY=height/2;
    unit=50;
  }

  int X(float a) {
    return int(cX+a*unit);
  }

  int Y(float a) {
    return int(cY-a*unit);
  }

  void drawAxis() {
    int a=int(max(cX,cY)/unit);
    line(cX-unit*a, cY, cX+unit*a, cY);
    line(cX, cY-unit*a, cX, cY+unit*a);
  }

}

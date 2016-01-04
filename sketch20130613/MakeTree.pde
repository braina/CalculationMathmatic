class MakeTree{

  int step;
  int count;
  float tr_scale;
  float tr_angle;
  float tr_length;
  float tr_startd;
  float tr_startx;
  float tr_starty;
  float offset = -90;
  float deg01,deg02,deg03;
  float scl01,scl02,scl03;

  MakeTree(float px,float py){

    this.step      = 8;
    this.count     = 0;
    this.tr_scale  = 0.3;
    this.tr_angle  = 40.0;
    this.tr_length = 300.0;
    this.tr_startd = 0.0;
    this.tr_startx = px;
    this.tr_starty = py;

    initialize();

  }

  void initialize(){

    this.deg01 = random(-tr_angle-5,-tr_angle);
    this.deg02 = random(-5, 5);
    this.deg03 = random(tr_angle-5, tr_angle);
    this.scl01 = random(random(10,20), tr_length * tr_scale);
    this.scl02 = random(random(10,20), tr_length * tr_scale);
    this.scl03 = random(random(10,20), tr_length * tr_scale);

  }


  void draw(){

    create(tr_startx,tr_starty,tr_length,tr_startd,step);

  }

  void create(float x01, float y01, float len, float deg, int n){
    if(n < 0) return;


    float x02 = x01 + len * cos(radians(deg + offset));
    float y02 = y01 + len * sin(radians(deg + offset));

    colorMode(HSB,360,100,100,100);
    if( n > 3 )
    stroke(352,80,120/(n+1),10*n);
    else
    stroke(shaper.theme[selected_color].palet[n*7%10]);
    strokeWeight(20*n/10);

    line(x01, y01, x02, y02);

    create(x02, y02, scl01, deg+deg01, n-1);
    create(x02, y02, scl02, deg+deg02, n-1);
    create(x02, y02, scl03, deg+deg03, n-1);

  }

}



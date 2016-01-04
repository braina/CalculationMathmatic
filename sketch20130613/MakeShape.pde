class Shaper{

  boolean end; 

  float flower_size;
  int flower_cnt;

  ArrayList <PVector> shape = new ArrayList <PVector>();
  ArrayList <PVector> record = new ArrayList <PVector>();

  boolean first_checked;
  int mode;

  Slider slider = new Slider();
  Slider slider2 = new Slider();

  ColorPalet [] theme = {
    new ColorPalet(flower_color ,0),
    new ColorPalet(flower_color2,1),
    new ColorPalet(flower_color3,2),
    new ColorPalet(flower_color4,3),
  };

  Shaper(){

    this.end = false;

    flower_size = 5;

    initialize();

  }


  void initialize(){

    this.record.add(new PVector(0,0));
    this.record.add(new PVector(3,1));
    this.record.add(new PVector(3,2));
    this.record.add(new PVector(2,2));
    this.record.add(new PVector(2,3));
    this.record.add(new PVector(1,3));

    makeShape();



  }

  void draw(){


    rectMode(CENTER);
    noStroke();
    fill(#000000,20);
    rect(width/2+2,height/2+1,width-45,height-47,10);
    fill(#FFFFFF,90);
    rect(width/2,height/2,width-50,height-50,10);


    noStroke();
    fill(#424242);
    textAlign(CORNER);
    text("Let's make shape", 60,50);

    makeButton("skip",width-70,45,color(#90CAF9));
    makeButton("delete",width-160,45,color(#ef9a9a));
    makeButton("default",width-270,45,color(#E0E0E0));
    makeButton("complete!",width-110,height-50,color(#81C784));

    stroke(#9E9E9E);
    line(50,60,width-50,60);

    stroke(#9E9E9E);
    for(int i=0; i<15 ; i++){
      for(int j=0; j<27 ; j++){
        line(50,100+30*i,width-50,100+30*i);
        line(60+30*j,100,60+30*j,height-80);
      }
    }

    slider.display(60,height-50); 
    slider2.min_v = 0;
    slider2.max_v = 4000;
    slider2.display(width-450,height-50); 
    
    for(int i=0; i<this.record.size(); i++){
      float axis_x1 =  60+30*this.record.get(i).x;
      float axis_y1 = 100+30*this.record.get(i).y;

      float axis_x0 =  60+30*this.record.get(0).x;
      float axis_y0 = 100+30*this.record.get(0).y;
      float axis_xf =  60+30*this.record.get(record.size()-1).x;
      float axis_yf = 100+30*this.record.get(record.size()-1).y;

      if(i != this.record.size()-1){

        float axis_x2 =  60+30*this.record.get(i+1).x;
        float axis_y2 = 100+30*this.record.get(i+1).y;
        colorMode(HSB,360,100,100);
        strokeWeight(5);
        stroke(frameCount*3%360,100,100);
        line(axis_x1,axis_y1,axis_x2,axis_y2);

      }

      line(axis_x0,axis_y0,axis_xf,axis_yf);

      if(i == 0)
        fill(#2196F3);
      else
        fill(#424242);

      noStroke();
      ellipse(axis_x1,axis_y1,10,10);

    } 

    theme[0].draw(250,height-50);
    theme[1].draw(300,height-50);
    theme[2].draw  (350,height-50);
    theme[3].draw(400,height-50);

    flower_size = slider.circle_x;

  }


  void makeShape(){

    initList(this.shape);

    flower_count = (int)slider2.circle_x;
    for(PVector vec : record){
      float x = vec.x * flower_size;
      float y = vec.y * flower_size;

      this.shape.add(new PVector(x,y));  

    }

  }


  void initList(ArrayList ls){

    while(ls.size() != 0){
      ls.remove(0);
    }

  }



  void makeButton(String label,int x, int y,color c){

    stroke(#424242);
    fill(c,90);
    rectMode(CENTER);
    rect(x,y,label.length()*15,30,10);
    fill(#424242);
    textAlign(CENTER);
    text(label,x,y+5);

  }


  PVector makeHitBegin(String label,int x, int y){

    PVector begin;
    begin = new PVector(x-label.length()*15/2,y-10);
    return begin;

  }

  PVector makeHitEnd(String label,int x, int y){

    PVector end; 
    end = new PVector(x+label.length()*15/2,y+10);
    return end;

  }

}



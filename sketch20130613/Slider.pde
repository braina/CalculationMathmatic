class Slider{

  float min_v;
  float max_v;
  float per;
  float value;

  float circle_x;
  float circle_y;

  Slider(){

    this.min_v = 0;
    this.max_v = 20;


    //circle_x is actually flower_size 
    this.circle_x = 10;

    //value is percent of bar 
    
    this.value = 25;

  }



  void display(int x, int y){

    this.per = getPer(x,y);

    this.circle_x = int(this.value / this.per);
    this.circle_y = y;  
    if(this.value < 0) this.value = 0;
    if(this.value > 100) this.value = 100;

    rectMode(CORNER);
    stroke(#424242);
    noFill();
    rect(x,y-5,100,10,30);

    fill(#424242);
    textAlign(CORNER);
    if(x == 60)
    text("size: "+circle_x,x+110,y+5);
    if(x == width-450)
    text("amount: "+circle_x,x+110,y+5);
      
    noStroke();
    fill(#BDBDBD);
    ellipse(x+this.value,this.circle_y,20,20);
    

  }

  //x = 60;
  //y = height-50; 
  //
  float getPer(int x,int y){

    float per = 100/(this.max_v - this.min_v);     
    return per;

  }


  

}

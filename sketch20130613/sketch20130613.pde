//about flower
Shaper shaper;
//int flower_count = 1200/shape_number;
int flower_count = 1000;


ArrayList <PVector[]> particles = new ArrayList <PVector[]> ();
int selected_color = 0;
color [] flower_color = {
  #F9F2F3, 
  #f9e5e8, 
  #fbdade, 
  #f9ccd2, 
  #f9c0c8, 
  #f9b3bd, 
  #f9a7b2, 
  #f99aa7, 
  #f98e9c, 
  #f98191 
};
color [] flower_color2 = {
  #59a80f, 
  #9ed54c, 
  #c4ed68, 
  #e2ff9e, 
  #f0f2dd, 
  #cff09e, 
  #a8dba8, 
  #79bd9a, 
  #3b8686, 
  #0b486b 
};
color [] flower_color3 = {
  #d24858, 
  #ea8676, 
  #eab05e, 
  #fdeecd, 
  #493831, 
  #a7321c, 
  #ffdc68, 
  #cc982a, 
  #928941, 
  #352504 
};
color [] flower_color4 = {
  #6c788e,
  #a6aec1,
  #cfd5e1,
  #ededf2,
  #fcfdff,
  #e6e8e3,
  #d7dacf,
  #bec3bc,
  #8f9a9c,
  #65727a,
};





//AffineR2 transition;
ArrayList <AffineR2> transition = new ArrayList <AffineR2> ();
float theta = 30;
float dx,dy;

//about world
plane my_plane;
MakeTree tree;
ArrayList <World> world = new ArrayList <World> ();

//setting for program
PVector mouse_start;
PVector mouse_end;

void setup(){

  size(900,600);
  background(#FFFFFF);
  smooth();
  noStroke();
  frameRate(60);

  shaper = new Shaper();

  dx = width/2;
  dy = height/2;


  for (int i=0;i<flower_count ; i++){
    particles.add(new PVector[shaper.shape.size()]);  
  }
  //this is for transration.
  //a,b,c,d,p,q
  for (int i=0; i<particles.size(); i++){
    theta = random(360);
    transition.add(
        new AffineR2(
          cos(theta), sin(theta),
          -sin(theta), cos(theta),
          random(width),random(height)
          )
        );
  }

  for(int i=0; i<particles.size(); i++){
    world.add(new World());
  }

  tree = new MakeTree(width-10,height);

}

void draw(){

  //   background(#FFFFFF);
  fade(#757575);


  int count = 0; 
  for(PVector[] p : particles){
    for(int i=0; i<shaper.shape.size() ; i++){
      p[i]  = transition.get(count).translate(shaper.shape.get(i)); 
    }
    count++;
  }

  count = 0;
  for(PVector[] p : particles){
    drawParticle(shaper.theme[selected_color].palet[count%10],p);
    count++;
  }

  tree.draw();
  for(World w : world){
    w.update();
  }
  updateFlower(); 


  if(!shaper.end){
    shaper.draw();
    // return;
  }

  if(shaper.end){
    shaper.makeButton("make!",width-50,height-20,color(#E3F2FD));
  }

}


void fade(color c){

  rectMode(CORNER);
  colorMode(HSB,360,100,100,100);
  noStroke();
  fill(c,50);
  rect(0,0,width,height);

}


void drawParticle(color c,PVector[] pt){

  noStroke();
  fill(c);
  beginShape();
  for( PVector pvec : pt ){
    if(pvec != null)
    vertex(pvec.x,pvec.y);
  }
  endShape(CLOSE);

}

void changeWorld(float x,float y){

  for(World w : world){
    if(x/20>w.seed_x2) w.seed_x2 = x/20;
    else if(x/20 <= w.seed_x1) w.seed_x1 = x/20;

    if(y/20>w.seed_y2) w.seed_y2 = y/20;
    else if(y/20 <= w.seed_y1) w.seed_y1 = y/20;
  }

}


void updateFlower(){

  int iter = 0;
  for(AffineR2 t : transition){
    t.a =  cos(radians(frameCount%360));
    t.c = -sin(radians(frameCount%360));
    t.p +=  world.get(iter).graX(); 
    if(t.p < 0)     t.p = width;
    if(t.p > width) t.p = 0;
    t.q +=  world.get(iter).graY(); 
    if(t.q > height) t.q = height;
    iter++;
  }

}

void keyPressed(){

  if(key == ' '){

    for(AffineR2 t : transition){
      t.p = random(width); 
      t.q = random(height);
    }

    for(World w: world){
      w.initialize();
    }

  }

}




void mousePressed(){

  if(!shaper.end){
    for(int j=0; j<15 ; j++){
      for(int i=0; i<27 ; i++){
        int axis_x =  60+30*i;
        int axis_y = 100+30*j;

        if(dist(mouseX,mouseY,axis_x,axis_y) < 10 ){


          for(int k=0; k<shaper.record.size() ; k++){

            if(i == shaper.record.get(k).array()[0] && j == shaper.record.get(k).array()[1]){

              shaper.record.remove(k);
              return;
            }

          }

          shaper.record.add(new PVector(i,j));

        }

      }
    }

  }

  if(shaper.end){


  }

  mouse_start = new PVector(mouseX,mouseY);

}

void mouseReleased(){

  if(!shaper.end){

    float skip_x1 = shaper.makeHitBegin("skip",width-70,45).x;
    float skip_y1 = shaper.makeHitBegin("skip",width-70,45).y;
    float skip_x2 = shaper.makeHitEnd("skip",width-70,45).x;
    float skip_y2 = shaper.makeHitEnd("skip",width-70,45).y;

    if(skip_x1 <= mouseX && mouseX <= skip_x2
        && skip_y1 <= mouseY && mouseY <= skip_y2){
      shaper.end = true;
    }
    
    float delete_x1 = shaper.makeHitBegin("delete",width-160,45).x;
    float delete_y1 = shaper.makeHitBegin("delete",width-160,45).y;
    float delete_x2 = shaper.makeHitEnd("delete",width-160,45).x;
    float delete_y2 = shaper.makeHitEnd("delete",width-160,45).y;

    if(delete_x1 <= mouseX && mouseX <= delete_x2
        && delete_y1 <= mouseY && mouseY <= delete_y2){
      initList(shaper.record);
    }

    float default_x1 = shaper.makeHitBegin("default",width-270,45).x;
    float default_y1 = shaper.makeHitBegin("default",width-270,45).y;
    float default_x2 = shaper.makeHitEnd("default",width-270,45).x;
    float default_y2 = shaper.makeHitEnd("default",width-270,45).y;

    if(default_x1 <= mouseX && mouseX <= default_x2
        && default_y1 <= mouseY && mouseY <= default_y2){
      initList(shaper.record);
      initList(particles);
      initList(transition);
      initList(world);


      shaper.slider.value = 25;
      shaper.slider2.value = 25;
      shaper.initialize();

      selected_color = 0;
      updateList();
    }



    float complete_x1 = shaper.makeHitBegin("complete!",width-110,height-50).x;
    float complete_y1 = shaper.makeHitBegin("complete!",width-110,height-50).y;
    float complete_x2 = shaper.makeHitEnd("complete!",width-110,height-50).x;
    float complete_y2 = shaper.makeHitEnd("complete!",width-110,height-50).y;

    if(complete_x1 <= mouseX && mouseX <= complete_x2
        && complete_y1 <= mouseY && mouseY <= complete_y2){
      shaper.makeShape();

      initList(particles);
      initList(transition);
      initList(world);
      updateList();

      tree.initialize();
      shaper.end = true;
    }

    //color palet
    if(dist(mouseX,mouseY,250,height-50) < 10) selected_color = 0;
    if(dist(mouseX,mouseY,300,height-50) < 10) selected_color = 1;
    if(dist(mouseX,mouseY,350,height-50) < 10) selected_color = 2;
    if(dist(mouseX,mouseY,400,height-50) < 10) selected_color = 3;



  }

  if(shaper.end){

    float make_x1 = shaper.makeHitBegin("make!",width-50,height-20).x;
    float make_y1 = shaper.makeHitBegin("make!",width-50,height-20).y;
    float make_x2 = shaper.makeHitEnd("make!",width-50,height-20).x;
    float make_y2 = shaper.makeHitEnd("make!",width-50,height-20).y;

    if(make_x1 <= mouseX && mouseX <= make_x2
        && make_y1 <= mouseY && mouseY <= make_y2){
      shaper.end = false;
    }



    mouse_end = new PVector(mouseX,mouseY);
    changeWorld(mouse_end.x-mouse_start.x,mouse_end.y-mouse_start.y);

  }

}

void mouseDragged(){

  if(!shaper.end){

    if(60<= mouseX && mouseX <= 160
        && shaper.slider.circle_y-10 <= mouseY && mouseY <= shaper.slider.circle_y+10)
      shaper.slider.value = mouseX - 60 ;
    if(width-450<= mouseX && mouseX <= width-350
        && shaper.slider2.circle_y-10 <= mouseY && mouseY <= shaper.slider2.circle_y+10)
      shaper.slider2.value = mouseX - (width-450) ;


  }

  if(shaper.end){

    colorMode(HSB,36,100,100);
    stroke(frameCount%36,50,100);
    strokeWeight(3);
    line(mouseX,mouseY,pmouseX,pmouseY);

  }

}

void removeList(ArrayList ls){

  for(int i=0; i < ls.size() ; i++){
    ls.remove(i);
  }

}


void updateList(){

  for (int i=0;i<flower_count ; i++){
    particles.add(new PVector[shaper.shape.size()]);  
  }

  for (int i=0; i<particles.size(); i++){
    theta = random(360);
    transition.add(
        new AffineR2(
          cos(theta), sin(theta),
          -sin(theta), cos(theta),
          random(width),random(height)
          )
        );
  }

  for(int i=0; i<particles.size(); i++){
    world.add(new World());
  }

}

void initList(ArrayList ls){

  while(ls.size() != 0){
    ls.remove(0);
  }

}


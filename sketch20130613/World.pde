class World{

  float gravity_x;
  float gravity_y;

  float tx;
  float ty;

  float seed_x1;
  float seed_x2;
  float seed_y1;
  float seed_y2;

  World (){

    this.tx = random(100);
    this.ty = random(100);

    this.seed_x1 = -5;
    this.seed_x2 =  5;
    this.seed_y1 = -1;
    this.seed_y2 =  5;

  }

  void initialize(){

    this.tx = random(100);
    this.ty = random(100);

    this.seed_x1 = -5;
    this.seed_x2 =  5;
    this.seed_y1 = -1;
    this.seed_y2 =  5;

  }

  void update(){

    this.gravity_x = map(noise(tx), 0, 1, seed_x1,seed_x2);
    this.gravity_y = map(noise(ty), 0, 1, seed_y1,seed_y2);


    tx += 0.01;
    ty += 0.01;

  }

  float graX(){
    return gravity_x;
  }

  float graY(){
    return gravity_y;
  }







}

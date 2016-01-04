class ColorPalet{

  color [] palet = new color [10];
  int id;

  ColorPalet(color [] c, int tid){

    this.id = tid;
  
    for(int i=0; i<c.length ; i++){
        palet[i] = c[i];
    }

  }


  void draw(int x, int y){
  
    strokeWeight(7);
    if(selected_color == this.id)
      stroke(#304FFE);
    else
      stroke(#607D8B);
    fill(palet[5]);
    ellipse(x,y,20,20);



  }



}

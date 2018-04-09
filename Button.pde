class Button{
  float x,y,r;
  
  Button(float x,float y,float r){
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  void showButton(){
    rect(x,y,r,r);
  }
  
  public boolean checkPress(){
    if (mouseX>= x && mouseX <= (x+r) && mouseY >= y && mouseY <=(x+r)){
      return true;
    }
    else{
      return false;
    }
  }
  
}
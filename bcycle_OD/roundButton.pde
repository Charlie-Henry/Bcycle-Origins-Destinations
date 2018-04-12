class roundButton extends Button{
  roundButton(float x,float y,float r){
    super(x,y,r);
  }
  
  void showButton(){
    ellipse(x,y,r,r);
  }
  
  public boolean checkPress(){
    if (abs(sqrt((mouseX-x)*(mouseX-x) + (mouseY-y)*(mouseY-y))) < r){
      return true;
    }
    else{
      return false;
    }
  }
}
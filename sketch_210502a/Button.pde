class Button{
  int x, y, w, h;
  String text;
  color fillColor = color(0, 45, 81);
  color borderColor = color(0);
  color hoverColor = color(0, 135, 209);
  
  public Button(int x, int y, int w, int h, String text){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
  }
  
  public boolean onButton(){
    return x <= mouseX && mouseX < x+w && y <= mouseY && mouseY < y+h;
  }
  
  void draw(){
    if(onButton()){
      fill(hoverColor);
    }
    else{
      fill(fillColor);
    };
    stroke(borderColor);
    textSize(24);
    rect(x, y, w, h);
    fill(255);
    text(text, x + w/2 - textWidth(text)/2, y + h / 2 + 10);
  }
}

class TextBox{
  int x, y, w, h;
  color fillColor = color(0, 45, 81);
  color borderColor = color(0);
  boolean active = false;
  String text = "";
  int cursor = 0;
  int ticks = 0;
  
  public TextBox(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public void setText(String text){
    this.text = text;
    this.cursor = text.length()-1;
  }
  
  public boolean hovered(){
    return x <= mouseX && mouseX < x+w && y <= mouseY && mouseY < y+h;
  }
  
  void draw(){
    ticks = (ticks + 1) % 60;
    fill(255);
    stroke(borderColor);
    textSize(24);
    rect(x, y, w, h);
    
    if(active){
      fill(0);
      boolean showCursor = ticks > 30;
      text(showCursor ? text + "|" : text, x + 10, y + 6, w - 20, h);
    }
    
    else if(text.length() == 0){
      fill(120);
      text("Search states...", x + 10, y + 6, w - 20, h);
    }
    else{
      fill(120);
      text(text, x + 10, y + 6, w - 20, h);
    }
  }
}

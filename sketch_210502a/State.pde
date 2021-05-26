class State {
  String name;
  ArrayList<Data> dataset;
 
  public State(String name){
    this.name = name;
    this.dataset = new ArrayList<Data>();
  }
  
  public String getName(){
    return name;
  }
  
  public void addData(Data data){
    dataset.add(data);
  }
  
  public void print(){
    println("State: " + name);
    for(Data d : dataset){
      println(d.toString());
    }
  }
  
  public void draw(int x, float scale){
    fill(0);
    text(name, x, height - 60);
    int childX = x;
    
    for(Data d : dataset){
      d.draw(childX, scale);
      childX += 2;
    }
    
    childX = x;
    for(Data d : dataset){
      d.drawTooltip(childX, scale);
      childX += 2;
    }
  }
}

import java.util.Collections;
import java.time.LocalDate;

Table table;
ArrayList<State> states;
ArrayList<State> filteredStates;
float scrollX;
float scale;
PImage Bruh;
PFont font;
PFont font2;

Button helpButton;
boolean helpVisible = false;

TextBox searchInput;

void setup() {
  table = loadTable("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv", "header");
  states = new ArrayList<State>();
  filteredStates = new ArrayList<State>();
  scrollX = 0;
  Bruh = loadImage("Bruh.png");
  PFont.list();

  for (TableRow r : table.rows ()) {
    State state = getState(r.getString("state"));
    LocalDate date = LocalDate.parse(r.getString("date"));
    int fips = r.getInt("fips");
    int cases = r.getInt("cases");
    int deaths = r.getInt("deaths");
    Data data = new Data(date, fips, cases, deaths);
    state.addData(data);
  }
  
  Collections.sort(states, new AlphabeticComparator());
    
  size(1920, 1080);
  scale = 0.001f;
  println("Height: " + height);
  println("Scale: " + scale);
  font = loadFont("Arial-BoldMT-32.vlw");
  font2 = createFont("Cinzel-SemiBold.ttf", 32);
  textFont(font, 32);

  helpButton = new Button(width - 60, 10, 50, 50, "?");
  searchInput = new TextBox(20, 250, 300, 30);
  search();
}

State getState(String name){
  for(State s : states){
    if(s.getName().equals(name)){
      return s;
    }
  }
  
  State s = new State(name);
  states.add(s);
  return s;
}

void mouseClicked() {
  searchInput.active = searchInput.hovered();
  
  if(helpButton.onButton()){
    helpVisible = !helpVisible;
  }
}

void mouseWheel(MouseEvent event) {
  scrollX += event.getCount() * 30;
}

void keyPressed() {
  if (key == '+') {
    scale *= 1.05f;
  }
  if (key == '-') {
    scale *= 0.95f;
  }
  if(key >= 'a' && key <= 'z' || key >= 'A' && key <= 'Z' || key == ' '){
    searchInput.text += key;
    search();
  }
  if(key == BACKSPACE && searchInput.text.length() >= 1){
    searchInput.text = searchInput.text.substring(0, searchInput.text.length()-1);
    search();
  }
}

void search(){
  filteredStates.clear();
  
  if(searchInput.text.length() == 0){
    filteredStates.addAll(states);
    return;
  }
  
  for(State s : states){
    if(s.getName().toLowerCase().contains(searchInput.text.toLowerCase())){
      filteredStates.add(s);
    }
  }
}

void draw() {
  background(173,216,230);
  textSize(32);
  fill(0);
  image(Bruh,0,0,200,199.5);
  
  float formattedScale = scale*1000f;
  String scaleText = "Scale: " + formattedScale;
  text(scaleText, width - 70 - textWidth(scaleText), 50);
  int x = 0;
  
  if(filteredStates.size() == 0){
    String noMatches = "The search returned no results";
    text(noMatches, width/2 - textWidth(noMatches)/2, height/2);
  }
  else{
    for (State s : filteredStates) {
      s.draw(int(x + scrollX), scale);
      x += 1000;
    }
  }
  
  helpButton.draw();
  
  if(helpVisible){
    fill(255, 255, 255, 50);
    rect(width - 290, 70, 280, 250);
    fill(0);
    text("+ Zoom in", width - 270, 140);
    text("- Zoom out", width - 270, 215);
    text("Scrollwheel to slide", width - 270, 290);
  }
  
  searchInput.draw();
  
  fill(150, 182, 202);
  String quote = "With honor and integrity, we will safeguard the American people, our homeland, and our values.";
  textFont(font2, 32);
  text(quote, width/2 - textWidth(quote)/2, height-30);
  textFont(font, 32);
}

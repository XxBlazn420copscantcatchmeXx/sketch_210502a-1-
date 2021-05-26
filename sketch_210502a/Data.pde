import java.time.LocalDate;

class Data {
  private LocalDate date;
  private int fips;
  private int cases;
  private int deaths;
  
  public Data(LocalDate date, int fips, int cases, int deaths){
    this.date = date;
    this.fips = fips;
    this.cases = cases;
    this.deaths = deaths;
  }
  
  public LocalDate getDate(){
    return date;
  }
  
  public int getFips(){
    return fips;
  }
  
  public int getCases(){
    return cases;
  }
  
  public int getDeaths(){
    return deaths;
  }
  
  public void draw(int x, float scale){
    int h = ceil(cases * scale);
    noStroke();
    int alive = cases - deaths;
    int deathHeight = int(deaths * scale);
    int aliveHeight = ceil(alive * scale);
    fill(255, 0, 0);
    rect(x, height - h - 90, 2, deathHeight);
    fill(255,182,193);
    rect(x, height - h - 90 + deathHeight, 2, aliveHeight);
  }
  
  public void drawTooltip(int x, float scale){
    if(x <= mouseX && mouseX < x+2){
      int h = ceil(cases * scale);
      String s = "Date: " + date + "\nCases: " + cases + "\nDeaths: " + deaths;
      fill(0, 0, 0, 50);
      rect(x, 0, 2, height);
      fill(255, 255, 255, 50);
      rect(x, height - h - 250, textWidth(s) + 20, 160);
      fill(0);
      text(s, x + 10, height - h - 200);
    }
  }
  
  public String toString(){
    return "Data(" + date + ", " + fips + ", " + cases + ", " + deaths + ")";
  }
}

public class Logger {
  ArrayList<Entry> items = new ArrayList<Entry>();
  int activeItem = -1, top, x, y;
  Logger(int x, int top) {
    this.x = x;
    this.top = top;
    y = top;
  }
  
  public void addLine(String item, float startTime, boolean isActive) {
    if(items.size()>17){
      items.remove(0);
    }
    
    
    items.add(new Entry(item, startTime));
    if (isActive) {
      activeItem = items.size()-1;
    }
    text(items.get(items.size()-1).getOutputString(), x, y+2);
    fill(255);
    ellipse(x-5, y-3, 2, 2);
    fill(0);
    y += 17;
  }
  
  public void updateActiveItem(float videoTime){
    if(activeItem > -1){
      items.get(activeItem).elapsedTime = videoTime - items.get(activeItem).startTime;
    }
  }

  public void stopTimers() {
    activeItem = -1;
  }

  public void render() {
    y = top;
    int arraySize = items.size();
    for (int i = 0; i < arraySize; i++) {
      text(items.get(i).getText(), x, y);
      if (i == activeItem) {
        fill(255, 0, 0);
        rect(x+295, y-13, 45, 17);
        fill(255);
        text(items.get(i).getTime(), x+300, y);
        fill(0);
      } else {
        fill(0);
        text(items.get(i).getTime(), x+300, y);
      }
      
      y+=17;
    }
  }
}

public class Entry{
  String text;
  float elapsedTime, startTime;
  Entry(String text, float startTime){
    this.text = text;
    this.startTime = startTime;
  }
  
  public String getText(){
    return text; 
  }
  
  public String getTime(){
    return secondsToMMSS((int)elapsedTime); 
  }
  
  public String getOutputString(){
    return text + " " + secondsToMMSS((int)elapsedTime); 
  }
}
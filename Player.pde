import processing.video.*;

public class Player {
  Movie mov;
  int x, y, xSize, ySize;
  float ratio;
  boolean autoplay = true;
  PApplet app;

  File videoFile, accelerometerFile;

  Player(PApplet papp, File video, File accelerometerFile, Boolean autoplay, int x, int y, int ySize) {
    app = papp;
    videoFile = video;
    this.accelerometerFile = accelerometerFile;
    
    this.autoplay = autoplay;
    this.x = x;
    this.y = y;
    this.ySize = ySize;
    mov = new Movie(app, video.getAbsolutePath());
    mov.play();
    mov.jump(0);
    if (autoplay == false) {
      pause();
    }
    gui();
    render(); 
    if(accelerometerFile != null){
      renderBarChart();
    }
  }

  Button play, pause;

  PImage muteb, mute_click, mute_hover, mediumb, medium_click, medium_hover, loudb, loud_click, loud_hover;
  PImage play_click, play_hover, playb;
  PImage pause_click, pause_hover, pauseb;
  PImage backb, back_click, back_hover;
  PImage forwardb, forward_click, forward_hover;
  PImage screenb,screen_click,screen_hover;
  Slider videoLength;

  public void gui() {
    
    //PLAY BUTTON
    playb=loadImage(dataPath("images/play.png"));
    play_click=loadImage(dataPath("images/play_click.png"));
    play_hover=loadImage(dataPath("images/play_hover.png"));
    playb.resize(25, 25);
    play_click.resize(25, 25);
    play_hover.resize(25, 25);

    //PAUSE BUTTON
    pauseb=loadImage(dataPath("images/pause.png"));
    pause_click=loadImage(dataPath("images/pause_click.png"));
    pause_hover=loadImage(dataPath("images/pause_hover.png"));
    pauseb.resize(25, 25);
    pause_click.resize(25, 25);
    pause_hover.resize(25, 25);

    //MUTE BUTTON
    muteb=loadImage(dataPath("images/mute.png"));
    mute_click=loadImage(dataPath("images/mute_click.png"));
    mute_hover=loadImage(dataPath("images/mute_hover.png"));
    muteb.resize(25, 25);
    mute_click.resize(25, 25);
    mute_hover.resize(25, 25);

    //MEDIUM VOL BUTTON
    mediumb=loadImage(dataPath("images/medium.png"));
    medium_click=loadImage(dataPath("images/medium_click.png"));
    medium_hover=loadImage(dataPath("images/medium_hover.png"));
    mediumb.resize(25, 25);
    medium_click.resize(25, 25);
    medium_hover.resize(25, 25);

    //LOUD VOL BUTTON
    loudb=loadImage(dataPath("images/loud.png"));
    loud_click=loadImage(dataPath("images/loud_click.png"));
    loud_hover=loadImage(dataPath("images/loud_hover.png"));
    loudb.resize(25, 25);
    loud_click.resize(25, 25);
    loud_hover.resize(25, 25);

    //BACK BUTTON
    backb=loadImage(dataPath("images/back.png"));
    back_click=loadImage(dataPath("images/back_click.png"));
    back_hover=loadImage(dataPath("images/back_hover.png"));
    backb.resize(25, 25);
    back_click.resize(25, 25);
    back_hover.resize(25, 25);

    //FORWARD BUTTON
    forwardb=loadImage(dataPath("images/forward.png"));
    forward_click=loadImage(dataPath("images/forward_click.png"));
    forward_hover=loadImage(dataPath("images/forward_hover.png"));
    forwardb.resize(25, 25);
    forward_click.resize(25, 25);
    forward_hover.resize(25, 25);

    //SCREENSHOT BUTTON
    screenb=loadImage(dataPath("images/screen.png"));
    screen_click=loadImage(dataPath("images/screen_click.png"));
    screen_hover=loadImage(dataPath("images/screen_hover.png"));
    screenb.resize(55, 55);
    screen_click.resize(55, 55);
    screen_hover.resize(55, 55);

  


    //****BUTTONS****
    
    //Play button
    play =gui.addButton("btnPlay")
      .setPosition(35, 320)//setting the position
      .setImages(playb, play_hover, play_click)//setting all the images
      .setSize(25, 25)//setting the size of the button
      .plugTo(this);//enabling the button
    play.getCaptionLabel();

    //Pause button
    Button pause =gui.addButton("pause")
      .setPosition(5, 320)
      .setImages(pauseb, pause_hover, pause_click)
      .setSize(25, 25)
      .plugTo(this);
    pause.getCaptionLabel();

    //Video slider
    videoLength =gui.addSlider("slider")
      .setSize(170, 15)
      .setLabelVisible(false)//hiding the label from slider
      .setColorBackground(0)
      .setPosition(70, 325)
      .setRange(0, mov.duration())
      .plugTo(this);
      
      videoLength.getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
      videoLength.getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
     
    //Mute button
    Button Mute =gui.addButton("mute")
      .setImages(muteb, mute_hover, mute_click)
      .setSize(25, 25)
      .setPosition(300, 320)
      .plugTo(this);
    Mute.getCaptionLabel();
    
    //Medium vol button
    Button Medium =gui.addButton("Medium")
      .setImages(mediumb, medium_hover, medium_click)
      .setSize(25, 25)
      .setPosition(335, 320)
      .plugTo(this);
    Medium.getCaptionLabel();

    //High vol button
    Button High =gui.addButton("High")
      .setImages(loudb, loud_hover, loud_click)
      .setSize(25, 25)
      .setPosition(370, 320)
      .plugTo(this);
    High.getCaptionLabel();

    //Speed Control List
    ScrollableList Speed = gui.addScrollableList("SpeedControl")
      .setPosition(400, 325)
      .setSize(80, 100)
      .setItemHeight(13)
      .setBarHeight(13)
      .setOpen(false)
      .addItem("Speed x 0.5", 0.5)//Adding all the values of the Speed Control list
      .addItem("Speed x 1", 0.99)
      .addItem("Speed x 1.5", 1.5) 
      .addItem("Speed x 2", 1.99)
      .setColorBackground(0)
      .plugTo(this);

    //Back button
    Button Back =gui.addButton("Back")
      .setImages(backb, back_hover, back_click)
      .setPosition(490, 320)
      .setSize(25, 25)
      .plugTo(this);
      
    //forward button
    Button forward=gui.addButton("forward")
      .setImages(forwardb, forward_hover, forward_click)
      .setPosition(525, 320)
      .setSize(25, 25)
      .plugTo(this);
      
      Boolean save;
     //Screenshot Button
     Button screenshot=gui.addButton("screenshot")
       .setImages(screenb,screen_hover,screen_click)
       .setPosition(945,545)
       .setSize(55,55)
       .setColorBackground(0)
       .plugTo(this);
  }
  
  
  public void renderBarChart(){
    ArrayList<String> data = new ArrayList<String>(Arrays.asList(loadStrings(accelerometerFile.getAbsolutePath())));
    data.remove(0); //remove first row of column headings
    
    FloatList accDataX = new FloatList(), accDataY = new FloatList(), accDataZ = new FloatList();
    
    for (String x : data) {
      String[] row = (x.split(","));
      accDataX.append(Float.valueOf(row[0]));
      accDataY.append(Float.valueOf(row[1]));
      accDataZ.append(Float.valueOf(row[2]));
    }
    
    float max;
    if(accDataX.max() > accDataY.max() && accDataX.max() > accDataZ.max()){
      max = accDataX.max();
    } else if(accDataY.max() > accDataX.max() && accDataY.max() > accDataZ.max()){
      max = accDataY.max();
    } else {
      max = accDataZ.max();
    }
    
    Chart myChart;
    myChart = gui.addChart("acccelerometerChart")
                 .setPosition(5,395)
                 .setSize(560, 200)
                 .setRange(-max, max)
                 .setCaptionLabel("")
                 .setView(Chart.LINE)
                 .setStrokeWeight(1.5)
                 .plugTo(this);
                 
  
    myChart.addDataSet("accelX");
    myChart.setData("accelX", accDataX.array());
    
    myChart.addDataSet("accelY");
    myChart.setData("accelY", accDataY.array());
    
    myChart.addDataSet("accelZ");
    myChart.setData("accelZ", accDataZ.array());
    
    myChart.setColors("accelZ", color(255, 0, 255),color(255,0,0));
    myChart.setColors("accelY", color(255, 0, 0),color(255,0,0));
    myChart.setColors("accelZ", color(0, 255, 255),color(255,0,0));
  }
  

  public void acccelerometerChart(){
    println("hit");
  }
  
  
  public void screenshot()
  {
    String desktopPath=System.getProperty("user.home")+"/Desktop";//seting the path of the screenshot
    saveFrame( System.getProperty("user.home") + "/Desktop/MewObs_####.png");//seting the name of the screenshot
  }
  
  //**VIDEO CONTROL**
  
  public void SpeedControl(int n) {
    mov.speed((float)gui.get(ScrollableList.class, "SpeedControl").getItem(n).get("value"));
  }
  
  public void mute()
  {
    mov.volume(0);
  }
  public void Medium()
  {
    mov.volume(0.5);
  }
  public void High()
  {
    mov.volume(1);
  }

  public void pause()
  {
    mov.pause();
  }

  public void btnPlay() {
    mov.play();
  }

  public void slider(float value)
  {
    //mov.jump(value);
  }

  public void Back()
  {
    mov.jump(mov.time()-5);
  }
  public void forward()
  {
    mov.jump(mov.time()+5);
  }

  public float getTime() {
    return mov.time();
  }

  public float getDuration() {
    return mov.duration();
  }


  void keyPressed() {    
    if (key == ESC) 
    {
      key = 0;
    }
  }

  public void render() {
    if (mov.available() == true) {
      videoLength.setValue(mov.time());
      mov.read();
      text(secondsToMMSS((int)mov.time()),249,337);//Elapsed video time
      ratio = (float) mov.width / mov.height;
    }
    image(mov, x, y, ratio * ySize, ySize);
    
          float md = mov.duration();
      float mt = mov.time();
      float m = map(mt, 0,md,0,565);
            line(m, 0,m ,565);

      strokeWeight(1);
      textSize(24);
      text(mt,25,25);
      stroke(255);
    
  }
}
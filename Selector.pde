import java.util.*;
import javax.swing.JOptionPane;

public class Selector {
  File videoFile;
  File configFile;
  File accelerometerFile;
  Mode nextState;

  //All Fonts Used
  ControlFont cf1 = new ControlFont(createFont("Arial", 15, true));
  ControlFont cf3 = new ControlFont(createFont("Arial", 10, true));
  ControlFont cf2 = new ControlFont(createFont("Helvetica", 54, true));

  //All buttons,Labels Used
  Textlabel title;
  Button btnVideo;
  Button btnSettings;
  Button btnNextState;
  Button btnAccelerometer;
  Button btnConfigmaker;

  Selector(Mode nextState) {
    background(background1);
    this.nextState = nextState;

    //TITLE
    title = gui.addLabel("Welcome to MewObs")
      .setPosition(200, 50)
      .setColor(0)
      .setFont(cf2)
      .plugTo(this);

    //VIDEO BUTTON
    btnVideo = gui.addButton("videoSelector")
      .setLabel("1) Choose Video File") //**Setting the label
      .setPosition(150, 200) //**Setting the position
      .setColorBackground(0) //**Setting the Background Color
      .setSize(200, 50) //**Setting the Size of the button
      .plugTo(this); //**Enabling the button
    btnVideo.getCaptionLabel().toUpperCase(true).setFont(cf1); //**Setting a font.

    //FILE BUTTON
    btnSettings = gui.addButton("configSelector")
      .setLabel("2a) Choose Config File")
      .setPosition(380, 200)
      .setColorBackground(0)
      .setSize(200, 50)
      .plugTo(this);
    btnSettings.getCaptionLabel().toUpperCase(true).setFont(cf1);
    
    //CONFIG CREATOR BUTTON
     btnConfigmaker = gui.addButton("configCreator")
      .setLabel("2b) Create Config File")
      .setPosition(380, 270)
      .setColorBackground(0)
      .setSize(200, 50)
      .plugTo(this);
    btnConfigmaker.getCaptionLabel().toUpperCase(true).setFont(cf1);

    //NEXT BUTTON
    btnNextState = gui.addButton("toNextState")
      .setLabel("3) Next")
      .setPosition(610, 200)
      .setColorBackground(0)
      .setSize(200, 50)
      .plugTo(this);
    btnNextState.getCaptionLabel().toUpperCase(true).setFont(cf1);

    //ACCELEROMETER BUTTON
    btnAccelerometer=gui.addButton("AccelerometerSelector")
      .setLabel("*Accelerometer*")
      .setPosition(880,550)
      .setColorBackground(0)
      .setSize(100, 40)
      .plugTo(this);
  btnAccelerometer.getCaptionLabel().toUpperCase(true).setFont(cf3);

    //Warning message
    textSize(14);
    fill(0);
    text("Video and config files are mandatory. If you would like to view an accelerometer file you can add it here:", 160, 575);
  }

  void videoSelector() {
    selectInput("Select a video to process:", "videoFileSelected", null, this);
  }

  //Video file Selection
  void videoFileSelected(File selection) {
    if (selection != null) {
      JOptionPane.showMessageDialog(null, "File Chosen Succesfully,If needed to change click again", "File Confirmation", javax.swing.JOptionPane.INFORMATION_MESSAGE);
      if (isValidFileType(selection, new String[]{"mp4", "mov"}) == true)//**Supported Video Files {
        videoFile = selection;
      } else {//Error message
        JOptionPane.showMessageDialog(null, "Unsupported file type", "Unsupported file type", javax.swing.JOptionPane.INFORMATION_MESSAGE);
      }
    }
  
  void configSelector() {
    selectInput("Select a video to process:", "configFileSelected", null, this);
  }

  //Config File Selection
  void configFileSelected(File selection) {
    if (selection != null) {
      JOptionPane.showMessageDialog(null, "File chosen successfully. If you need to select a different file click again","File Confirmation", javax.swing.JOptionPane.INFORMATION_MESSAGE);
      if (isValidFileType(selection, new String[]{"csv", "txt"}) == true)//**Supported config Files {
        configFile = selection;
      } else {//Error message
        JOptionPane.showMessageDialog(null, "Unsupported file type", "Unsupported file type", javax.swing.JOptionPane.INFORMATION_MESSAGE);
      }
    }
  

  void AccelerometerSelector() {
    selectInput("Select a video Accelerometer to process:", "AccelerometerSelected", null, this);
  }
//Accelerometer File Selection
  void AccelerometerSelected(File selection) {
    if (selection != null) {
      JOptionPane.showMessageDialog(null, "File chosen successfully. If you need to select a different file click again", "File Confirmation", javax.swing.JOptionPane.INFORMATION_MESSAGE);
      if (isValidFileType(selection, new String[]{"csv"}) == true)//**Supporter Accelerometer File {
        accelerometerFile = selection;
      } else {//Error message
        JOptionPane.showMessageDialog(null, "Unsupported file type", "Unsupported file type", javax.swing.JOptionPane.INFORMATION_MESSAGE);
      }
    }
  



  //Takes you from SELECTOR mode to PLAY
  void toNextState() {
    if (configFile ==null || videoFile==null)//checking if all the files are included
    { 
      JOptionPane.showMessageDialog(null, "Please Provide the fields", "1 or more Fields Empty", javax.swing.JOptionPane.INFORMATION_MESSAGE);
    } else {
      surface.setTitle("MewObs - " + configFile.getName().replaceFirst("[.][^.]+$", ""));
      //Hiding the Selector Gui
      title.hide();
      btnVideo.hide();
      btnSettings.hide();
      btnNextState.hide();
      btnAccelerometer.hide();
       btnConfigmaker.hide();
      refreshState(nextState);
    }
  }
  
  
  public void configCreator(){
     // text("test",100,500);
     btnConfigmaker.hide();
      title.hide();
      btnVideo.hide();
      btnSettings.hide();
      btnNextState.hide();
      btnAccelerometer.hide();
      refreshState(Mode.MAKER);
  }

  //File validation checking
  private boolean isValidFileType(File file, String[] acceptedTypes) {
    String extension, path = file.getAbsolutePath();
    int i = path.lastIndexOf('.');
    int p = Math.max(path.lastIndexOf('/'), path.lastIndexOf('\\'));
    if (i > p) {
      extension = path.substring(i+1).toLowerCase();
      List valid = Arrays.asList(acceptedTypes);
      if (valid.contains(extension)) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
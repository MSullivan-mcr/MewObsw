import java.io.*; //<>//
import java.lang.*;

final int STEVE = 1;
final int GROUP = 2;
final int LOG = 3;
final int OTHER = 4;

public class EventRecorder {
  ArrayList<Event> events;
  String userVars;
  String videoFileName;
  FileWriter output;
  File outputFile;
  File configFile;
  File Accelerometer;
  Logger logger;
  EventRecorder(File configFile, String videoFileName, File Accelerometer) {
    logger = new Logger(600, 40); //<>//
    this.configFile = configFile;
    this.Accelerometer = Accelerometer;
    Date d = new Date();
    new File(dataPath("")).mkdirs();
    new File(dataPath("logs")).mkdirs();
    this.outputFile = new File(dataPath("logs/" + d.getTime() + ".csv"));
    if (!outputFile.exists()) {
      try {
        outputFile.createNewFile();
      } 
      catch (IOException err) {
        println("Error occoured trying to create file");
        err.printStackTrace();
      }
    }
    this.videoFileName = videoFileName;
    ArrayList<String> behaviours = new ArrayList<String>(Arrays.asList(loadStrings(configFile.getAbsolutePath())));
    behaviours.remove(0); //remove first row of column headings
    events = new ArrayList<Event>();
    for (String x : behaviours) {
      String[] row = (x.split(","));
      switch(Integer.valueOf((row[0]))) {
      case STEVE:
    //   println(row[0]);
     println(row[1].charAt(0), row[2], row[3], row[4]);
        if (!row[2].trim().equalsIgnoreCase("na")) {
          events.add(new Event(row[1].charAt(0), row[2], row[3], row[4]));
        }
        break;
      case GROUP:
        if (!row[2].trim().equalsIgnoreCase("na")) {
          userVars = String.join(",", new String[]{row[1], row[2], row[3], row[4]});
        }
println(userVars);
        break;
      case LOG:
        events.add(new Event(row[1].charAt(0), row[2], row[3], row[4]));
      }
    }
    try {
      output = new FileWriter(outputFile.getAbsolutePath(), true);
      output.write("label, steve, meg, time, duration," + userVars +  "\n" );
      output.flush();
    } 
    catch(IOException err) {
      println("Couldn't get output file.");
      err.printStackTrace();
    }
  }

  public void render() {
    int y=380;
    int x=10;
    int rows=0;
    text(userVars, 620, 20);
    logger.render();

    for (Event e : events) {
      if (Accelerometer==null)
      {    //Loading up the keys used if no accelerometer.
        textSize(12);
        fill(0);
        text("Keys Used in this File:", 170, 360);
        textSize(12);
        fill(0);
        text(e.keyStroke+" "+e.label, x, y);
        y+=15;
        rows++;

        if (rows==14) {
          rows=0;
          x=x+155;
          y=380;
        }
      } else {

        textSize(12);
        fill(0);
        text("Accelerometer File:", 170, 390);
        //Loading the keys in different position  when accelerometer is available 
        textSize(12);
        fill(0);
        text("Keys Used in this File:", 700, 360);
        textSize(12);
        fill(0);
        text(e.keyStroke+")"+" "+e.label, x+600, y);
        y+=15;
        rows++;

        if (rows==14) {
          rows=0;
          x=x+155;
          y=380;
        }
      }
    }
  }

  public void updateLogEvents(float vidTime) {
    logger.updateActiveItem(vidTime);
  }

  public void keyEvent(char k, float time, float duration) {
    if (k == 'x') {
      saveFile();
    }
    //make this a dynamic key
    for (Event e : events) {
      if (e.keyStroke == k) {
        // dont break out of loop incase multiple steves are required for a single keystokes
        try {

                 output.write(e.getOutputString(",") + "," + time + "," + duration + "," + userVars +  "\n" );

          output.flush();
          logger.addLine(e.getGUIString() + "     " + secondsToMMSS((int)time), time, true);
        } 
        catch (IOException err) {
          println("Error occoured trying to write to file");
          err.printStackTrace();
        }
      }
    }
  }
  public void saveFile() {
    selectFolder("Choose output location:", "outputDirectorySelected", null, this);
  }

  public void outputDirectorySelected(File selection) {
    if (selection != null) {
      String outputFileName = JOptionPane.showInputDialog(null, "Choose output file name", videoFileName.replaceFirst("[.][^.]+$", "") + "_" + configFile.getName().replaceFirst("[.][^.]+$", ""));
      File renamedOutput = new File(selection.getAbsolutePath()+ "/" + outputFileName + ".csv");
      if (outputFileName != null) {
        if (renamedOutput.exists() == true && JOptionPane.showConfirmDialog(null, "File already exists, do you want to overwrite it?", "Override File", JOptionPane.YES_NO_OPTION) != JOptionPane.YES_OPTION) {
          JOptionPane.showMessageDialog(null, "Cancelled saving file", "Cancelled saving file", javax.swing.JOptionPane.INFORMATION_MESSAGE);
          return;
        }
        try {
          output.flush();
          output.close();
          outputFile.renameTo(renamedOutput);
        } 
        catch (IOException err) {
 
          println("Error occoured trying to write to file");         err.printStackTrace();
        }
      } else {
        JOptionPane.showMessageDialog(null, "Input failed", "File name cannot be empty", javax.swing.JOptionPane.INFORMATION_MESSAGE);
      }
    } else {
      JOptionPane.showMessageDialog(null, "Cancelled saving file", "Cancelled saving file", javax.swing.JOptionPane.INFORMATION_MESSAGE);
    }
  }
}

public class Event {
  char keyStroke;
  String label, steve, meg;
  Event(char keyStroke, String label, String steve, String meg) {
    this.keyStroke = keyStroke;
    this.label = label;
    this.steve = steve;
    this.meg = meg;
  }

  String getOutputString(String seperator) {
    String[] toWrite = new String[3];
    toWrite[0] = label;
    toWrite[1] = steve;
    toWrite[2] = meg;
    return join(toWrite, seperator);
  }

  String getGUIString() {
    String[] toWrite = new String[3];
    toWrite[0] = ( steve == "eve" ? "Event: " : "State :");
    toWrite[1] = label.substring(0, 1).toUpperCase() + label.substring(1).toLowerCase();
    toWrite[2] = meg.substring(0, 1).toUpperCase() + meg.substring(1).toLowerCase();
    return join(toWrite, "     ");
  }
}


public class ConfigMaker {
  PApplet papp;
  int x = 10, y = 140, index;
  String prefix = "enterControl_";
  ControlFont cf1 = new ControlFont(createFont("Arial", 15, true));
  ControlFont cf2 = new ControlFont(createFont("Helvetica", 54, true));
  ControlFont cf3 = new ControlFont(createFont("Arial", 22, true));

  ArrayList<ConfigRow> rows;

  Textlabel title;
  Textfield txtEditMe1, txtEditMe2, txtEditMe3, txtEditMe4, txtEditMe5, txtEditMe6;
  Button btnSave, btnBack;


  ConfigMaker(PApplet app) {
    papp = app;

    rows = new ArrayList<ConfigRow>();

    drawLabels();
    drawNewRow();


    title = gui.addLabel("Config Maker Section")
      .setPosition(200, 0)
      .setColorBackground(0)
      .setColor(0)
      .setFont(cf2)
      .plugTo(this);

    txtEditMe1 = gui.addTextfield("EditMe1")
      .setPosition(10, 80)
      .setColorBackground(0)
      .setSize(100, 20)
      .setFocus(true)
      .setFont(cf1)
      .setCaptionLabel("") 
      .plugTo(this);


    txtEditMe2 = gui.addTextfield("EditMe2")
      .setPosition(120, 80)
      .setColorBackground(0)
      .setSize(100, 20)
      .setFocus(true)
      .setFont(cf1)
      .setCaptionLabel("") 
      .plugTo(this);

    txtEditMe3 = gui.addTextfield("EditMe3")
      .setPosition(230, 80)
      .setColorBackground(0)
      .setSize(100, 20)
      .setFocus(true)
      .setFont(cf1)
      .setCaptionLabel("") 
      .plugTo(this);

    txtEditMe4 = gui.addTextfield("EditMe4")
      .setPosition(340, 80)
      .setColorBackground(0)
      .setSize(100, 20)
      .setFocus(true)
      .setFont(cf1)
      .setCaptionLabel("") 
      .plugTo(this);
      
    txtEditMe5 = gui.addTextfield("EditMe5")
      .setPosition(450, 80)
      .setColorBackground(0)
      .setSize(100, 20)
      .setFocus(true)
      .setFont(cf1)
      .setCaptionLabel("") 
      .plugTo(this);


    txtEditMe6 = gui.addTextfield("EditMe6")
      .setPosition(560, 80)
      .setColorBackground(0)
      .setSize(100, 20)
      .setFocus(true)
      .setFont(cf1)
      .setCaptionLabel("") 
      .plugTo(this);


    btnSave = gui.addButton("Save")
      .setPosition(880, 550)
      .setSize(100, 40)
      .setColorBackground(0)
      .setFont(cf3)
      .setLabel("Save")
      .plugTo(this);

    btnBack = gui.addButton("Back")
      .setPosition(880, 500)
      .setSize(100, 40)
      .setColorBackground(0)
      .setFont(cf3)
      .setLabel("Back")
      .plugTo(this);
  }



  public void drawNewRow() {
    Textfield keyField = gui.addTextfield(prefix + index +  "_key")
      .setPosition(x, y+20)
      .setColorBackground(0)
      .setSize(50, 20)
      .setFocus(true)
      .setFont(cf1)
      .setCaptionLabel("") 
      .plugTo(this);


    Textfield labelField = gui.addTextfield(prefix + index +  "_label")
      .setPosition(x + 70, y+20)
      .setColorBackground(0)
      .setSize(200, 20)
      .setFont(cf1)
      .setCaptionLabel("") 
      .plugTo(this);

    RadioButton r = gui.addRadioButton(prefix + index +  "_steve")
      .setPosition(x+300, y+20)
      .setSize(40, 20)
      .setItemsPerRow(2)
      .setColorBackground(0)
      .setSpacingColumn(50)
      .addItem(prefix + index + "State", 0)
      .addItem(prefix + index + "Event", 1)
      .hideLabels()
      .setValue(1)
      .plugTo(this);

    Textlabel state = gui.addLabel(prefix + index +  "_state")
      .setPosition(x+340, y+20)
      .setText("State")
      .setFont(createFont("Arial", 15))
      .plugTo(this);

    Textlabel event = gui.addLabel(prefix + index +  "_event")
      .setPosition(x+430, y+20)
      .setText("Event")
      .setFont(createFont("Arial", 15))
      .plugTo(this);

    r.activate(0);

    Textfield megField = gui.addTextfield(prefix + index +  "_meg")
      .setPosition(x + 510, y+20)
      .setColorBackground(0)
      .setSize(200, 20)
      .setFont(cf1)
      .setCaptionLabel("") 
      .plugTo(this);

    rows.add(new ConfigRow(keyField, labelField, r, state, event, megField));
    index++;
    y+= 30;
    if (index < 15) {
      drawAddButton(false);
    } else {
      drawAddButton(true);
    }
  }

  Button addButton = null;
  public void drawAddButton(boolean hideButton) {
    if (addButton == null) {
      addButton = gui.addButton("drawNewRow")
        .setPosition(360, y+20)
        .setFont(cf1)
        .setLabel("Add")
        .plugTo(this);
    } else {
      background(background1);
      drawLabels();
      if (hideButton) {
        addButton.hide();
      } else {
        addButton.setPosition(360, y+20);
      }
    }
  }

  public void drawLabels() {
    textSize(15);
    text("Key", x, 155);
    text("Label", x + 70, 155);
    text("StEve", x + 345, 155);
    text("MEG", x + 510, 155);
    text("EditMe1", 10, 75);
    text("EditMe2", 120, 75);
    text("EditMe3", 230, 75);
    text("EditMe4", 340, 75);
    text("EditMe5", 450, 75);
    text("EditMe6", 560, 75);
  }

  public void Back() {
    for (ConfigRow r : rows) {
      r.hide();
    }
    addButton.hide();
    title.hide();
    txtEditMe1.hide(); 
    txtEditMe2.hide(); 
    txtEditMe3.hide(); 
    txtEditMe4.hide(); 
    txtEditMe5.hide(); 
    txtEditMe6.hide();
    btnSave.hide(); 
    btnBack.hide();
    refreshState(Mode.SELECTOR);
  }

  public void Save() {
    selectFolder("Choose output location:", "outputDirectorySelected", null, this);
  }

  public void outputDirectorySelected(File selection) {
    if (selection != null) {
      String outputFileName = JOptionPane.showInputDialog(null, "Choose output file name", "");
      File renamedOutput = new File(selection.getAbsolutePath()+ "/" + outputFileName + ".csv");
      if (outputFileName != null) {
        if (renamedOutput.exists() == true && JOptionPane.showConfirmDialog(null, "File already exists, do you want to overwrite it?", "Override File", JOptionPane.YES_NO_OPTION) != JOptionPane.YES_OPTION) {
          JOptionPane.showMessageDialog(null, "Cancelled saving file", "Cancelled saving file", javax.swing.JOptionPane.INFORMATION_MESSAGE);
          return;
        }
        try {
          FileWriter output = new FileWriter(renamedOutput.getAbsolutePath(), true);
          output.write("type, key, label, steve, meg " + "\n" );

          for (ConfigRow r : rows) {
            output.write(r.getRowAsCSVString());
          }
          
          output.write("2" + ", " + txtEditMe1.getText() + "," + txtEditMe2.getText() + "," + txtEditMe3.getText() + "," + txtEditMe4.getText() + "," + txtEditMe5.getText() + "," + txtEditMe6.getText() + "\n");

          output.flush();
          output.close();
        } 
        catch (IOException err) {
          println("Error occoured trying to write to file");         
          err.printStackTrace();
        }
      } else {
        JOptionPane.showMessageDialog(null, "Input failed", "File name cannot be empty", javax.swing.JOptionPane.INFORMATION_MESSAGE);
      }
    } else {
      JOptionPane.showMessageDialog(null, "Cancelled saving file", "Cancelled saving file", javax.swing.JOptionPane.INFORMATION_MESSAGE);
    }
  }
}

public class ConfigRow {
  Textfield key;
  Textfield label;
  RadioButton steve;
  Textlabel state, event;
  Textfield meg;

  ConfigRow(Textfield key, Textfield label, RadioButton steve, Textlabel state, Textlabel event, Textfield meg) {
    this.key = key;
    this.label = label;
    this.steve = steve;
    this.state = state;
    this.event = event;
    this.meg = meg;
  }

  public String getRowAsCSVString() {
    String str = "1, ";
    str += key.getText() + ",";
    str += label.getText() + ",";
    if (steve.getValue() == 0) {
      str += "st,";
    } else {
      str += "eve,";
    }
    str += meg.getText() + "\n";
    return str;
  }

  public void hide() {
    key.hide();
    label.hide();
    steve.hide();
    state.hide();
    event.hide();
    meg.hide();
  }
}
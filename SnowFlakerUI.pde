class SnowFlakerUI {
  
  int LIGHT_BACKGROUND = 0;
  int DARK_BACKGROUND = 1; 
  color SELECTED_BG = color(200,0,0);
  color SELECTED_FG = color(255);
  color UNSELECTED_BG = color(255);
  color UNSELECTED_FG = color(74);
  color UNSELECTED_BORDER = color(229);  
  int ICON_SIZE = 15;
  int BUTTON_HEIGHT = 40;  
  int BUTTON_WIDTH = 40;
  
  int[] positions = {0,BUTTON_WIDTH,2*BUTTON_WIDTH,3*BUTTON_WIDTH,7*BUTTON_WIDTH,12*BUTTON_WIDTH,13*BUTTON_WIDTH,14*BUTTON_WIDTH,15*BUTTON_WIDTH,16*BUTTON_WIDTH,17*BUTTON_WIDTH};
   
  PImage[] icon_line = new PImage[2];
  PImage[] icon_circle = new PImage[2];
  PImage[] icon_arc = new PImage[2];
  PImage[] icon_weight_1 = new PImage[2];
  PImage[] icon_weight_2 = new PImage[2];
  PImage[] icon_weight_3 = new PImage[2];
  PImage[] icon_weight_4 = new PImage[2];
  PImage[] icon_background = new PImage[1];
  PImage[] icon_grid = new PImage[2];
  PImage[] icon_axis = new PImage[1];
  PImage[] icon_undo = new PImage[1];
  PImage[] icon_save = new PImage[1];

  SnowFlakerUI() {       
    icon_line[0] = loadImage("icons/png/line.png");
    icon_line[1] = loadImage("icons/png/line_selected.png");
    icon_circle[0] = loadImage("icons/png/circle.png");
    icon_circle[1] = loadImage("icons/png/circle_selected.png");
    icon_arc[0] = loadImage("icons/png/arc.png");    
    icon_arc[1] = loadImage("icons/png/arc_selected.png");
    icon_weight_1[0] = loadImage("icons/png/weight_1.png");
    icon_weight_1[1] = loadImage("icons/png/weight_1_selected.png");
    icon_weight_2[0] = loadImage("icons/png/weight_2.png");
    icon_weight_2[1] = loadImage("icons/png/weight_2_selected.png");
    icon_weight_3[0] = loadImage("icons/png/weight_3.png");
    icon_weight_3[1] = loadImage("icons/png/weight_3_selected.png");
    icon_weight_4[0] = loadImage("icons/png/weight_4.png");
    icon_weight_4[1] = loadImage("icons/png/weight_4_selected.png");    
    icon_background[0] = loadImage("icons/png/background.png");    
    icon_grid[0] = loadImage("icons/png/grid.png");
    icon_grid[1] = loadImage("icons/png/grid_selected.png");
    icon_axis[0] = loadImage("icons/png/axis.png");            
    icon_undo[0] = loadImage("icons/png/undo.png");        
    icon_save[0] = loadImage("icons/png/save.png");
  }

  void display() {
        
    // Drawing tools
    drawButton(positions[0], BUTTON_WIDTH, icon_line, true, mode==MODE_LINES); // Line        
    drawButton(positions[1], BUTTON_WIDTH, icon_circle, true, mode == MODE_CIRCLES); // Circle        
    drawButton(positions[2], BUTTON_WIDTH, icon_arc, true, mode==MODE_ARCS); // Arc            

    // Drawing weight selection area
    drawButton(positions[3], 120,icon_weight_1, false, currentWeight==1);
    drawButton(positions[3]+BUTTON_WIDTH, BUTTON_WIDTH,icon_weight_2, false, currentWeight==3);
    drawButton(positions[3]+2*BUTTON_WIDTH, BUTTON_WIDTH,icon_weight_3, false, currentWeight==5);
    drawButton(positions[3]+3*BUTTON_WIDTH, BUTTON_WIDTH,icon_weight_4, false, currentWeight==7);    
    stroke(UNSELECTED_BORDER);
    strokeWeight(1);
    noFill();
    rect(positions[3],height-BUTTON_HEIGHT, 4*BUTTON_WIDTH, BUTTON_HEIGHT);

    // Drawing color selection area                
    stroke(UNSELECTED_BORDER);
    strokeWeight(1);
    fill(UNSELECTED_BG);
    rect(positions[4],height-BUTTON_HEIGHT, 5*BUTTON_WIDTH, BUTTON_HEIGHT);    
    fill(SELECTED_BG);
    rect(positions[4]+currentColor*BUTTON_WIDTH, height-BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT);    
    for (int i=0; i<colors.length; i++) {
      fill(colors[i]);
      stroke(255);
      strokeWeight(3);
      int color_selector_size = 12;      
      int padding_color = (BUTTON_WIDTH-color_selector_size)/2;
      ellipseMode(CORNER);
      ellipse(positions[4]+padding_color+(color_selector_size+2*padding_color)*i, height-padding_color-color_selector_size, color_selector_size,color_selector_size);
      ellipseMode(CENTER);  
    }        

    // Other tools
    drawButton(positions[5], BUTTON_WIDTH, icon_background, true); // Background color        
    drawButton(positions[6], BUTTON_WIDTH, icon_grid, true, grid); // Grid selector        
    drawButton(positions[7], BUTTON_WIDTH, icon_axis, true); // Axis number selector            
    drawButton(positions[8], BUTTON_WIDTH, icon_undo, true); // Undo            
    drawButton(positions[9], BUTTON_WIDTH, icon_save, true); // Save        
  }
  
  void drawButton(int _x, int _button_width, PImage[] _icon, boolean drawBorder) {
    drawButton(_x, _button_width, _icon, drawBorder, false);
  }
  
  void drawButton(int _x, int _button_width, PImage[] _icon, boolean drawBorder, boolean _selected) {    
    
    // Button box& background
    if (_selected) {
      fill(SELECTED_BG);
      noStroke();      
    } else {
      fill(UNSELECTED_BG);
      if (drawBorder) {       
        stroke(UNSELECTED_BORDER);
        strokeWeight(1);  
      } else {
        noStroke();
      }      
    }
    rect(_x,height-BUTTON_HEIGHT, _button_width, BUTTON_HEIGHT);
    
    // Button icon
    if (_icon != null) {
      PImage iconState = (_selected)?_icon[1]:_icon[0];
      image(iconState, _x+ICON_SIZE-3, height-BUTTON_HEIGHT+ICON_SIZE-2);
    }    
  }
  
}
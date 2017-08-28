class SnowFlakerController {

  void processClick() {
    
    int clickX = mouseX;    
    for (int i=0; i<controls.positions.length;i++) {
      if (clickX<controls.positions[1]) {
        mode = MODE_LINES;
        return;
      } else if (clickX<controls.positions[2]) {
        mode = MODE_CIRCLES;    
        return;
      } else if (clickX<controls.positions[3]) {
        mode = MODE_ARCS;
        return;
      } else if (clickX<controls.positions[4]) {
        int offset = clickX-controls.positions[3];
        currentWeight = 2*(offset / controls.BUTTON_WIDTH) +1;
      } else if (clickX<controls.positions[5]) {
        int offset = clickX-controls.positions[4];
        currentColor = offset / controls.BUTTON_WIDTH;
    } else if (clickX<controls.positions[6]) { // Background
        currentBackground++;
        if (currentBackground >= backgrounds.length) {
          currentBackground = 0;
        };
        return;
      } else if (clickX<controls.positions[7]) { // Grid
        grid = !grid;
        return;
      } else if (clickX<controls.positions[8]) { // Axis
        numSectors+=8;
        if (numSectors > 100) numSectors = 8;
        return;
      } else if (clickX<controls.positions[9]) { // Undo
        if (shapes.size() > 0) {
          shapes.remove(shapes.size()-1);
        }
        return;
      } else if (clickX<controls.positions[10]) { // Save
        preview = true;
        draw();
        String name = "snowflake"+countImage+".tif";
        save(name);
        currentMessage = new Message("Saved as "+name, 255);
        countImage++;
        preview = false;
        return;
      }
    }        
  }
}
// import require libraries
import grafica.*;
import processing.serial.*;

// create plot instance
GPlot plot;

// initialise global variables
int i = 0; // variable that changes for point calculation
int points = 450; // number of points to display at a time
int totalPoints = 500; // number of points on x axis
long previousMillis = 0;
int duration = 1;
int k = 1, j = 0;

// Serial
Serial myPort; // Create object from Serial class

void setup() {
  // set size of the window
  size (900, 450);

  // set up serial connection
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);

  // initialise graph points object
  GPointsArray points1 = new GPointsArray(points);

  // calculate initial display points
  for (int i = 0; i < points; i++) {
    points1.add(i, -1);
  }

  // Create the plot
  plot = new GPlot(this);
  plot.setPos(0, 0); // set the position of to left corner of plot
  plot.setDim(750, 300); // set plot size

  // Set the plot limits (this will fix them)
  plot.setXLim(0, totalPoints); // set x limits
  plot.setYLim(0, 100); // set y limits

  // Set the plot title and the axis labels
  plot.setTitleText("Distance Sensor Example"); // set plot title
  plot.getXAxis().setAxisLabelText("x axis"); // set x axis label
  plot.getYAxis().setAxisLabelText("Distance"); // set y axis label

  // Add the two set of points to the plot
  plot.setPoints(points1);
}

void draw() {
  // set window background


  // check if i has exceeded the plot size
  if (i > totalPoints) {
    i=0; // reset to zero if it has
  }

  // get new value from serial port
  if ( millis() > previousMillis + duration) { // If data is available,

    //myPort.write(0);
    //println(“Sensor request sent”);
    while (myPort.available() < 0) {
    };
    int val = myPort.read(); // read it and store it in val
    if (val == -1)
      val = k;

    k = val;
    //int val = j;
    println(val);
    // Add the point at the end of the array

    plot.addPoint(i, val);

    // Remove the first point
    plot.removePoint(0);

    previousMillis = millis();
    i++;
    j += k;

    background(150);

    // draw the plot
    plot.beginDraw();
    plot.drawBackground();
    plot.drawBox();
    plot.drawXAxis();
    plot.drawYAxis();
    plot.drawTopAxis();
    plot.drawRightAxis();
    plot.drawTitle();
    plot.getMainLayer().drawPoints();
    plot.endDraw();
  }
}
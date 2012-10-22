/*
 * Copyright (c) 2012 Zepp Lab UG (haftungsbeschränkt) <www.zepplab.net>, Johannes Hoppe <info@johanneshoppe.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
 
import processing.opengl.*;
import java.awt.GraphicsDevice;
import java.awt.DisplayMode;

public class Stage extends PApplet {


  MusicBeam ctrl = null;


  int width;

  int height;

  public int refreshRate;

  int posx;

  float t = 0.0f;

  float maxRadius;

  float minRadius;


  Stage (MusicBeam main, GraphicsDevice gd, boolean fullscreen)
  {
    ctrl = main;
    DisplayMode dm = gd.getDisplayMode();
    width = dm.getWidth();
    height = dm.getHeight();
    refreshRate = dm.getRefreshRate() == 0 ? 60 : dm.getRefreshRate();
    posx = 0;
    frame = new Frame( );
    frame.setBounds( posx, 0, width, height );
    frame.removeNotify(); 
    frame.setUndecorated(true); 
    frame.addNotify();
    frame.add( this );
    this.init( );
    if (gd.isFullScreenSupported() && fullscreen)
      gd.setFullScreenWindow(frame);
    frame.show( );
  }

  void setup() {
    size(width, height, OPENGL);
    frameRate(refreshRate);
    background(0);
    noStroke();

    colorMode(HSB, 360, 100, 100);
    maxRadius = sqrt(sq(width)+sq(height));
    minRadius = height < width ? height : width;
  }

  void draw() {
    ctrl.beatDetect();
    smooth();
    background(0);
    translate(width/2, height/2);
    for (int i = 0; i < effectArray.length; i++)
      if (effectArray[i].isActive())
        effectArray[i].refresh();
  }
}

float np = 300;
float startcol;
float sx, sy;
int count = 0;
import processing.svg.*;

boolean record;

void setup() {
  size(1024, 768);
  background(255);
  noFill();
  noiseSeed(1000000);
  startcol = random(255);
}

void draw() {
  if (record) {
    // Note that #### will be replaced with the frame number. Fancy!
    beginRecord(SVG, "frame-####.svg");
  }

    DrawIt(20);
    //DrawIt(100);
 
  if (count > width/2 ) {

    background(255);
    count = 0;
  }

  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  record = true;
}


void DrawIt(float val_) {

  beginShape();

  for (int i = 0; i < np; i++) {
    float angle = map(i, 0, np, 0, TWO_PI);
    float cx = count * 4 - val_;
    float cy = height / 3 + 50 * sin(count / 1500);
    float xx = map(mouseX, 0, width, 10, 300) * cos(angle + cx / 10);
    float yy = map(mouseY, 0, height, 10, 300) * sin(angle + cx / 10);
    PVector v = new PVector(xx, yy);
    xx = (xx + cx) / 150; 
    yy = (yy + cy) / 150;
    v.mult(1 + 1.5 * noise(xx, yy));
    vertex(cx + v.x, cy + v.y);
    if (i == 0) {
      sx = cx + v.x;
      sy = cy + v.y;
    }
  }
  colorMode(HSB);
  pushMatrix();
  translate(-400, 0);
  stroke(255-val_/2, val_*2, 120);
  strokeWeight(1);
  vertex(sx, sy);
  popMatrix();
  endShape();
  count ++;
}

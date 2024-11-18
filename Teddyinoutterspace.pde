// Camera variables
float cameraZ = 0;
float targetZ = 0;
float rotationX = 0;
float rotationY = 0;
float easing = 0.05;

// Teddy variables
PImage teddy;
float teddyX, teddyY, teddyZ;

// Star arrays
int[] starX = new int[200];
int[] starY = new int[200];
int[] starZ = new int[200];
color[] starColor = new color[200];
int starSize = 2;
int twinkleTimer = 0;

void setup() {
  size(800, 800, P3D);

  teddy = loadImage("teddyinspaceteenynobackground.png");
  if (teddy == null) {
    println("ERROR: Failed to load image!");
    println("Make sure the image file is in the data folder and the name matches exactly");
    exit();
  } else {
    println("Image loaded successfully!");
    println("Image size: " + teddy.width + " x " + teddy.height);
  }
  
  // Initialize positions
  teddyX = width/2;
  teddyY = height/2;
  teddyZ = 0;
  
  // Initialize background stars
  for (int i = 0; i < starX.length; i++) {
    starX[i] = (int)random(-width, width*2);
    starY[i] = (int)random(-height, height*2);
    starColor[i] = color(255, random(200, 255));
  }
}

void draw() {
  background(0, 0, 50);
  
  // Update camera

  
  // Set up 3D scene
  translate(width/2, height/2, cameraZ);
  rotateX(rotationX);
  rotateY(rotationY);
  
  // Move Teddy
  float targetX = mouseX - width/2;
  float targetY = mouseY - height/2;
  teddyX += (targetX - teddyX) * easing;
  teddyY += (targetY - teddyY) * easing;
  
  // Draw background stars
  twinkleTimer++;
  if (twinkleTimer > 10) {
    for (int i = 0; i < 3; i++) {
      int starIndex = (int)random(starX.length);
      starColor[starIndex] = color(255, random(200, 255));
    }
    twinkleTimer = 0;
  }
  
  // Draw background stars
  for (int i = 0; i < starX.length; i++) {
    pushMatrix();
    translate(starX[i] - width/2, starY[i] - height/2, starZ[i]);
    rotateX(frameCount * 0.01);
    rotateY(frameCount * 0.01);
    fill(starColor[i]);
    drawStar(starSize, 255);
    popMatrix();
  }

  // Draw Teddy
  if (teddy != null) {
    pushMatrix();
    translate(teddyX, teddyY, teddyZ);
    rotateX(-rotationX);
    rotateY(-rotationY);
    imageMode(CENTER);
    image(teddy, 0, 0);
    popMatrix();
  }
}

void drawStar(float size, float brightness) {
  stroke(255, 255, 255, brightness);
  strokeWeight(1);
  float innerSize = size * 0.4;
  
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i <= 10; i++) {
    float angle = i * TWO_PI / 5;
    float r = (i % 2 == 0) ? size : innerSize;
    float x = cos(angle) * r;
    float y = sin(angle) * r;
    vertex(x, y, 0);
  }
  endShape(CLOSE);
}

void mouseDragged() {
  rotationY += (mouseX - pmouseX) * 0.01;
  rotationX += (mouseY - pmouseY) * 0.01;
}

void mouseWheel(MouseEvent event) {
  targetZ += event.getCount() * 50;
}


//To use this 3D version:

//Drag mouse to rotate the view

//Use mouse wheel to zoom in/out

//Move mouse to guide Teddy

//Teddy will leave a 3D trail of stars

//You can adjust:

//starZ range for depth of star field

//trailWidth for wider/narrower trail

//starSize for larger/smaller stars

//easing for smoother/faster movement

//Note: The Teddy image will still be 2D, but it will exist in 3D space. For a fully 3D effect, you would need a 3D model of Teddy instead of an image.
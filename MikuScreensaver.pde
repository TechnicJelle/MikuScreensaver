final static String exportPath = "frames_" + System.currentTimeMillis() + "/frame_#####.tif";
final static boolean doExport = false;

final static int fadeAmount = 5;
final static int FPS = 120;
final static float DELTA = 1f/FPS;

Shape[] shapes;

PGraphics canvas;

void setup() {
  size(300*4, 200*4);
  frameRate(FPS);
  smooth(8);

  colorMode(HSB, 360, 100, 100);

  canvas = createGraphics(width, height);

  shapes = new Shape[2];
  for (int i = 0; i < shapes.length; i++) {
    float angle = float(i) / float(shapes.length) * 360f;
    //Shape(int count, float speed, float speedDelta, float startHue, float hueSpeed, float weight)
    shapes[i] = new Shape(4, 400f, 100f, angle, 0.1f, 5f);
  }
}

void draw() {
  background(0);

  for (Shape s : shapes) {
    s.update(DELTA);
  }

  fadeGraphics(canvas, fadeAmount);
  canvas.beginDraw();
  for (Shape s : shapes) {
    s.render();
  }
  canvas.endDraw();

  image(canvas, 0, 0);

  println();

  if (doExport) saveFrame(exportPath);
}

// https://forum.processing.org/two/discussion/13189/a-better-way-to-fade.html
void fadeGraphics(PGraphics c, int fadeAmount) {
  c.beginDraw();
  c.loadPixels();

  // iterate over pixels
  for (int i = 0; i < c.pixels.length; i++) {

    // get alpha value
    int alpha = (c.pixels[i] >> 24) & 0xFF;

    // reduce alpha value
    alpha = max(0, alpha-fadeAmount);

    // assign color with new alpha-value
    c.pixels[i] = alpha<<24 | (c.pixels[i]) & 0xFFFFFF;
  }

  canvas.updatePixels();
  canvas.endDraw();
}

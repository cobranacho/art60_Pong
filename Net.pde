class Net {
  int n;
  int h;
  int w;
  // Net constructor that takes an int parameter to determine the net spacing
  Net (int n_) {
    n = n_;
    h = (height) / (2 * n);
    w = 4;
  }

  void display() {
    fill(255);
    noStroke();
    for (int i = 0; i < n * 2; i = i + 2) {
      rect(width / 2 - w / 2, h * i + h / 2, w, h);
    }
  }
}
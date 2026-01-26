class Point {
  double x = 0; // Point has property x coordinate
  double y = 0; // And point has property y coordinate

  // constructor
  Point(this.x, this.y);

  // returning value of x coordinate
  double getx() {
    return this.x;
  }

  // returning value of y coordinate
  double gety() {
    return this.y;
  }
}

void main() {
  // Creating object of class point
  var p1 = Point(6, 8);
  // Printing the coordinates
  print('p1(X, Y): (${p1.getx()}, ${p1.gety()})');

  // Creating object of class point
  var p2 = Point(3, 4);
  // Printing the coordinates
  print('p2(X, Y): (${p2.getx()}, ${p2.gety()})');
}

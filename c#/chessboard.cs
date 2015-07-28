using System.IO;
using System;
class Program {
  static void Main() {
    for (int i = 0 ; i < 8 ; i++) {
      string aLine = "";
      string xo;
      xo = i % 2 == 0 ? "X" : "O";
      for (int j = 0; j < 8; j++) {
        aLine += xo;
        xo = xo == "X" ? "O" : "X";
      }
      Console.WriteLine (aLine);
    }
  }
}

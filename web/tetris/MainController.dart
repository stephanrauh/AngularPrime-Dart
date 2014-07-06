/**
 * (C) 2014 Rudy De Busscher  http://www.beyondjava.net
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

part of angularTetris;

@Controller(selector: '[MainController]', publishAs: 'ctrl')
class MainController {
  List<int> bricks = new List();
  int rows;
  int columns;
  
  Tetrimino tetrimino = null;
  
  List<List<int>> playground;
  
  
  
  Keyboard keyboard;
  Stopwatch watch;

  MainController() {
    keyboard = new Keyboard();
  }
  
  /**
   * Enables keyboard navigation.
   */
  keyListener(KeyboardEvent e) {
    if (e.keyCode==KeyCode.ENTER)
    {
      print("Enter");
      return;
    }
    else if (e.keyCode==KeyCode.UP) {
      print("up");
    }
  }

  init() {
    bricks = new List<int>(rows*columns);
    playground = new List<List<int>>(columns);
    for (int c = 0; c < columns; c++)
    {
      List<int> column = new List<int>(rows);
      playground[c]=column;
      for (int r = 0; r < column.length; r++) {
        column[r]=0;
      }
    }
  }
  
  drawBricks() {
    int index=0;
    for (int r = 0; r < rows; r++)
      for (int c = 0; c < columns; c++)
        bricks[index++]= playground[c][r];

  }

  void showMsg(String msg) {
    window.alert("This alert is shown by Dart. Received parameter = "+msg);
  }

  void dropEveryBrick()
  {
    for (int r = (rows-1); r > 0; r--)
      for (int c = 0; c < columns; c++)
        bricks[r*columns+c] = bricks[(r-1)*columns+c];
    for (int c = 0; c < columns; c++) {
      bricks[c]=0;
    }
  }
  
  void startGame() {
    watch = new Stopwatch();
    watch.start();
    update(null);
  }
  
  void update(e) {
    if (null == tetrimino) {
      addRandomTetrimino();
    }
    drawBricks();
    if (watch.elapsedMilliseconds>50)
    {
      watch.reset();
      if (keyboard.isPressed(KeyCode.SPACE)) {
        dropEveryBrick();
      }
    }
    if (keyboard.isPressed(KeyCode.A))
        print('A is pressed!');
    keyboard.reset();
    window.requestAnimationFrame(update);
  }
  
  void addRandomTetrimino() {
    tetrimino=new Tetrimino(columns);
    tetrimino.drawTile(playground);
  }
}

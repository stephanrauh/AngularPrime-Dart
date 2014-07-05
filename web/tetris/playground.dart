/**
 * (C) 2014 Stephan Rauh http://www.beyondjava.net
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

/**
 * <pui-grid> makes it a little easier to create simple but decently looking input dialogs.
 * Typically it contains a number of input fields that are automatically aligned to each other.
 * More precisely, <pui-grid> creates a column consisting of three columns. The first column is the label (which is automatically extracted from the component),
 * the second is the components itself and the third column is the field-specific error message. Alternative, the error message is placed below its field.
 * Likewise, the label can be put above the input field.
 *
 * @ToDo <pui-grid> is limited to a single column of components
 * @ToDo put labels optionally above the component
 * @ToDo put error message optionally behind the component
 */
@Component(
    selector: 'tetris-playground',
    templateUrl: 'packages/angularprime_dart/puiGrid/pui-grid.html',
    useShadowDom:     false,
    publishAs: 'cmp'
)
class TetrisPlaygroundComponent extends PuiGridComponent {
  int numberOfColumns=10;
  int numberOfRows=25;

  Scope scope;

  /** The <tetris-playground> field as defined in the HTML source code. */
  Element playgroundComponent;

  MainController mainController;

  String color(int r, int c){int col= mainController.bricks[r*numberOfColumns+c];
                          if (0==col) return "#FFFFFF";
                          if (1==col) return "#FF0000";
                          if (2==col) return "#00FF00";
                          if (3==col) return "#0000FF";
                          if (4==col) return "#FFFF00";
                          return "#00FFFFFF";
                          }

//  int text(int r, int c){return mainController.bricks[r*numberOfColumns+c];}
  String text(int r, int c){return "";}

  /**
   * Initializes the component by setting the <pui-input> field and setting the scope.
   */
  TetrisPlaygroundComponent(MainController this.mainController, this.scope, Element playgroundComponent, Compiler compiler, Injector injector, DirectiveMap directives, Parser parser)
      :  super(playgroundComponent, compiler, injector, directives, parser)
  {
    this.playgroundComponent=playgroundComponent;

    if (playgroundComponent.attributes.containsKey("columns")) numberOfColumns=int.parse(playgroundComponent.attributes["columns"]);
    if (playgroundComponent.attributes.containsKey("rows")) numberOfRows=int.parse(playgroundComponent.attributes["rows"]);
    mainController.rows = numberOfRows;
    mainController.columns = numberOfColumns;
    mainController.init();


    for (int r = 0; r < numberOfRows; r++) {
      for (int c = 0; c < numberOfColumns; c++) {
          List<Node> list = PuiHtmlUtils.parseResponse("<span><button style=\"width:30px;height:30px;background-color:{{cmp.color($r, $c)}}}\">{{cmp.text($r, $c)}}</button></span>").childNodes;

          ViewFactory template = compiler(list, directives);
          Injector childInjector =
                injector.createChild([new Module()..bind(Scope, toValue: scope)]);
          template(childInjector, list);

          while (list.length>0) {
              Node n = list[0];
              playgroundComponent.children.add(n);
          }

        }
    }
    init();
  }
}


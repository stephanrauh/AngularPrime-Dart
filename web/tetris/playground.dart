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
    templateUrl: 'tetris-playground.html',
    useShadowDom:     false,
    publishAs: 'cmp'
)
class TetrisPlaygroundComponent {
  int numberOfColumns=10;
  int numberOfRows=25;

  /** The <tetris-playground> field as defined in the HTML source code. */
  Element playgroundComponent;

  /**
   * Initializes the component by setting the <pui-input> field and setting the scope.
   */
  TetrisPlaygroundComponent(this.playgroundComponent, Compiler compiler, Injector injector, DirectiveMap directives, Parser parser) {
    if (playgroundComponent.attributes.containsKey("columns")) numberOfColumns=playgroundComponent.attributes["columns"];
    if (playgroundComponent.attributes.containsKey("rows")) numberOfColumns=playgroundComponent.attributes["rows"];
  }
}


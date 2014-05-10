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
part of puiInput;

/**
 * <pui-time> is an HTML5 time picker.
 */
@Component(
    selector: 'pui-time',
    templateUrl: 'packages/angularprime_dart/puiInput/pui-input.html',
    cssUrl: 'packages/angularprime_dart/puiInput/pui-input.css',
    applyAuthorStyles: true,
    publishAs: 'cmp'
)
class PuiTimeComponent extends PuiInputTextComponent {

  /**
   * Initializes the component by setting the <pui-time> field and setting the scope.
   */
  PuiTimeComponent(Scope scope, Element puiInputElement, NgModel model, Compiler compiler, Injector injector, DirectiveMap directives, Parser parser) : super(scope, puiInputElement, model, compiler, injector, directives, parser) {
    puiInputElement.attributes['type']="time";
  }
}


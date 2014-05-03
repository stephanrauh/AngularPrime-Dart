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
library puiMenu;

import 'dart:html';
import 'package:angular/angular.dart';
import '../core/pui-base-component.dart';
part 'pui-menuItem.dart';
part 'pui-menuHeader.dart';

/**
 * <pui-menu> is a menu component with AngularDart support.
 */
@Component(
    selector: 'pui-menu',
    templateUrl: 'packages/angularprime_dart/puiMenu/pui-menu.html',
    cssUrl: 'packages/angularprime_dart/puiMenu/pui-menu.css',
    applyAuthorStyles: true,
    publishAs: 'cmp'
)
class PuiMenuComponent extends PuiBaseComponent implements ShadowRootAware  {

  /** The <pui-menu> field as defined in the HTML source code. */
  Element puiMenuElement;

  /** The scope is needed to add watches. */
  Scope scope;

  /** Reference to the Angular model corresponding to the input field */
  NgModel _model;

  /** optional: if set to "true", the button is disabled and doesn't react to being clicked. */
  @NgAttr("disabled")
  String disabled;

  /** The menu element that's really displayed (the shadow DOM) */
  Element shadowyMenu;

  /**
   * Initializes the component by setting the <pui-input> field and setting the scope.
   */
  PuiMenuComponent(this.scope, this.puiMenuElement, this._model, Compiler compiler, Injector injector, DirectiveMap directives, Parser parser): super(compiler, injector, directives, parser) {
    int order=0;
    puiMenuElement.children.forEach((Element item ) {
      item.attributes["_puisortorder"]=order.toString();
      order++;
    });
  }

  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   *
   * @Todo Find out, which attributes are modified by Angular, and set a watch updating only the attributes that have changed.
   */
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowyMenu =shadowRoot.getElementById("puiMenuContainer");
  }

  /** depending on the disabled flag, the input field is switched either to read-only or editable mode */
  void _updateDisabledState()
  {
    /*
    if (disabled=="true")
    {
      shadowyInputField.classes.add("ui-state-disabled");
      shadowyInputField.attributes["disabled"]="true";
    }
    else
    {
      shadowyInputField.classes.remove("ui-state-disabled");
      shadowyInputField.attributes.remove("disabled");
    }
    */
  }

}


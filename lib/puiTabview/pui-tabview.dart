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
library puiTabview;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angularprime_dart/core/pui-base-component.dart';

/**
 * <pui-tabview> groups fields into tabs.
 */
@NgComponent(
    selector: 'pui-tabview',
    templateUrl: 'packages/angularprime_dart/puiTabview/pui-tabview.html',
    cssUrl: 'packages/angularprime_dart/puiTabview/pui-tabview.css',
    applyAuthorStyles: true,
    publishAs: 'cmp'
)
class PuiTabviewComponent extends PuiBaseComponent implements NgShadowRootAware  {
  /** The <pui-input> field as defined in the HTML source code. */
  Element puiTabviewElement;

  /** The scope is needed to add watches. */
  Scope scope;

  /**
   * Initializes the component by setting the <pui-tabview> field and setting the scope.
   */
  PuiTabviewComponent(this.scope, this.puiTabviewElement) {}

  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   */
  void onShadowRoot(ShadowRoot shadowRoot) {
    copyAttributesToShadowDOM(puiTabviewElement, null, scope);
    addWatches(puiTabviewElement, null, scope);
  }
}


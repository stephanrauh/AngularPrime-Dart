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
import '../core/pui-module.dart';

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

  /** The inner HTML code */
  List<Element> innerDOM;

  /**
   * Initializes the component by setting the <pui-input> field and setting the scope.
   */
  PuiMenuComponent(this.scope, this.puiMenuElement, this._model, Compiler compiler, Injector injector, DirectiveMap directives, Parser parser): super(compiler, injector, directives, parser) {
    String html = _createHTML(puiMenuElement);
    puiMenuElement.nodes.clear();
    _compileHTMLCodeToAngular(html, compiler, directives, injector);
  }

  String _createHTML(Element parent) {
    String html="";
    parent.children.forEach((Element item ) {
      if (item.nodeName=="PUI-SUBMENU") {
        html += _createSubmenu(item);
      }
      else if (item.nodeName=="PUI-MENUITEM")
      {
        html += _createMenuItem(item);
      }

    });
    return html;
  }

  String _createMenuItem(Element item, [String subMenuHTML=""]) {
    String value=item.attributes["value"];
    String icon=item.attributes["icon"];
    String iconSpan=icon==null?"":"""<span class="pui-menuitem-icon ui-icon $icon" ng-if="$icon != null"></span>""";

    String ngClick=item.attributes["ng-click"];
    if (null==ngClick) ngClick=item.attributes["actionListener"];
    String ngClickHTML = "";
    if (null != ngClick) ngClickHTML="""ng-click="$ngClick" """;
    String parentClass="";
    String subMenuTriangle="";
    if (item.children.length>0) {
      parentClass="pui-menu-parent";
      subMenuTriangle="""<span class="ui-icon ui-icon-triangle-1-e"></span>""";
    }

    String html =
        """<li class="pui-menuitem ui-widget ui-corner-all $parentClass" $ngClickHTML >
          <a data-icon="ui-icon-document" class="pui-menuitem-link ui-corner-all">
          $subMenuTriangle
    $iconSpan
    <span class="ui-menuitem-text" >
      $value
    </span>
          </a>
          $subMenuHTML
        </li>""";
    return html;
  }

  String _createSubmenu(Element item) {
    String value=item.attributes["value"];
    if (item.children.length==0) {
      return """<li class="ui-widget-header ui-corner-all"><h3>$value</h3></li>""";
    }
    else {
      String innerHTML=_createHTML(item);
      innerHTML="""<ul class="ui-widget-content pui-menu-list ui-corner-all ui-helper-clearfix pui-menu-child pui-shadow" style="left: 193px; top: 0px; z-index: 1006; display: block;">
          $innerHTML</ul>""";
      String html=_createMenuItem(item, innerHTML);
      return html;
    }
  }

  void _compileHTMLCodeToAngular(String html, Compiler compiler, DirectiveMap directives, Injector injector) {
    Element parseResponse = PuiHtmlUtils.parseResponse("<span>"+html+"</span>");
    innerDOM=parseResponse.children;
    ViewFactory template = compiler(innerDOM, directives);
    Injector childInjector =
        injector.createChild([new Module()..bind(Scope, toValue: scope.parentScope)]);
    template(childInjector, innerDOM);
  }

  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   *
   * @Todo Find out, which attributes are modified by Angular, and set a watch updating only the attributes that have changed.
   */
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowyMenu =shadowRoot.getElementById("puiMenuContainer");
    shadowyMenu.children.addAll(innerDOM);
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


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
part of puiMenu;

/**
 * <pui-menu> is a menu component with AngularDart support.
 */
@Component(
    selector: 'pui-menuHeader',
    templateUrl: 'packages/angularprime_dart/puiMenu/pui-menuHeader.html',
    publishAs: 'cmp'
)
class PuiMenuHeaderComponent extends PuiBaseComponent implements ShadowRootAware  {

  /** The <pui-menuHeader> field as defined in the HTML source code. */
  Element puiMenuHeaderElement;

  /** The scope is needed to add watches. */
  Scope scope;

  /** Reference to the Angular model corresponding to the input field */
  NgModel _model;

  /** optional: if set to "true", the button is disabled and doesn't react to being clicked. */
  @NgAttr("disabled")
  String disabled;

  /** The caption of the menu header.*/
  @NgAttr("value")
  String value;

  /** The surrounding menu */
  PuiMenuComponent _parent;

  @NgOneWay("_puisortorder")
  int puiSortOrder;


  /**
   * Initializes the component by setting the <pui-input> field and setting the scope.
   */
  PuiMenuHeaderComponent(this.scope, this._parent, this.puiMenuHeaderElement, this._model, Compiler compiler, Injector injector, DirectiveMap directives, Parser parser): super(compiler, injector, directives, parser) {
  }

  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   *
   * @Todo Find out, which attributes are modified by Angular, and set a watch updating only the attributes that have changed.
   */
  void onShadowRoot(ShadowRoot shadowRoot) {
    // Dirty hack to circumvent the additional work needed to style the shadow dom correctly
    // (ShadowDom is going to be dropped soon, so it's not worth the pain to make the component work with the shadow DOM)
//    _parent.shadowyMenu.children.addAll(shadowRoot.children);
//    print("Header $value");
    // Dirty hack to circumvent the additional work needed to style the shadow dom correctly
    // (ShadowDom is going to be dropped soon, so it's not worth the pain to make the component work with the shadow DOM)
    // To make things worse, onShadowRoot is called in any order, so we have to find out where to insert the code
    int order=int.parse(puiMenuHeaderElement.attributes["_puiSortOrder"]);
    bool done=false;
    for (int i = 0; i < _parent.shadowyMenu.nodes.length; i++)
    {
      if (_parent.shadowyMenu.nodes[i] is Element)
      {
        Element e = _parent.shadowyMenu.nodes[i];
        String o = e.attributes["_puiSortOrder"];
        if (null!=o && o!="") {
          try
          {
          int order=int.parse(o);
          if (order>puiSortOrder) {
            _parent.shadowyMenu.nodes.insertAll(i, shadowRoot.children);
            done=true;
            break;
          }
          }
          catch (error) {
            print(e.outerHtml);
          }
        }
      }
    }
    if (!done) {
      _parent.shadowyMenu.nodes.addAll(shadowRoot.children);
    }
    // end of dirty hack

    // end of dirty hack
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


library puiButton;

import 'dart:html';
import 'package:angular/angular.dart';
import 'dart:async';

@NgComponent(
    selector: 'pui-button', 
    templateUrl: 'packages/angularprime_dart/puiButton/pui-button.html', 
    cssUrl: 'packages/angularprime_dart/puiButton/pui-button.css', 
    publishAs: 'cmp')
class PuiButtonComponent extends NgShadowRootAware {

  @NgAttr("onClick")
  String onClick;
  @NgAttr("value")
  String value;
  @NgAttr("icon")
  String icon;
  @NgAttr("iconPos")
  String iconPos;
  
  @NgAttr("disabled")
  String disabled;

  /** The scope is needed to add watches. */
  Scope scope;

  /** The <puiButton> as defined in the user's source code */
  Element puiButton;

  /** The button component within the shadow tree */
  ButtonElement button;

  PuiButtonComponent(this.scope, this.puiButton) {}
  
  /** We add the optional icon to the button during the initialization of the shadow DOM tree. */
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowRoot.applyAuthorStyles = true;
    button = shadowRoot.querySelector('button');
    
    if (disabled!=null)
    {
      button.classes.add("ui-state-disabled");
      // Todo: cancel onClick listeners
      // Future<Set<MouseEvent>> set = button.onClick.toSet();
    }
    else
    {
      button.onMouseEnter.listen((event) => button.classes.add('ui-state-hover'));
      button.onMouseLeave.listen((event) => button.classes.remove('ui-state-hover'));
    }

    if (icon == null) {
      button.classes.add('pui-button-text-only');
    } else {
      drawIcon();
    }
    
  }

  /** adds the icon as a span element */
  void drawIcon() {
    
    if ("right" == iconPos) {
      button.classes.add('pui-button-text-icon-right');
    } else {
      button.classes.add('pui-button-text-icon-left');
    }
    SpanElement iconSpan = new SpanElement();
    iconSpan.classes.add(iconSpanClass());
    button.children.insert(0, iconSpan);
        
  }

  /** return the CSS class defining the icon position */
  String iconPosClass() {
    if (null==icon) return "pui-button-text-only";
    String c = "pui-button-icon-left";
    if ("right" == iconPos) {
      c = "pui-button-icon-right";
    }
    return c;
  }
  
  /** returns the CSS classes defining the icon */
  String iconSpanClass()
  {
    String c = "pui-button-icon-left";
    if ("right" == iconPos) {
      c = "pui-button-icon-right";
    }
    
    c+= " ui-icon ";
    if (icon.startsWith("ui-icon-"))
      c+=icon;
    else
      c += "ui-icon-$icon";
    print(c);
    return c;
  }
}

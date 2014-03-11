/**
 * This is only an early sketch!
 */


library puiPanel;

import 'package:angular/angular.dart';
import 'dart:html';

@NgComponent(
    selector: 'pui-panel',
    templateUrl: 'packages/angularprime_dart/puiPanel/pui-panel.html',
    cssUrl: 'packages/angularprime_dart/puiPanel/pui-panel.css',  
    publishAs: 'cmp'
)
class PuiPanelComponent extends NgShadowRootAware {
  @NgAttr("header")
  String header;
  
  @NgAttr("toggleable")
  String toggleable;
  
  @NgAttr("collapsed")
  String collapsed = 'false';

  @NgAttr("toggleOrientation")
  String toggleOrientation = 'vertical';
  
  HtmlElement titlebar;
  HtmlElement content;
  bool collapsedState;
  HtmlElement toggler;
  
  
  void convertAttributes() {
    collapsedState = false;
    if (null!= collapsed && "true" == collapsed.trim().toLowerCase()) {
      collapsedState = true;
    }
  }
  
  String determineCollapsedIcon() {
    return collapsedState ? 'ui-icon-plusthick' : 'ui-icon-minusthick';
  }
  
  void toggle(MouseEvent event) {
    event.preventDefault();
    if(collapsedState) {
      _expand();
    }
    else {
      _collapse();
    }
    
  }
  
  void _expand() {
    SpanElement toggleSpan = toggler.querySelector('span.ui-icon');
    toggleSpan.classes.add('ui-icon-minusthick');
    toggleSpan.classes.remove('ui-icon-plusthick');
    
    if(null == toggleOrientation || toggleOrientation == 'vertical') {
      _slideDown();
    } 
    else if(toggleOrientation == 'horizontal') {
      _slideRight();
    }
    collapsedState = false;
  }
  

  void _collapse() {
    SpanElement toggleSpan = toggler.querySelector('span.ui-icon');
    toggleSpan.classes.add('ui-icon-plusthick');
    toggleSpan.classes.remove('ui-icon-minusthick');
    

    if(null == toggleOrientation || toggleOrientation == 'vertical') {
      _slideUp();
    } 
    else if(toggleOrientation == 'horizontal') {
     _slideLeft();
    }
    collapsedState = true;
  }
  
  void _slideUp() {
    content.hidden = true; 
   }

  void _slideDown() {  
    content.hidden = false; 
  }

  void _slideLeft() {
    content.hidden = true; 
    titlebar.parent.style.width="60px";
    titlebar.style.width="20px";
    HtmlElement text=titlebar.firstChild;
    text.hidden=true;

  }

  void _slideRight() {
    content.hidden = false; 
    titlebar.parent.style.width="";
    titlebar.style.width="";
    HtmlElement text=titlebar.firstChild;
    text.hidden=false;
  }
  
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowRoot.applyAuthorStyles = true;

    titlebar = shadowRoot.querySelector('.pui-panel-titlebar');
    
    content = shadowRoot.querySelector('.pui-panel-content');
    convertAttributes();
    
    if (toggleable == "true") {
      
      toggler = new AnchorElement(href : '#');
      toggler.classes.add('pui-panel-titlebar-icon');
      toggler.classes.add('ui-corner-all');
      toggler.classes.add('ui-state-default');

      SpanElement toggleSpan = new SpanElement();
      toggleSpan.classes.add('ui-icon');
      toggleSpan.classes.add(determineCollapsedIcon());

      toggler.children.add(toggleSpan);

      DivElement titleBar = shadowRoot.querySelector('.pui-panel-titlebar');
      titleBar.children.add(toggler);
      
      toggler.onMouseEnter.listen(
          (event) => toggler.classes.add('ui-state-hover'));
      toggler.onMouseLeave.listen(
          (event) => toggler.classes.remove('ui-state-hover'));
      toggler.onClick.listen(
          (event) => toggle(event));
      
    }
  }
}
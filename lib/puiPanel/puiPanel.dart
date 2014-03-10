/**
 * This is only an early sketch!
 */


library puiPanel;

import 'package:angular/angular.dart';
import 'dart:html';

@NgComponent(
    selector: 'pui-panel',
    templateUrl: 'puiPanel/pui-panel.html',
    cssUrl: 'puiPanel/pui-panel.css',  
    publishAs: 'ctrl',
    map: const {
      'header' : '@header',
      'toggleable': '@toggleable'
    }
)
class puiPanelComponent extends NgShadowRootAware {
  String header;
  String toggleable;
  String collapsed = 'false';
  
  HtmlElement content;
  bool collapsedState;
  String toggleOrientation = 'vertical';
  HtmlElement toggler;
  
  
  void convertAttributes() {
    collapsedState = false;
    
    if ("true" == collapsed.trim().toLowerCase()) {
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
    
    if(toggleOrientation == 'vertical') {
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
    

    if(toggleOrientation == 'vertical') {
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
  }

  void _slideRight() {
  }
  
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowRoot.applyAuthorStyles = true;
    
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
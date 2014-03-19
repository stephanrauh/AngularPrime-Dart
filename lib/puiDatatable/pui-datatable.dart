library puiDatatable;

import 'package:angularprime_dart/core/pui-base-component.dart';
import 'package:angular/angular.dart';
import 'dart:html';

/**
 * A <pui-datatable> consists of a number of <pui-tabs>, each containing content that's hidden of shown
 * depending on whether the tab is active or not. Only one tab can be active at a time.
 *
 * The programming model is much like the API of the PrimeFaces <tabView> component.
 *
 * Usage:
 * <pui-datatable>
 *   <pui-tab title="first tab">
 *      content of first tab
 *   </pui-tab>
 *   <pui-tab title="default tab" selected="true">
 *      content of second tab
 *   </pui-tab>
 *   <pui-tab title="closable tab" closeable="true">
 *      content of closeable tab
 *   </pui-tab>
 * </pui-datatable>
 *
 * Kudos: This component's development was helped a lot by a stackoverflow answer:
 * http://stackoverflow.com/questions/20531349/struggling-to-implement-tabs-in-angulardart.
 */
@NgComponent(
  visibility: NgDirective.CHILDREN_VISIBILITY,
  selector: 'pui-datatable',
  templateUrl: 'packages/angularprime_dart/puiDatatable/pui-datatable.html',
  cssUrl: 'packages/angularprime_dart/puiDatatable/pui-datatable.css',
  applyAuthorStyles: true,
  publishAs: 'cmp'
)
class PuiDatatableComponent extends PuiBaseComponent implements NgShadowRootAware {

  /** Which tabs does this <pui-datatable> consist of? */
  List<PuiColumnComponent> panes = new List();

  /** The <pui-input> field as defined in the HTML source code. */
  Element puiDatatableElement;

  /** The scope is needed to add watches. */
  Scope scope;

  /**
   * Initializes the component by setting the <pui-datatable> field and setting the scope.
   */
  PuiDatatableComponent(this.scope, this.puiDatatableElement) {}

  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   */
  void onShadowRoot(ShadowRoot shadowRoot) {
    copyAttributesToShadowDOM(puiDatatableElement, null, scope);
    addWatches(puiDatatableElement, null, scope);
  }

  /** This is the mouse click listener activating a certain tab. */
  select(MouseEvent evt, PuiColumnComponent selectedPane ) {
    for (PuiColumnComponent pane in panes) {
      pane.setSelected(pane == selectedPane);
    }
    evt.preventDefault();
  }

  /** This is the mouse click listener closing a certain tab. */
  close(MouseEvent evt, PuiColumnComponent toBeClosed) {
    bool hasBeenSelected = toBeClosed.isSelected;
    int index = panes.indexOf(toBeClosed);
    if (hasBeenSelected)
    {
      toBeClosed.setSelected(false); // hide the contents
      if (panes.length>0)
      {
        if (index==0)
          panes[0].setSelected(true);
        else
          panes[index-1].setSelected(true);
      }
    }
    panes.removeAt(index);
    evt.preventDefault();
  }


  /** This method is called automatically by the <pui-columns> when they register themselves to the <pui-datatable>. */
  add(PuiColumnComponent pane) {
    panes.add(pane);
  }
}

/** <pui-column> is a single column. The <pui-datatable> consists of several <pui-columns>. */
@NgComponent(
    selector: 'pui-column',
    templateUrl: 'packages/angularprime_dart/puiDatatable/pui-column.html',
    cssUrl: 'packages/angularprime_dart/puiDatatable/pui-datatable.css',
    applyAuthorStyles: true,
    publishAs: 'cmp'
)
class PuiColumnComponent {

  /** The caption of the tab. */
  @NgAttr("title")
  String name;

  /** Can the column be removed? */
  bool _closeable;

  /** Can the column be closed? */
  @NgAttr("closeable")
  set closeable(String s){_closeable="true"==s; }

  /** The parent <pui-datatable>. Needed to register the column. */
  PuiDatatableComponent _tab;

  /** Is the current tab active? */
  bool _selected = false;

  /** The constructor of the column initializes the reference to the parent <pui-datatable>, the scope
   * and the HTML code of the <pui-column> itself.
   */
  PuiColumnComponent(this._tab) {
    _tab.add(this);
  }

  /** Is the current column active? This method is exposed to the declaration in the HTML code. */
  @NgAttr("selected")
  set isSelectedByDefault(String selected) {
    _selected = selected == "true";
  }

  /** Is the current column active? */
  bool get isSelected => _selected;

  /** Is the current column active? */
  void setSelected(bool b){_selected=b;}

  /** returns the CSS class PrimeUI uses to display an activated or deactivated column. */
  String selectedClass() {
    return _selected ? "pui-datatable-selected ui-state-active" : "";
  }

  /** returns the CSS class to hide a column's content. */
  String hiddenClass(){
     return _selected ? "" : "ui-helper-hidden";
  }

  /** returns the CSS class to hide a column's close button. */
  String closeableClass(){
     return _closeable ? "" : "ui-helper-hidden";
  }

}

library puiDatatable;

import '../core/pui-base-component.dart';
import 'package:angular/angular.dart';
import 'dart:html';
part "pui-column.dart";

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

  /** The <pui-input> field as defined in the HTML source code. */
  Element puiDatatableElement;

  /** The scope is needed to add watches. */
  Scope scope;

  /** Needed to provide alternating row colors */
  bool even=true;

  /** List of the columns registered until now */
  List<String> _columnHeaders = new List<String>();

  /**
   * Initializes the component by setting the <pui-datatable> field and setting the scope.
   */
  PuiDatatableComponent(this.scope, this.puiDatatableElement) {
  }

  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   */
  void onShadowRoot(ShadowRoot shadowRoot) {
    var rows = puiDatatableElement.children;
    Element shadowTableContent = shadowRoot.getElementById("pui-content");

    DivElement header=new DivElement();
      header.classes.add("thead ui-widget-header");
      header.style.display="table-row";
      shadowTableContent.children.insert(0, header);

      _columnHeaders.forEach((String caption){
      DivElement header = shadowTableContent.children[0];
      header.attributes["role"]="row";
      DivElement captionCell=new DivElement();
      captionCell.classes.add("th");
      captionCell.style.display="table-cell";
      captionCell.attributes["role"]="columnheader";
      captionCell.innerHtml=caption;
      header.children.add(captionCell);
    });

    bool even=false;
    int index=0;
    rows.forEach((Element r){
      DivElement shadowTableRow = new DivElement();
      shadowTableRow.attributes["data-ri"]=index.toString();
      shadowTableRow.attributes["role"]="row";
      shadowTableRow.style.display="table-row";
      shadowTableRow.classes.add("tr");
      shadowTableRow.classes.add("ui-widget-content");
      shadowTableRow.classes.add(even?"ui-datatable-even":"ui-datatable-odd");
          even=!even;
      shadowTableContent.children.add(shadowTableRow);
      r.children.forEach((Element c){addColumnToRow(shadowTableRow, c);});
      index++;
    });
  }

  addColumnToRow(DivElement row, Element c) {
    DivElement cell = new DivElement();
    cell.attributes["role"]="gridcell";
    cell.style.display="table-cell";
    cell.classes.add("td");
    cell.innerHtml=c.innerHtml;
    row.children.add(cell);
  }

  /** Adds a column and adds it to the list of headers */
  addColumn(String caption)
  {
    if (!(_columnHeaders.contains(caption)))
    {
       _columnHeaders.add(caption);
    }
  }
}



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

  /** This is the table content that's really displayed. */
  DivElement shadowTableContent;

  /** The scope is needed to add watches. */
  Scope scope;

  /** Needed to provide alternating row colors */
  bool even=true;

  /** List of the columns registered until now */
  List<Column> _columnHeaders = new List<Column>();

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
    shadowTableContent = shadowRoot.getElementById("pui-content");

    DivElement header=new DivElement();
      header.classes.add("thead ui-widget-header");
      header.style.display="table-row";
      shadowTableContent.children.insert(0, header);

      _columnHeaders.forEach((Column col){
      _addColumnToHeader(shadowTableContent, col);
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
      r.children.forEach((Element c){_addColumnToRow(shadowTableRow, c);});
      index++;
    });
  }

  void _addColumnToHeader(Element shadowTableContent, Column col) {
    DivElement header = shadowTableContent.children[0];
    header.attributes["role"]="row";
    DivElement captionCell=new DivElement();
    captionCell.classes.add("th");
    captionCell.style.display="table-cell";
    captionCell.attributes["role"]="columnheader";
    captionCell.style.whiteSpace="nowrap";
    SpanElement caption = new SpanElement();
    caption.innerHtml=col.header;
    caption.style.float="left";
    captionCell.children.add(caption);


    header.children.add(captionCell);
    if (col.closable)
    {
      SpanElement closeIcon = new SpanElement();
      closeIcon.style.float="right";
      closeIcon.classes.add("ui-icon");
      closeIcon.classes.add("ui-icon-close");
      closeIcon.onClick.listen((MouseEvent event){closeColumn(event, captionCell);});
      captionCell.children.add(closeIcon);
    }
    if (col.sortable)
    {
      SpanElement sortIcon = new SpanElement();
      sortIcon.style.float="right";
      sortIcon.classes.add("ui-icon");
      sortIcon.classes.add("ui-sortable-column-icon");
      sortIcon.classes.add("ui-icon-carat-2-n-s");
      sortIcon.onClick.listen((MouseEvent event){sortColumn(event, captionCell);});
      captionCell.children.add(sortIcon);

    }
  }

  closeColumn(MouseEvent event, DivElement close) {
    DivElement headerRow = shadowTableContent.children[0];
    int index=0;
    for (; index < headerRow.children.length; index++)
    {
      if (headerRow.children[index]==close)
      {
        _columnHeaders.removeAt(index);
        shadowTableContent.children.forEach((DivElement row){row.children.removeAt(index);});
        break;
      }
    }
  }

  sortColumn(MouseEvent event, DivElement sortColumn) {
    DivElement headerRow = shadowTableContent.children[0];
    int index=0;
    for (; index < headerRow.children.length; index++)
    {
      if (headerRow.children[index]==sortColumn)
      {
        bool sortUp;
        List<SpanElement> iconDivs = headerRow.children[index].getElementsByClassName("ui-sortable-column-icon");
        int dir = _columnHeaders[index].sortDirection;
        if (dir==0)
        {
          iconDivs[0].classes.remove("ui-icon-carat-2-n-s");
          iconDivs[0].classes.add("ui-icon-triangle-1-n");
          dir=1;
        }
        else if (dir==1)
        {
          iconDivs[0].classes.remove("ui-icon-triangle-1-n");
          iconDivs[0].classes.add("ui-icon-triangle-1-s");
          dir=2;
        }
        else
        {
          iconDivs[0].classes.remove("ui-icon-triangle-1-s");
          iconDivs[0].classes.add("ui-icon-triangle-1-n");
          dir=1;
        }
        _columnHeaders[index].sortDirection=dir;
      }
      else
      {
        // remove sort icon (if necessary)
        List<SpanElement> iconDivs = headerRow.children[index].getElementsByClassName("ui-sortable-column-icon");
        if (iconDivs.isNotEmpty)
        {
          iconDivs[0].classes.add("ui-icon-carat-2-n-s");
          iconDivs[0].classes.remove("ui-icon-triangle-1-n");
          iconDivs[0].classes.remove("ui-icon-triangle-1-s");
        }
      }
    }
  }


  void _addColumnToRow(DivElement row, Element c) {
    DivElement cell = new DivElement();
    cell.attributes["role"]="gridcell";
    cell.style.display="table-cell";
    cell.classes.add("td");
    cell.innerHtml=c.innerHtml;
    row.children.add(cell);
  }

  /** Adds a column and adds it to the list of headers */
  void addColumn(Column col)
  {

    if (!(_columnHeaders.any((Column c)=> c.header==col.header)))
    {
       _columnHeaders.add(col);
    }
  }
}



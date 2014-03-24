library puiDatatable;

import '../core/pui-base-component.dart';
import 'package:angular/angular.dart';
import 'dart:html';
part "pui-column.dart";
part "pui-row.dart";

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

  bool initialized = false;

  /**
   * Initializes the component by setting the <pui-datatable> field and setting the scope.
   */
  PuiDatatableComponent(this.scope, this.puiDatatableElement) {
    List<Element> headers = puiDatatableElement.querySelectorAll("header");
    headers.forEach((Element header) {
      String h = header.attributes["header"];
      String closable = header.attributes["closable"];
      String sortable = header.attributes["sortable"];
      _columnHeaders.add(new Column(h, "true"==closable, "true"==sortable));
    });


  }

  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   */
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowTableContent = shadowRoot.getElementById("pui-content");

    var rows = puiDatatableElement.children;
     DivElement header=new DivElement();
       header.classes.add("thead ui-widget-header");
       header.style.display="table-row";
       shadowTableContent.children.insert(0, header);

       _columnHeaders.forEach((Column col){
       _addColumnToHeader(shadowTableContent, col);
     });

     var toBeWatched = puiDatatableElement.attributes["puiDatatableWatch"];
     if (toBeWatched!=null)
     {
       toBeWatched = toBeWatched + ".length";
       scope.parentScope.watch(toBeWatched, (oldVal, newVal)=> redrawTable(), readOnly: true);
     }
     else
       redrawTable();
     initialized=true;
  }

  void redrawTable() {
    if (initialized)
    {
      var rows = puiDatatableElement.children;

      while (shadowTableContent.children.length>1) shadowTableContent.children.removeAt(1);


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
        sortRows(shadowTableContent.children, index, dir);
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

  /** Sorts the rows alphabetically */
  void sortRows(List<Element> rows, int index, int dir) {
    List<Element> myRows = new List<Element>();
    var v = rows.sublist(1);
    v.forEach((DivElement e){myRows.add(e);});
    myRows.sort((DivElement r1, DivElement r2) => compare(r1, r2, index, dir));
    myRows.insert(0, rows[0]);
    rows.clear();
    for (int i=0; i < myRows.length; i++){
      rows.add(myRows[i]);
    }
  }

  int compare(DivElement r1, DivElement r2, int index, int dir) {
    if (r1.classes.contains("thead")) return -1;
    if (r2.classes.contains("thead")) return 1;
    var cell1 = r1.children[index];
    String caption1 = cell1.innerHtml;
    var cell2 = r2.children[index];
    String caption2 = cell2.innerHtml;
    if (dir==1)
      return caption1.compareTo(caption2);
    else
      return caption2.compareTo(caption1);

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



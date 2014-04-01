library puiDatatable;

import '../core/pui-base-component.dart';
import '../core/pui-module.dart';
import 'package:angular/angular.dart';
import 'dart:html';
import 'dart:async';
part "pui-column-header.dart";

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
@NgComponent(visibility: NgDirective.CHILDREN_VISIBILITY,
    selector: 'pui-datatable',
    templateUrl: 'packages/angularprime_dart/puiDatatable/pui-datatable.html',
    cssUrl:       'packages/angularprime_dart/puiDatatable/pui-datatable.css',
    applyAuthorStyles: true,
    publishAs: 'cmp')
class PuiDatatableComponent extends PuiBaseComponent implements
    NgShadowRootAware {

  /** The <pui-input> field as defined in the HTML source code. */
  Element puiDatatableElement;

  /** This is the table content that's really displayed. */
  DivElement shadowTableContent;

  /** The scope is needed to add watches. */
  Scope scope;

  /** List of the columns registered until now */
  List<Column> columnHeaders = new List<Column>();

  /** The list to be displayed */
  @NgTwoWay("list")
  List myList;

  bool initialized = false;

  Compiler compiler;
  Injector injector;
  DirectiveMap directives;

  String test="Ich bin hier";

  /**
   * Initializes the component by setting the <pui-datatable> field and setting the scope.
   */
  PuiDatatableComponent(this.scope, this.puiDatatableElement, this.compiler, this.injector, this.directives) {
    PuiDatatableSortFilter.register(puiDatatableElement.attributes["puiListVariableName"], this);
  }

  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   */
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowTableContent = shadowRoot.getElementById("pui-content");

    columnHeaders.forEach((Column col) {
      _addColumnToHeader(shadowTableContent, col);
    });

  }

  void _addColumnToHeader(Element shadowTableContent, Column col) {
    DivElement header = shadowTableContent.children[0];
    header.attributes["role"] = "row";
    DivElement captionCell = new DivElement();
    captionCell.classes.add("pui-datatable-th");
    captionCell.classes.add("ui-widget-header");

    captionCell.style.display = "table-cell";
    captionCell.attributes["role"] = "columnheader";
    captionCell.style.whiteSpace = "nowrap";
    SpanElement caption = new SpanElement();
    caption.innerHtml = col.header;
    caption.style.float = "left";
    captionCell.children.add(caption);


    header.children.add(captionCell);
    if (col.closable) {
      SpanElement closeIcon = new SpanElement();
      closeIcon.style.float = "right";
      closeIcon.classes.add("ui-icon");
      closeIcon.classes.add("ui-icon-close");
      closeIcon.onClick.listen((MouseEvent event) {
        closeColumn(event, captionCell);
      });
      captionCell.children.add(closeIcon);
    }
    if (col.sortable) {
      SpanElement sortIcon = new SpanElement();
      sortIcon.style.float = "right";
      sortIcon.classes.add("ui-icon");
      sortIcon.classes.add("ui-sortable-column-icon");
      sortIcon.classes.add("ui-icon-carat-2-n-s");
      sortIcon.onClick.listen((MouseEvent event) {
        _sortColumn(event, captionCell);
      });
      captionCell.children.add(sortIcon);

    }
  }

  /** Called by the action listener of the close button. Hides a particular column. */
  closeColumn(MouseEvent event, DivElement close) {
    DivElement headerRow = shadowTableContent.children[0];
    int index = 0;
    for ( ; index < headerRow.children.length; index++) {
      if (headerRow.children[index] == close) {
        columnHeaders[index].hidden = true;
        ElementList headers = shadowTableContent.querySelectorAll(".pui-datatable-th");
        headers[index].style.display = "none";
//        shadowTableContent.children.forEach((DivElement row) {
//          row.children[index].style.display = "none";
//        });
        ElementList rows = puiDatatableElement.querySelectorAll(".tr");
        rows.forEach((Element row) {
          row.children[index].style.display = "none";
        });
        break;
      }
    }
    _drawLeftBoundaryLine();
  }

  _sortColumn(MouseEvent event, DivElement sortColumn) {
    // ugly hack to force the ng-repeat watch to fire
    if (myList.any((e)=> e==null))
    {
      myList.retainWhere((e)=>e!=null);
    }
    else
    {
      myList.insert(0, null);
    }
    // end of the ugly hack
    DivElement headerRow = shadowTableContent.children[0];
    int index = 0;
    for ( ; index < headerRow.children.length; index++) {
      if (headerRow.children[index] == sortColumn) {
        int dir = columnHeaders[index].sortDirection;
        bool sortUp;
        List<SpanElement> iconDivs =
            headerRow.children[index].getElementsByClassName("ui-sortable-column-icon");
        if (dir == 0) {
          iconDivs[0].classes.remove("ui-icon-carat-2-n-s");
          iconDivs[0].classes.add("ui-icon-triangle-1-n");
          dir = 1;
        } else if (dir == 1) {
          iconDivs[0].classes.remove("ui-icon-triangle-1-n");
          iconDivs[0].classes.add("ui-icon-triangle-1-s");
          dir = 2;
        } else {
          iconDivs[0].classes.remove("ui-icon-triangle-1-s");
          iconDivs[0].classes.add("ui-icon-triangle-1-n");
          dir = 1;
        }
        columnHeaders[index].sortDirection = dir;
      } else {
        columnHeaders[index].sortDirection=0;
        // remove sort icon (if necessary)
        List<SpanElement> iconDivs =
            headerRow.children[index].getElementsByClassName("ui-sortable-column-icon");
        if (iconDivs.isNotEmpty) {
          iconDivs[0].classes.add("ui-icon-carat-2-n-s");
          iconDivs[0].classes.remove("ui-icon-triangle-1-n");
          iconDivs[0].classes.remove("ui-icon-triangle-1-s");
        }
      }
    }
  }

  /** Compares the content of two cell alphabetically. Used by sort(). */
  int _compare(DivElement r1, DivElement r2, int index, int dir) {
    if (r1.classes.contains("thead")) return -1;
    if (r2.classes.contains("thead")) return 1;
    var cell1 = r1.children[index];
    String caption1 = cell1.innerHtml;
    var cell2 = r2.children[index];
    String caption2 = cell2.innerHtml;
    if (dir == 1) return caption1.compareTo(caption2); else return
        caption2.compareTo(caption1);

  }


  void addHTMLToDiv(innerHtml, DivElement cell) {
    try {
      Element inside = PuiHtmlUtils.parseResponse(innerHtml);
      ViewFactory template = compiler([inside], directives);
      Scope childScope = scope.createChild(scope.context);
      Module module = new Module()..value(Scope, childScope);
      List<Module> modules = new List<Module>();
      modules.add(module);
      Injector childInjector = injector.createChild(modules);
      template(childInjector, [inside]);
      cell.children.add(inside);
    } catch (error) {
      print("Error: $error");
      cell.innerHtml = "error";
    }
  }

  /** If the first column(s) is/are hidden, the left border line has to be provided by the first visible cell of each row. */
  void _drawLeftBoundaryLine() {
    if (columnHeaders[0].hidden) {
      int firstVisibleIndex = 0;
      for ( ; firstVisibleIndex < columnHeaders.length; firstVisibleIndex++) {
        if (!(columnHeaders[firstVisibleIndex].hidden)) break;
      }
      shadowTableContent.children.forEach((Element row) {
        if (row.children.length > firstVisibleIndex) {
          row.children[firstVisibleIndex].style.borderLeftWidth = "1px";
        }
      });
    }
  }


  addColumn(Column column) {
    columnHeaders.add(column);
  }

  List sortAndFilter(List originalList)
  {
    return originalList;
  }

}

/** PuiDatatable adds or removes empty row to force the watch watching the collection to fire. This filter prevents the empty rows from being shown. */
@NgFilter(name: 'puiEmptyRowsFilter')
class PuiEmptyRowsFilter {

  List call(List original, PuiDatatableComponent pui) {
      List newList = new List();
      // fix the null values introduced by the ugly hack in sortColumn()
     original.forEach((r){ if (null!=r) newList.add(r);});
     scheduleMicrotask((){pui.myList.retainWhere((e)=>e!=null);});
     return newList;
  }
}

/** The puiSortFilter sorts a ng-repeat list according to the sort order of the puiDatatable */
@NgFilter(name: 'puiDatatableSortFilter')
class PuiDatatableSortFilter {
  /** AngularDart's orderBy filter sorts a list by a column name (which is given as a String) */
  OrderByFilter _orderBy;

  /** PuiDatatable adds or removes empty row to force the watch watching the collection to fire. This filter prevents the empty rows from being shown. */
  PuiEmptyRowsFilter _emptyRowsFilter;

  PuiDatatableSortFilter(Parser parser){
    _orderBy=new OrderByFilter(parser);
    _emptyRowsFilter=new PuiEmptyRowsFilter();
  }

  /** PuiFilters aren't bound to a particular component, so every PuiDatatable registers itself to the filter in order to link filters and table */
  static Map<String, PuiDatatableComponent> tables = new Map<String, PuiDatatableComponent>();

  /** PuiFilters aren't bound to a particular component, so every PuiDatatable registers itself to the filter in order to link filters and table */
  static register(String name, PuiDatatableComponent puiDatatableComponent) {
    tables[name]=puiDatatableComponent;
  }

  /** Finds out, which PuiDatatable is to be sorted, finds out, by which column and in which order it is to be sorted and delegates sorting the Angular's OrderByFilter */
  List call(List original, String tableName, [bool descending=false]) {
    PuiDatatableComponent pui = tables[tableName];
    try
    {
      Column firstWhere = pui.columnHeaders.firstWhere((Column c) => c.sortDirection!=0);
      List nonEmptyRows = _emptyRowsFilter.call(original, pui);
      return _orderBy.call(nonEmptyRows, firstWhere.varName, firstWhere.sortDirection==2);
    }
    catch (notSortedException)
    {
      return original;
    }
  }
}
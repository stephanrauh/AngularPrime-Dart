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

library puiDatatable;

import '../core/pui-base-component.dart';
import '../core/pui-module.dart';
import 'package:angular/angular.dart';
import 'package:angular/core/parser/dynamic_parser.dart';

import 'dart:html';
import 'dart:async';
part 'pui-datatable-preparator.dart';
part 'pui-datatable-formatters.dart';
part 'pui-column.dart';
part 'pui-contentRow.dart';

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
@Component(visibility: Directive.CHILDREN_VISIBILITY,
    selector: 'pui-datatable',
    templateUrl: 'packages/angularprime_dart/puiDatatable/pui-datatable.html',
    cssUrl:       'packages/angularprime_dart/puiDatatable/pui-datatable.css',
    applyAuthorStyles: true,
    publishAs: 'cmp')
class PuiDatatableComponent extends PuiBaseComponent implements
    ShadowRootAware {

  /** The <pui-input> field as defined in the HTML source code. */
  Element puiDatatableElement;

  /** This is the table content that's really displayed. */
  DivElement shadowTableContent;

  /** The scope is needed to add watches. */
  Scope scope;

  /** List of the columns registered until now */
  List<Column> columnHeaders = new List<Column>();

  /** The list to be displayed */
  @NgTwoWay("value")
  List myList;

  @NgAttr("initialsort")
  String initialsort;

  @NgAttr("initialsortorder")
  String initialsortorder;

  bool initialized = false;

  /** HTML code of the columns */
  String contentColumns;

  /** This message is displayed if the table is empty */
  String emptyMessage="no results found";

  /** Unique identifier of the table - needed for the sort formatter */
  String uniqueTableID;

  String cellStyle(int col)
  {
    if (columnHeaders[col].hidden)
      return "invisible";
    else
      return "tablecell";
  }

  /**
   * Initializes the component by setting the <pui-datatable> field and setting the scope.
   */
  PuiDatatableComponent(this.scope, this.puiDatatableElement, Compiler compiler, Injector injector, DirectiveMap directives, Parser parser): super(compiler, injector, directives, parser) {
    contentColumns=prepareDatatable(puiDatatableElement, this);
    PuiDatatableSortFilter.register(uniqueTableID, this);

    puiDatatableElement.children.clear();
  }

  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   */
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowTableContent = shadowRoot.getElementById("pui-content");
    ElementList targetDiv = shadowRoot.querySelectorAll('contentRows');
    Element targetDiv2 = shadowRoot.getElementById('contentRows');


    addHeaderRow();
    addFilterRow();


    if (null!=puiDatatableElement.attributes["emptyMessage"])
    {
      emptyMessage=puiDatatableElement.attributes["emptyMessage"];
    }
    addFooterRow();
  }

  /**
   * Popolates the header of the data table with the columns' captions.
   */
  void addHeaderRow() {
    DivElement header = shadowTableContent.querySelector("#headerRow");
    columnHeaders.forEach((Column col) {
      _addColumnToHeader(header, col);
    });

  }

  /**
   * Shows a row containing column filters, or hides it, if there's no filter.
   */
  void addFilterRow() {
    var filterRow = shadowTableContent.querySelector("#filterRow");
    if (columnHeaders.any((Column col) => col.filterby!=null && col.filterby!=""))
    {
      columnHeaders.forEach((Column col) {
        _addColumnToFilter(filterRow, col);
      });
    }
    else
    {
      filterRow.style.display="none";
    }
  }

  /** Shows a row below the data table containing optional footers, or hides the row if it's not needed. */
  void addFooterRow() {
    var footerRow = shadowTableContent.querySelector("#footerRow");
    if (columnHeaders.any((Column col) => col.footerText!=null && col.footerText!=""))
    {
      columnHeaders.forEach((Column col) {
        _addColumnToFooter(footerRow, col);
      });
    }
    else
    {
      footerRow.style.display="none";
    }

  }

  /** Adds a single column filter cell. */
  void _addColumnToFilter(DivElement filter, Column col) {
    DivElement captionCell = new DivElement();
    captionCell.classes.add("pui-datatable-th");
    captionCell.classes.add("ui-widget-header");

    captionCell.style.display = "table-cell";
    captionCell.attributes["role"] = "columnfooter";
    captionCell.style.whiteSpace = "nowrap";
    if (null != col.filterby && col.filterby!="")
    {
      DivElement overlay = new DivElement();
      overlay.innerHtml = "filter by ${col.header}";
      overlay.style.position="relative";
      overlay.style.color="#BBB";
      overlay.style.zIndex="99";
      InputElement f = new InputElement(type: "text");
      f.style.position="relative";
      f.style.top="-20px";
      f.style.marginBottom="-20px";
      f.style.zIndex="0";
      captionCell.children.add(overlay);
      captionCell.children.add(f);

      // activate input field on click
      overlay.onClick.listen((e){overlay.style.zIndex="-99"; f.focus();});

      f.style.float = "left";
      f.onKeyUp.listen((KeyboardEvent e) {
        if (overlay.style.display!="none" && f.value.length>0)
        {
          overlay.style.zIndex="-99";
          col.currentFilter=f.value;
        }
        else if (f.value.length==0)
        {
          overlay.style.zIndex="99";
          col.currentFilter="";
        }
        else
        {
          col.currentFilter=f.value;
        }
        triggerFiltering();
        e.preventDefault();
      });
    }
    filter.children.add(captionCell);
  }

  /** Adds a single table footer cell. */
  void _addColumnToFooter(DivElement footer, Column col) {
    DivElement captionCell = new DivElement();
    captionCell.classes.add("pui-datatable-th");
    captionCell.classes.add("ui-widget-header");

    captionCell.style.display = "table-cell";
    captionCell.attributes["role"] = "columnfooter";
    captionCell.style.whiteSpace = "nowrap";
    SpanElement caption = new SpanElement();
    caption.innerHtml = col.footerText;
    caption.style.float = "left";
    captionCell.children.add(caption);
    footer.children.add(captionCell);
  }

  /** Adds a single table header cell. */
  void _addColumnToHeader(DivElement header , Column col) {
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
        _sortColumn(captionCell);
      });
      captionCell.children.add(sortIcon);

    }
  }

  /** Called by the action listener of the close button. Hides a particular column. */
  closeColumn(MouseEvent event, DivElement close) {
    DivElement headerRow = shadowTableContent.querySelector("#headerRow");
    DivElement filterRow = shadowTableContent.querySelector("#filterRow");
    DivElement footerRow = shadowTableContent.querySelector("#footerRow");
    int index = 0;
    for ( ; index < headerRow.children.length; index++) {
      if (headerRow.children[index] == close) {
        columnHeaders[index].hidden = true;
        headerRow.children[index].style.display = "none";
        filterRow.children[index].style.display = "none";
        footerRow.children[index].style.display = "none";
        break;
      }
    }
    _drawLeftBoundaryLine();
  }

  _sortColumn(DivElement sortColumn) {
    // ugly hack to force the ng-repeat watch to fire
    triggerFiltering();
    // end of the ugly hack
    DivElement headerRow = shadowTableContent.children[0];
    int index = 0;
    for ( ; index < headerRow.children.length; index++) {
      HtmlCollection iconDivs =
          headerRow.children[index].getElementsByClassName("ui-sortable-column-icon");
      if (iconDivs.length>0)
      {
        Element iconDiv = iconDivs[0];
        if (headerRow.children[index] == sortColumn) {
          int dir = columnHeaders[index].sortDirection;
          bool sortUp;
          if (dir == 0) {
           iconDiv.classes.remove("ui-icon-carat-2-n-s");
            iconDiv.classes.add("ui-icon-triangle-1-n");
            dir = 1;
          } else if (dir == 1) {
            iconDiv.classes.remove("ui-icon-triangle-1-n");
            iconDiv.classes.add("ui-icon-triangle-1-s");
            dir = 2;
          } else {
            iconDiv.classes.remove("ui-icon-triangle-1-s");
            iconDiv.classes.add("ui-icon-triangle-1-n");
            dir = 1;
          }
          columnHeaders[index].sortDirection = dir;
        } else {
          columnHeaders[index].sortDirection=0;
          // remove sort icon (if necessary)
          HtmlCollection iconDivs =
              headerRow.children[index].getElementsByClassName("ui-sortable-column-icon");
          if (iconDivs.isNotEmpty) {
            iconDiv.classes.add("ui-icon-carat-2-n-s");
            iconDiv.classes.remove("ui-icon-triangle-1-n");
            iconDiv.classes.remove("ui-icon-triangle-1-s");
          }
        }
      }
    }
  }

  /** ugly hack to force the ng-repeat watch to fire */
  void triggerFiltering() {
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

  }

  void addHTMLToDiv(innerHtml, DivElement cell) {
    try {
      Element inside = PuiHtmlUtils.parseResponse(innerHtml);
      ViewFactory template = compiler([inside], directives);
      Scope childScope = scope.createChild(scope.context);
      Module module = new Module()..bind(Scope, toValue:childScope);
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

}



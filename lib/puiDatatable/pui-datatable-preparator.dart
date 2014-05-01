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

part of puiDatatable;

/** finds a simple interpolated variable or method. Complex formulas are not detected
 * (by will, because we can't deal with them).
 */
final RegExp VARIABLE_EXPRESSION = new RegExp(r'^\s*{{\s*([a-zA-Z0-9_\(\)\.]+)\s*}}\s*?$');

/** Syntax of an ng-repeat statement. Copied from ngRepeat. */
final RegExp _NG_REPEAT_SYNTAX = new RegExp(r'^\s*(.+)\s+in\s+(.*?)\s*(\s+track\s+by\s+(.+)\s*)?(\s+lazily\s*)?$');

/** Datatables need a unique identifier to be processed by the Formatter (PuiDatatableSortFilter in particular). */
int uniqueDatabaseID = 0;

/**
 * TODO: move this method to the puiDataTableComponent class (either to onShadow or onAttach).
 *
 * Converts <pui-datatable> to a format that can be processed by AngularDart.
 * In general, AngularDart is very flexible. However, as we want to provide
 * a radically simple table widget we don't follow Angular's conventions.
 * So we have to rearrange the HTML code (more precisely: the DOM tree) before Angular
 * is initialized.
 */
String prepareDatatable(Element puiDatatableElement, PuiDatatableComponent puiDatatableComponent) {
  int puiTableID = uniqueDatabaseID++;

  puiDatatableComponent.uniqueTableID=puiTableID.toString();
  ElementList columns = puiDatatableElement.querySelectorAll('pui-column');
  _prepareTableHeader(columns, puiDatatableComponent);

  String content = puiDatatableElement.innerHtml;
  ElementList rows = puiDatatableElement.querySelectorAll('pui-row');

  print("-------------------------------------------------------------");
  print(content);

  String newContent = content.replaceAll("<pui-row", """<div """)
      .replaceAll("</pui-row>", "</div>")
      .replaceAll("<pui-column ", """<div """)
      .replaceAll("</pui-column>", "</div>");
  print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  print(newContent);
  return newContent;
//  Element inside = PuiHtmlUtils.parseResponse("<span>$newContent</span>");
//  List<Node> inner = new List<Node>();
//  inside.childNodes.forEach((Node n){inner.add(n);});
//  return inside.innerHtml;
}

/**
 * TODO: move this method to the puiDataTableComponent class (either to onShadow or onAttach).
 *
 * Generates DIV elements to display a header for each column using the informations given in <pui-column> */
void _prepareTableHeader(ElementList columns, PuiDatatableComponent puiDatatable) {
  int c = 0;
  columns.forEach((Element col) {
    col.attributes["data-ci"]=c.toString();
    col.classes.add("pui-datatable-td");
    col.classes.add("ui-widget-content");
    col.style.display="table-cell";
    col.attributes["role"]="gridcell";
    bool closable= col.attributes["closable"]=="true";
    bool sortable = col.attributes["sortable"]=="true";
    String sortBy=col.attributes["sortBy"];
    if (sortBy!=null) {
      sortable=true;
    }
    else if (sortable==true){
      String inner = col.innerHtml;
      Match match = VARIABLE_EXPRESSION.firstMatch(inner);
      if (match == null) {
        throw "[pui-datatable-error] Can't find out by which row variable the column is to be sorted. Please specify sortBy attribute.";
      }
      sortBy=match.group(1);
      int pos = sortBy.indexOf("\.");
      if (pos>0)
      {
        sortBy=sortBy.substring(pos+1);
      }
    }
    String filterby=col.attributes["filterby"];
    if (null==filterby) filterby="";
    String filterMatchMode=col.attributes["filterMatchMode"];
    if (null == filterMatchMode) filterMatchMode="startsWith";

    String header = "${col.attributes["header"]==null?"":col.attributes["header"]}";
    String footerText="${col.attributes["footerText"]==null?"":col.attributes["footerText"]}";
    puiDatatable.addColumn(new Column(header, footerText, closable,
                                        sortable, sortBy,
                                        filterby, filterMatchMode));

    c++;
  });
}


/** Copied from ng-repeat.dart. Extracts the name of the list from an ng-repeat statement. */
String extractNameOfCollection(String ngRepeatStatement) {
  Match match = _NG_REPEAT_SYNTAX.firstMatch(ngRepeatStatement);
  if (match == null) {
    throw "[NgErr7] ngRepeat error! Expected expression in form of '_item_ "
        "in _collection_[ track by _id_]' but got '$ngRepeatStatement'.";
  }
  String _listExpr = match.group(2);
  return _listExpr;
}




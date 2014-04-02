part of angularprime_dart;

/**
 * Converts <pui-datatable> to a format that can be processed by AngularDart.
 * In general, AngularDart is very flexible. However, as we want to provide
 * a radically simple table widget we don't follow Angular's conventions.
 * So we have to rearrange the HTML code (more precisely: the DOM tree) before Angular
 * is initialized.
 */
void prepareDatatables()
{
  NodeList list = window.document.getElementsByTagName('pui-datatable');
  list.forEach((Element puiDatatable){
    _prepareDatatable(puiDatatable);
  });
}

/**
 * Converts a single <pui-datatable> from an abstract declarative style to a more AngularDart-compatible style.
 */

_prepareDatatable(Element puiDatatable) {
  ElementList columns = puiDatatable.querySelectorAll('pui-column');
  String headers = _prepareTableHeader(columns);

  String content = puiDatatable.innerHtml;
  ElementList rows = puiDatatable.querySelectorAll('pui-row');
  String listName;
  if (rows.isEmpty)
  {
    /** add pui-datatable functionality to ng-repeat */
    String ngRepeat = puiDatatable.attributes["ng-repeat"];
    if (null==ngRepeat)
    {
      String loopVar=puiDatatable.attributes["var"];
      listName=puiDatatable.attributes["value"];
      if (null==listName){
        throw "[pui-datatable-err] Wrong datatable configuration: Please specify either ng-repeat or the list and - optionally - a loop variable";
      }
      if (null==loopVar) loopVar="row";

      ngRepeat = "$loopVar in $listName";
    }
    else {
      listName = extractNameOfCollection(ngRepeat);
      puiDatatable.attributes["value"]=listName;
    }
    ngRepeat = ngRepeat + " | puiDatatableSortFilter:'$listName'";
    puiDatatable.attributes["puiListVariableName"]=listName;
    content = """<pui-row pui-repeat="$ngRepeat" role="row" style="display:table-row" class="tr ui-widget-content">$content</pui-row>""";
    puiDatatable.attributes.remove("ng-repeat");
  }
  else
  {
    rows.forEach((Element row){
      /** add pui-datatable functionality to ng-repeat */
      String ngRepeat = row.attributes["ng-repeat"];
      listName = extractNameOfCollection(ngRepeat);
      ngRepeat = ngRepeat + " | puiDatatableSortFilter:'$listName'";
      puiDatatable.attributes["value"]=listName;
      puiDatatable.attributes["value"]=listName;
      row.attributes["pui-repeat"]=ngRepeat;
      row.attributes.remove("ng-repeat");

      row.attributes["data-ri"]=r'{{$index.toString()}}';
      row.classes.add("tr");
      row.classes.add("ui-widget-content");
      row.style.display="table-row";
      row.attributes["role"]="row";
    });
    content = puiDatatable.innerHtml;
  }
  String emptyMessage=puiDatatable.attributes["emptyMessage"];
  if (null==emptyMessage) emptyMessage="no results found";
  String footer = """<div role="row" style="{{$listName.isEmpty?'display:table-row':'display:none'}}" class="tr ui-widget-content">
                         <div role="gridcell" class="pui-datatable-td ui-widget-content">
                            $emptyMessage
                         </div>
                     </div>""";

  content=headers + content + footer;

  String newContent = content.replaceAll("<pui-row", """<div """)
      .replaceAll("</pui-row>", "</div>")
      .replaceAll("<pui-column ", """<div """)
      .replaceAll("</pui-column>", "</div>");
  Element inside = PuiHtmlUtils.parseResponse("<span>$newContent</span>");
  puiDatatable.children.clear();
  puiDatatable.children.addAll(inside.children);
}

/** Generates DIV elements to display a header for each column using the informations given in <pui-column> */
String _prepareTableHeader(ElementList columns) {
  String headers="";
  int c = 0;
  columns.forEach((Element col) {
    col.attributes["data-ci"]=c.toString();
    col.classes.add("pui-datatable-td");
    col.classes.add("ui-widget-content");
    col.style.display="table-cell";
    col.attributes["role"]="gridcell";
    String closable=col.attributes["closable"];
    if (closable==null) closable="false";
    String sortable=col.attributes["sortable"];
    if (sortable==null) sortable="false";

    headers += """<pui-column-header header="${col.attributes["header"]}" closable="$closable"  sortable="$sortable"></pui-column-header>\n""";
    c++;
  });
  return headers;
}

/** Copied from ng-repeat.dart. Extracts the name of the list from an ng-repeat statement. */
String extractNameOfCollection(String ngRepeatStatement) {
  RegExp _SYNTAX = new RegExp(r'^\s*(.+)\s+in\s+(.*?)\s*(\s+track\s+by\s+(.+)\s*)?(\s+lazily\s*)?$');
  Match match = _SYNTAX.firstMatch(ngRepeatStatement);
  if (match == null) {
    throw "[NgErr7] ngRepeat error! Expected expression in form of '_item_ "
        "in _collection_[ track by _id_]' but got '$ngRepeatStatement'.";
  }
  String _listExpr = match.group(2);
  return _listExpr;
}




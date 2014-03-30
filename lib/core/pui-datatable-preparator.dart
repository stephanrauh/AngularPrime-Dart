part of angularprime_dart;

/** Converts <pui-datatable> to a format that can be processed by AngularDart */
void prepareDatatables()
{
  NodeList list = window.document.getElementsByTagName('pui-datatable');
  list.forEach((Element puiDatatable){
    _prepareDatatable(puiDatatable);
  });
}


_prepareDatatable(Element puiDatatable) {
  ElementList columns = puiDatatable.querySelectorAll('pui-column');
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

  String content = puiDatatable.innerHtml;
  ElementList rows = puiDatatable.querySelectorAll('pui-row');
  if (rows.isEmpty)
  {
    /** add pui-datatable functionality to ng-repeat */
    String ngRepeat = puiDatatable.attributes["ng-repeat"];
    String listName = extractNameOfCollection(ngRepeat);
    ngRepeat = ngRepeat + " | puiFilter:listName";
    puiDatatable.attributes["puiListVariableName"]=listName;
    content = """<pui-row pui-repeat="$ngRepeat" role="row" style="display:table-row" class="tr ui-widget-content {{rowClass()}}">$content</pui-row>""";
    row.attributes.remove("ng-repeat");
  }
  else
  {
    rows.forEach((Element row){
      /** add pui-datatable functionality to ng-repeat */
      String ngRepeat = row.attributes["ng-repeat"];
      String listName = extractNameOfCollection(ngRepeat);
      ngRepeat = ngRepeat + " | puiFilter:'$listName'";
      puiDatatable.attributes["puiListVariableName"]=listName;
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
  content=headers + content;
  String newContent = content.replaceAll("<pui-row", """<div """)
      .replaceAll("</pui-row>", "</div>")
      .replaceAll("<pui-column ", """<div """)
      .replaceAll("</pui-column>", "</div>");
  Element inside = PuiHtmlUtils.parseResponse("<span>$newContent</span>");
  puiDatatable.children.clear();
  puiDatatable.children.addAll(inside.children);

}

/** Copied from ng-repeat.dart */
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

_addRowTag(Element puiDatatable, ElementList columns) {
  print("Add Row line");
}




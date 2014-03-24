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
  ElementList rows = puiDatatable.querySelectorAll('pui-row');
  ElementList columns = puiDatatable.querySelectorAll('pui-column');
  _addHeaderTags(puiDatatable, columns);
  String ngRepeatStatement;
  if (rows.isEmpty)
  {
    ngRepeatStatement=puiDatatable.attributes["ng-repeat"];
    _addRowTag(puiDatatable, columns);
  }
  else
  {
    ngRepeatStatement=rows[0].attributes["ng-repeat"];
  }
  print("ng-repeat = $ngRepeatStatement");

  var toBeWatched = extractNameOfCollection(ngRepeatStatement);
  puiDatatable.attributes["puiDatatableWatch"]=toBeWatched;
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

_addHeaderTags(Element puiDatatable, ElementList columns) {
  print("Add Headers");
  columns.forEach((Element column){
    Element h = new Element.header();
    h.attributes["header"]=column.attributes["header"];
    String s = column.attributes["sortable"];
    if (s==null) s="false";
    h.attributes["sortable"]=s;
    String c = column.attributes["closable"];
    if (c==null)c="false";
    h.attributes["closable"]=c;
    puiDatatable.children.add(h);
  });
}

_addRowTag(Element puiDatatable, ElementList columns) {
  print("Add Row line");
}




part of puiDatatable;

@NgComponent(
  visibility: NgDirective.CHILDREN_VISIBILITY,
  selector: 'pui-column-header',
  cssUrl:       'packages/angularprime_dart/puiDatatable/pui-datatable.css',
  template: '',
  applyAuthorStyles: true,
  publishAs: 'cmp'
)
class PuiColumnHeaderComponent extends PuiBaseComponent implements NgShadowRootAware {

  /** The <pui-column-header> field as defined in the HTML source code. */
  Element _puiColumnHeaderElement;

  /** The scope is needed to add watches. */
  Scope _scope;

  /** Can the tab be closed? */
  bool _closable=false;

  /** Can the tab be closed? */
  @NgAttr("closable")
  set closable(String s){_closable="true"==s;}

  bool isClosable() => _closable;

  /** Can the tab be closed? */
  bool _sortable=false;

  /** Can the tab be closed? */
  @NgAttr("sortable")
  set sortable(String s){_sortable="true"==s;}

  bool isSortable() => _sortable;

  /** Caption of the row */
  @NgAttr("header")
  String header;

  /** This is the datatable component the column is part of */
  PuiDatatableComponent puiDatatableComponent;

  /**
   * Initializes the component by setting the <pui-datatable> field and setting the scope.
   */
  PuiColumnHeaderComponent(this._scope, this._puiColumnHeaderElement, this.puiDatatableComponent ) {
  }


  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    puiDatatableComponent.addColumn(new Column(header, isClosable(), isSortable()));
  }
}

/** Abstract description of the colum. */
class Column {
  /** Can the column be hidden hy hitting the close button? */
  bool closable;

  /** Caption of the column. */
  String header;

  /** Can the table be sorted by hitting the columns sort button? */
  bool sortable;

  /** 0=not sorted, 1=sort upwards, 2=sort downwards */
  int sortDirection=0;

  /** Is the current row hidden? */
  bool hidden=false;

  /** Attribute name of the column */
  String varName;

  Column(this.header, this.closable, this.sortable) {
    varName=this.header.toLowerCase();
  }
}


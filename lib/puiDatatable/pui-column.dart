part of puiDatatable;

@NgComponent(
  visibility: NgDirective.CHILDREN_VISIBILITY,
  selector: 'pui-column',
  template: '',
  applyAuthorStyles: true,
  publishAs: 'cmp'
)
class PuiColumnComponent extends PuiBaseComponent implements NgShadowRootAware {

  /** The <pui-column> field as defined in the HTML source code. */
  Element _puiColumnElement;

  /** The scope is needed to add watches. */
  Scope _scope;

  /** Needed to provide alternating row colors */
  bool _even=true;

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
  PuiColumnComponent(this._scope, this._puiColumnElement, this.puiDatatableComponent ) {
  }


  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
//    puiDatatableComponent.addColumn(new Column(header, isClosable(), isSortable()));
  }
}

/** Abstract description of the colum. */
class Column {
  bool closable;

  String header;

  bool sortable;

  /** 0=not sorted, 1=sort upwards, 2=sort downwards */
  int sortDirection=0;

  Column(this.header, this.closable, this.sortable);
}


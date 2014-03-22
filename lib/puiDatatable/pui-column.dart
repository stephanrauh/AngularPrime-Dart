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
  bool _closeable=false;

  /** Can the tab be closed? */
  @NgAttr("closeable")
  set closeable(String s){_closeable="true"==s;}

  bool isCloseable() => _closeable;

  /** Caption of the row */
  @NgAttr("header")
  String header;

  /** This is the datatable component the column is part of */
  PuiDatatableComponent puiDatatableComponent;

  /**
   * Initializes the component by setting the <pui-datatable> field and setting the scope.
   */
  PuiColumnComponent(this._scope, this._puiColumnElement, this.puiDatatableComponent ) {
    var element = _puiColumnElement.parent.parent;
  }


  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    puiDatatableComponent.addColumn(new Column(header, isCloseable()));
  }
}

class Column {
  bool closeable;

  String header;

  Column(this.header, this.closeable);
}


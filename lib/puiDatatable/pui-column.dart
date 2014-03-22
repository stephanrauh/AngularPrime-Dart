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

  /** Caption of the row */
  // @NgOneWay("header") //@ToDo: doesn't seem to work for some reason. Temporarily using work-around
  String header;

  /** This is the datatable component the column is part of */
  PuiDatatableComponent puiDatatableComponent;

  /**
   * Initializes the component by setting the <pui-datatable> field and setting the scope.
   */
  PuiColumnComponent(this._scope, this._puiColumnElement, this.puiDatatableComponent ) {
    var element = _puiColumnElement.parent.parent;
    String h = _puiColumnElement.attributes["header"];
    header=h;
    puiDatatableComponent.addColumn(header);
  }


  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    // TODO: implement onShadowRoot
  }
}


part of puiDatatable;

@NgComponent(
  visibility: NgDirective.CHILDREN_VISIBILITY,
  selector: 'pui-column',
  template: '',
  applyAuthorStyles: true,
  publishAs: 'cmp'
)
class PuiColumnComponent extends PuiBaseComponent implements NgShadowRootAware {

  /** The <pui-input> field as defined in the HTML source code. */
  Element _puiDatatableElement;

  /** The scope is needed to add watches. */
  Scope _scope;

  /** Needed to provide alternating row colors */
  bool _even=true;

  /** Caption of the row */
//  @NgOneWay("header") @ToDo: doesn't seem to work for some reason. Temporarily using work-around
  String header;

  /** This is the datatable component the column is part of */
  PuiDatatableComponent puiDatatableComponent;

  /**
   * Initializes the component by setting the <pui-datatable> field and setting the scope.
   */
  PuiColumnComponent(this._scope, this._puiDatatableElement, this.puiDatatableComponent ) {
    var element = _puiDatatableElement.parent.parent;
    String h = _puiDatatableElement.attributes["header"];
    header=h;
    print("puiDataTable=$puiDatatableComponent");
    print("element=${element.classes}");
    puiDatatableComponent.addColumn(header);
  }


  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    // TODO: implement onShadowRoot
  }
}


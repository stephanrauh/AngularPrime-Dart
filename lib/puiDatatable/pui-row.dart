part of puiDatatable;

@NgComponent(
  visibility: NgDirective.CHILDREN_VISIBILITY,
  selector: 'pui-row',
  template: '',
  applyAuthorStyles: true,
  publishAs: 'cmp'
)
class PuiColumnComponent extends PuiBaseComponent implements NgShadowRootAware {

  /** The <pui-row> field as defined in the HTML source code. */
  Element _puiRowElement;

  /** The scope is needed to add watches. */
  Scope _scope;

  /** Needed to provide alternating row colors */
  bool _even=true;

  /** This is the datatable component the column is part of */
  PuiDatatableComponent puiDatatableComponent;

  /**
   * Initializes the component by setting the <pui-datatable> field and setting the scope.
   */
  PuiColumnComponent(this._scope, this._puiRowElement, this.puiDatatableComponent ) {
  }


  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    // TODO: implement onShadowRoot
  }
}


part of puiDatatable;

@NgComponent(
  visibility: NgDirective.CHILDREN_VISIBILITY,
  selector: 'pui-row',
  template: '<content></content>',
  applyAuthorStyles: true,
  publishAs: 'cmp'
)
class PuiRowComponent extends PuiBaseComponent implements NgShadowRootAware {

  /** The <pui-row> field as defined in the HTML source code. */
  Element _puiRowElement;

  /** The scope is needed to add watches. */
  Scope _scope;

  /** Needed to provide alternating row colors */
  bool _even=true;

  /**
   * Initializes the component by setting the <pui-datatable> field and setting the scope.
   */
  PuiRowComponent(this._scope, this._puiRowElement) {
  }


  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    // TODO: implement onShadowRoot
  }
}


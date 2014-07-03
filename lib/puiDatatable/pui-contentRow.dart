part of puiDatatable;

@Component(visibility: Directive.CHILDREN_VISIBILITY,
    selector: 'pui-row',
    template: '<content></content>',
    useShadowDom:     false,
    publishAs: 'cmp')
class PuiContentRow extends PuiBaseComponent /* implements ShadowRootAware */
{
  Scope scope;
  PuiDatatableComponent table;
  Element puiRowElement;

  @NgOneWay("row")
  Object row;

  PuiContentRow(this.scope, this.table, this.puiRowElement, Compiler compiler, Injector injector, DirectiveMap directives, Parser parser): super(compiler, injector, directives, parser) {

    List<Node> list = PuiHtmlUtils.parseResponse("<span>${table.contentColumns}</span>").childNodes;

      ViewFactory template = compiler(list, directives);
      Injector childInjector =
          injector.createChild([new Module()..bind(Scope, toValue: scope.parentScope)]);
      template(childInjector, list);

      while (list.length>0) {
        Node n = list[0];
        puiRowElement.parent.nodes.add(n);
      }
      puiRowElement.parent.nodes.remove(puiRowElement);
    }
    //table.innerNodes.forEach((Node n){ puiRowElement.append(n);});

}


//ViewFactory template = compiler(puiRowElement.parent.childNodes, directives);
//Scope childScope = scope.createChild(scope.context);
//Injector childInjector =
//    injector.createChild([new Module()..bind(Scope, toValue: childScope)]);
//      Injector childInjector =
//          injector.createChild([new Module()..bind(Scope, toValue: scope)]);
//template(childInjector, puiRowElement.parent.childNodes);
//      innerNodes.forEach((Node n){ puiDatatableElement.append(n);});


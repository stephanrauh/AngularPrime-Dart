/**
 * (C) 2014 Stephan Rauh http://www.beyondjava.net
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
library puiGrid;

import 'dart:html';
import 'package:angular/angular.dart';
import '../core/pui-base-component.dart';

/**
 * <pui-grid> makes it a little easier to create simple but decently looking input dialogs.
 * Typically it contains a number of input fields that are automatically aligned to each other.
 * More precisely, <pui-grid> creates a column consisting of three columns. The first column is the label (which is automatically extracted from the component),
 * the second is the components itself and the third column is the field-specific error message. Alternative, the error message is placed below its field.
 * Likewise, the label can be put above the input field.
 *
 * @ToDo <pui-grid> is limited to a single column of components
 * @ToDo put labels optionally above the component
 * @ToDo put error message optionally behind the component
 */
@Component(
    selector: 'pui-grid',
    templateUrl: 'packages/angularprime_dart/puiGrid/pui-grid.html',
    useShadowDom:     false,
    publishAs: 'cmp'
)
class PuiGridComponent extends PuiBaseComponent implements ShadowRootAware  {

  /** The <pui-grid> field as defined in the HTML source code. */
  Element puiGridComponent;

  /**
   * Do you want to put the error message below or behind the field? Legal values: "below" and "behind". Default
   * value: "below".
   */
  @NgAttr("errorMessagePosition")
  String errorMessagePosition;


  /**
   * Do you want to put the label above or in front of the field? Legal values: "above" and "before". Default value:
   * "before".
   */
  @NgAttr("labelPosition")
  String labelPosition;

  /**
   * The number of columns. By default, there's only one column. Note that a pui-grid column actually consists
   * of two or three cells: the label, the component itself and - if it's placed behind the labe l - the error message.
   */
  @NgOneWayOneTime("columns")
  int columns;

  /** Comma separated list of the CSS classes of the columns. */
  @NgAttr("columnClasses")
  String columnClasses;

  /** If true, the code needed to support Bootstrap is generated. */
  @NgOneWayOneTime("bootstrap")
  bool bootstrap;

  /** If true, a label column is added to accomodate automatically labelled input fields. */
  @NgOneWayOneTime("hasLabel")
  bool hasLabel;

  /** The content of the grid */
  List<Element> content;

  /**
   * Initializes the component by setting the <pui-input> field and setting the scope.
   */
  PuiGridComponent(this.puiGridComponent, Compiler compiler, Injector injector, DirectiveMap directives, Parser parser): super(compiler, injector, directives, parser) {
    init();
  }

  /** Initializes the component. Can be called by the a deriving class's constructor (needed because the
   * super constructor is always called first, which isn't always the desired behaviour). */
  void init() {
    content= new List<Element>();
    puiGridComponent.children.forEach((Element e){content.add(e);});
  }



  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   *
   * @Todo Find out, which attributes are modified by Angular, and set a watch updating only the attributes that have changed.
   */
  void onShadowRoot(Node shadowRoot) {
    DivElement table = (shadowRoot as Element).children[0];
    if (bootstrap==false || bootstrap==null) {
      table.style.display="table";
    }
    List rows = table.children;
    List fields = content;
    var numberOfFields = fields.length;
    int c = (columns==null || columns<1) ? 1 : columns;
    Element firstRow=rows[0];
    if (bootstrap==false || bootstrap==null) {
      firstRow.style.display="table-row";
    }
    if (hasLabel==false) {
      firstRow.children.removeAt(0);
    }
    for (int i = 2; i <= c; i++)
    {
      firstRow.children.add(firstRow.children[0].clone(true));
      if (hasLabel==null || hasLabel==true) {
        firstRow.children.add(firstRow.children[1].clone(true));
      }
    }

    if (null != columnClasses) {
      List<String> classes = columnClasses.split(",");
      for (int i = 0; i < firstRow.children.length; i++) {
        String currentClass = classes[i % (classes.length)];
        firstRow.children[i].classes.add(currentClass);
      }
    }

    if (bootstrap==false || bootstrap==null) {
      firstRow.children.forEach((Element cell){cell.style.display="table-cell";});
    }

    for (int i = 2; i <= (numberOfFields + c - 1) / c; i++)
    {
        rows.add(rows[0].clone(true));
    }
    int currentColumn=0;
    int currentHTMLColumn=0;
    int currentRowIndex = 0;
    for (int i = 0; i < numberOfFields; i++)
    {
      DivElement currentRow = rows[currentRowIndex];
      DivElement currentCell=currentRow.children[currentHTMLColumn];
      HtmlElement currentField = fields[i];
      if (hasLabel==null || hasLabel==true) {
        LabelElement currentCellHeader=currentCell.children[0];
        String label = currentField.attributes["label"];
        if (null == label && null != currentField.attributes["ng-model"])
        {
          label = currentField.attributes["ng-model"];
        }
        if (label!=null)
        {
          currentCellHeader.innerHtml= label;
        }
        if (currentField.id==null || currentField.id=="")
        {
          currentField.id = "puiinputid:" + currentField.hashCode.toString();
        }
        currentCellHeader.attributes["for"]=currentField.id;

        currentHTMLColumn++;
      }
      currentCell=currentRow.children[currentHTMLColumn];
      currentCell.append(currentField);
      currentColumn++;
      currentHTMLColumn++;
      if (currentColumn >= c)
      {
        currentColumn=0;
        currentHTMLColumn=0;
        currentRowIndex++;
      }
    }
  }
}


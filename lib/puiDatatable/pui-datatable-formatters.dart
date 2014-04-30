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

part of puiDatatable;

/** PuiDatatable adds or removes empty row to force the watch watching the collection to fire. This filter prevents the empty rows from being shown. */
@Formatter(name: 'puiEmptyRowsFilter')
class PuiEmptyRowsFilter {

  List call(List original, PuiDatatableComponent pui) {
      List newList = new List();
      // fix the null values introduced by the ugly hack in sortColumn()
     original.forEach((r){ if (null!=r) newList.add(r);});
     if (null != pui && null != pui.myList) {
       scheduleMicrotask((){pui.myList.retainWhere((e)=>e!=null);});
     }
     return newList;
  }
}

/** The puiSortFilter sorts a ng-repeat list according to the sort order of the puiDatatable */
@Formatter(name: 'puiDatatableSortFilter')
class PuiDatatableSortFilter {
  /** AngularDart's orderBy filter sorts a list by a column name (which is given as a String) */
  OrderBy _orderBy;

  /** AngularDart's FilterFilter filters a list according to the values of a given column */
  Filter _contentFilter;

  /** PuiDatatable adds or removes empty row to force the watch watching the collection to fire. This filter prevents the empty rows from being shown. */
  PuiEmptyRowsFilter _emptyRowsFilter;

  Parser _parser;

  PuiDatatableSortFilter(this._parser){
    _orderBy=new OrderBy(_parser);
    _emptyRowsFilter=new PuiEmptyRowsFilter();
    _contentFilter=new Filter(_parser);
  }

  /** PuiFilters aren't bound to a particular component, so every PuiDatatable registers itself to the filter in order to link filters and table */
  static Map<String, PuiDatatableComponent> tables = new Map<String, PuiDatatableComponent>();

  /** PuiFilters aren't bound to a particular component, so every PuiDatatable registers itself to the filter in order to link filters and table */
  static register(String name, PuiDatatableComponent puiDatatableComponent) {
    tables[name]=puiDatatableComponent;
  }

  /** Finds out, which PuiDatatable is to be sorted, finds out, by which column and in which order it is to be sorted and delegates sorting the Angular's OrderByFilter */
  List call(List original, String tableName, [bool descending=false]) {
    PuiDatatableComponent pui = tables[tableName];
    if (pui==null) return original;

    List nonEmptyRows = _emptyRowsFilter.call(original, pui);

    /* The next few lines might benefit from a little explanation.
     *  Basically, the idea is to implement a <pui-datatable> column filter
     *  by using a standard filter of ng-repeat (array | column: "criteria").
     *  The standard filter is the variable FilterFilter.
     *  It takes two parameters when call: the list to be filtered, and the
     *  algorithm filtering a single row. The latter is called a predicate.
     *  The inner loop constructs a predicate that takes the name of the column,
     *  uses AngularDart's parser to get a function that maps an entry of the list
     *  to the value of a particular column of the entry. By calling this mapper function
     *  we get the value, which can be compared by a traditional string method.
     */
    pui.columnHeaders.forEach((Column col ){
      if (col.filterby!=null && col.filterby!="" && col.currentFilter!="") {
        DynamicExpression parsed = _parser(col.filterby);
        var mapper = (e) => parsed.eval(e);
        if (col.filterMatchMode == "contains")
        {
          var predicate = (v) => mapper(v).toString().toLowerCase().contains(col.currentFilter.toLowerCase());
          nonEmptyRows= _contentFilter.call(nonEmptyRows, predicate);
        }
        else if (col.filterMatchMode == "endsWith")
        {
          var predicate = (v) => mapper(v).toString().toLowerCase().endsWith(col.currentFilter.toLowerCase());
          nonEmptyRows= _contentFilter.call(nonEmptyRows, predicate);
        }
        else if (col.filterMatchMode == "exact")
        {
          var predicate = (v) => mapper(v).toString().toLowerCase()== col.currentFilter.toLowerCase();
          nonEmptyRows= _contentFilter.call(nonEmptyRows, predicate);
        }
        else // if (col.filterMatchMode == "startsWith")
        {
          var predicate = (v) => mapper(v).toString().toLowerCase().startsWith(col.currentFilter.toLowerCase());
          nonEmptyRows= _contentFilter.call(nonEmptyRows, predicate);
        }
      }
    });
    /* End of the sophisticated algorithm :) */


    try
    {
      Column firstWhere = pui.columnHeaders.firstWhere((Column c) => c.sortDirection!=0);
      return _orderBy.call(nonEmptyRows, firstWhere.sortBy, firstWhere.sortDirection==2);
    }
    catch (notSortedException)
    {
      if ((pui!=null) && (pui.initialsort!=null))
      {
        bool descending="down"==pui.initialsortorder;
        return _orderBy.call(nonEmptyRows, pui.initialsort, descending);
      }
      return nonEmptyRows;
    }
  }
}

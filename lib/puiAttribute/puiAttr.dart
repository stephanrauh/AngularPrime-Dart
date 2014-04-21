library puiAttributes;

import "package:angular/core/module.dart";

/**
 * When applied as an annotation on a directive field specifies that
 * the field is to be mapped to DOM attribute with the provided [attrName].
 * The value of the attribute to be treated as a string, equivalent
 * to `@` specification.
 * If the value of the attribute looks like a property of a controller, it
 * is surrounded by a mustache ({{ }}) if it is missing.
 *
 */
class PuiAttr extends AttrFieldAnnotation {
  final mappingSpec = '@';
  const PuiAttr(String attrName) : super(attrName);

  String get attrName => addMustache(super.attrName);

  String addMustache(String attrName)
  {
    if (attrName.indexOf("{{") == 0)
      if (attrName.indexOf("\.")>0)
          return "{{$attrName}}";
    return attrName;
  }
}


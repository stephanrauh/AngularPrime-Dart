part of angularprime_dart;

/* Common tasks like converting HTML fragments to partial DOM trees */
class PuiHtmlUtils {
  static NodeValidator nodeValidator=new TolerantNodeValidator();

  /* Converts the HTML fragment to a partial DOM tree */
  static parseResponse(resp) {

    var includedElement = new Element.html(resp, validator:nodeValidator);
    return includedElement;
  }

}

/** By default HTML.element() remove the pui elements, so we need a more tolerant validator */
class TolerantNodeValidator implements NodeValidator
{

  /** allow every attribute */
  @override
  bool allowsAttribute(Element element, String attributeName, String value) {
    return true;
  }

  /** allow every element */
  @override
  bool allowsElement(Element element) {
    return true;
  }
}
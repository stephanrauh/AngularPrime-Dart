AngularPrime-Dart
=================

AngularPrime-Dart is a Dart port of Rudy de Busscher's AngularPrime component library.

<b>Compatibility:</b>
Albeit AngularPrime-Dart is developed in Dart, it also runs in native Javascript (by using Dart's cross-compiler dart2js).

However, currently it *may* not be compatible to Internet Explorer and Firefox. These browsers require a polyfill I have just
started to integrate with AngularPrime-Dart.

Have a look at the <a href="http://showcase.angularfaces.com/AngularPrimeDart/">showcase</a> and the project blog at http://www.beyondjava.net.

The goal of the project is to provide
<ul>
<li>A similar API as the original AngularPrime.</li>
<li>When it's impossible to provide the same API, AngularPrime-Dart strives for an even better API.</li>
<li>A Dart widget library blending seamlessly into the PrimeFaces look and feel</li>
<li>and that's even compatible to the JSF version of PrimeFaces.</li>
<li>Ultimately, AngularPrime-Dart is going to be used as the widget library of AngularFaces (unless technical obstacles arise).</li>
</ul> 

<b>Current state of the art:</b><br />
The project's still in its nascient state. Be prepared for rapid changes of the API (of both AngularDart and AngularPrime-Dart).

<b>Components implemented so far</b>
Structural components:
<table>
<tr><td>&lt;pui-panel&gt;</td><td>finished except shrink and grow effects</td></tr>
<tr><td>&lt;pui-accordion&gt;</td><td>finished except shrink and grow effects and collapsing of the other accordion ribs after activating a rib</td></tr>
<tr><td>&lt;pui-tabview&gt;</td><td>finished except vertically orientated tabs</td></tr>
<tr><td>&lt;pui-datatable&gt;</td><td>50% finished / work in progress</td></tr>
<tr><td>&lt;pui-include&gt;</td><td>finished</td></tr>
</table>

Components dealing with input:
<table>
<tr><td>&lt;pui-input&gt;</td><td> finished except "disabled" attribute</td></tr>
<tr><td>&lt;pui-button&gt;</td><td>finished</td></tr>
<tr><td>&lt;pui-checkbox&gt;</td><td>finished</td></tr>
<tr><td>&lt;pui-textarea&gt;</td><td>50% finished</td></tr>
<tr><td>&lt;pui-dropdown&gt;</td><td>finished except keyboard support of non-editable drop drop menus</td></tr>
<tr><td>&lt;pui-radiobutton&gt;</td><td></td></tr>
</table>
AngularPrime-Dart
=================

AngularPrime-Dart is a Dart port of Rudy de Busscher's AngularPrime component library.

<b>See it in action:</b><br />
Have a look at the <a href="http://showcase.angularfaces.com/AngularPrimeDart/">showcase</a> and the project blog at http://www.beyondjava.net.
As for the showcase: there are some compatibility issues, so currently it doesn't work at all and in general
it's a good idea to view it with the <a href="https://www.dartlang.org/tools/dartium/">Dartium browser</a>.<br>
Please apologize this temporary problem.

<b>Compatibility:</b><br />
Albeit AngularPrime-Dart is developed in Dart, it also runs in native Javascript (by using Dart's cross-compiler dart2js).

However, currently it isn't fully compatible to Javascript. There are a couple of compatibility issues
I haven't started to track down yet. For instance, the buttons in the datatable demos cause infinite loops.
BTW: If you want to participate in the project, hunting those bugs is a good starting point. Every help is welcome!


The goal of the project is to provide
<ul>
<li>A similar API as the original AngularPrime.</li>
<li>When it's impossible to provide the same API, AngularPrime-Dart strives for an even better API.</li>
<li>A Dart widget library blending seamlessly into the PrimeFaces look and feel</li>
<li>and that's even compatible to the JSF version of PrimeFaces.</li>
<li>Ultimately, AngularPrime-Dart is going to be used as the widget library of AngularFaces 2.0 (unless technical obstacles arise).</li>
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
<tr><td>&lt;pui-include&gt;</td><td>finished<br>does more or less the same as ng-include, but it includes the file before initializing AngularDart</td></tr>
<tr><td>&lt;pui-grid&gt;</td><td>finished<br>A grid component simplifying typical business input masks tremendously</td></tr>
<tr><td>&lt;pui-bind-html&gt;</td><td>finished<br>A very liberal version of &lt;ng-bind-html&gt; (the difference to &lt;ng-bind-html&gt; is &lt;pui-bind-html&gt; omits sanitizing of the HTML code, so use it with care)</td></tr>

</table>

Components dealing with input:
<table>
<tr><td>&lt;pui-input&gt;</td><td>90% finished ("disabled" attribute and labels need some polishing)</td></tr>
<tr><td>&lt;pui-week&gt;</td><td>finished (requires an HTML 5 browser)</td></tr>
<tr><td>&lt;pui-color&gt;</td><td>finished (requires an HTML5 brwoser)<br>a color-picker component</td></tr>
<tr><td>&lt;pui-calendar&gt;</td><td>coming soon</td></tr>
<tr><td>&lt;pui-time&gt;</td><td>coming soon</td></tr>
<tr><td>&lt;pui-button&gt;</td><td>finished</td></tr>
<tr><td>&lt;pui-button&gt;</td><td>finished</td></tr>
<tr><td>&lt;pui-checkbox&gt;</td><td>finished</td></tr>
<tr><td>&lt;pui-textarea&gt;</td><td>50% finished</td></tr>
<tr><td>&lt;pui-dropdown&gt;</td><td>finished except keyboard support of non-editable drop drop menus</td></tr>
<tr><td>&lt;pui-radiobutton&gt;</td><td>coming soon</td></tr>
<tr><td>&lt;pui-growl&gt;</td><td>coming soon</td></tr>
</table>

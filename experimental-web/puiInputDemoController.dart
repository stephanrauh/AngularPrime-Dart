import 'package:angular/angular.dart';

@NgController(
    selector: '[puiInputDemo]',
    publishAs: 'ctrl')
class PuiInputDemoController {

  String firstField = "first model value";
  String secondField = "second model value";
  String thirdField = "third model value";
}

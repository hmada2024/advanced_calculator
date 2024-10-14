import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {
  var output = '0'.obs;

  void buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      output.value = '0';
    } else if (buttonText == "=") {
      try {
        Parser parser = Parser();
        Expression exp = parser.parse(output.value);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        output.value = eval.toString();
      } catch (e) {
        output.value = "Error";
      }
    } else {
      if (output.value == "0") {
        output.value = buttonText;
      } else {
        output.value += buttonText;
      }
    }
  }
}

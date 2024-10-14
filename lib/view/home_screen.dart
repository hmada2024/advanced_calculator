import 'package:advanced_calculator/controller/calculator_cotroller.dart';
import 'package:advanced_calculator/view/advanced_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/theme_controller.dart';
import '../widget/calculator_button.dart';

class HomeScreen extends StatelessWidget {
  final CalculatorController calculatorController = Get.put(CalculatorController());
  final ThemeController themeController = Get.put(ThemeController());

   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final buttonHeight = mediaQuery.size.height * 0.1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Calculator'),
        actions: [
          IconButton(
            icon: Obx(() => Icon(
              themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
            )),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
            IconButton(
    icon: const Icon(Icons.calculate),
    onPressed: () {
      Get.to(() => AdvancedScreen());
    },
  ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Obx(() => Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                calculatorController.output.value,
                key: ValueKey<String>(calculatorController.output.value),
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              buildButtonRow(["7", "8", "9", "/"], buttonHeight),
              buildButtonRow(["4", "5", "6", "*"], buttonHeight),
              buildButtonRow(["1", "2", "3", "-"], buttonHeight),
              buildButtonRow([".", "0", "00", "+"], buttonHeight),
              buildButtonRow(["CLEAR", "="], buttonHeight),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons, double height) {
    return Row(
      children: buttons.map((buttonText) => CalculatorButton(
        buttonText, height, (text) {
          calculatorController.buttonPressed(text);
        }
      )).toList(),
    );
  }
}

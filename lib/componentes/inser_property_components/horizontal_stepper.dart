import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/inser_property_components/step_one.dart';
import 'package:space_imoveis/componentes/inser_property_components/step_three.dart';
import 'package:space_imoveis/componentes/inser_property_components/step_two.dart';
import 'package:space_imoveis/pages/AppPages/insert_property/insert_property_controller.dart';

class MyStepper extends StatelessWidget {
  final int steps;

  final InsertPropertyController controller = Get.find();

  MyStepper({
    this.steps = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(steps * 2 - 1, (index) {
            if (index % 2 == 1) {
              return Container(
                width: 20, // Largura do Divider
                child: Divider(
                  color: controller.myGlobalController.color,
                  thickness: 0.5, // Espessura do Divider
                ),
              );
            } else {
              int stepIndex = index ~/ 2;
              return GestureDetector(
                onTap: () {
                },
                child: Obx(() {
                  bool isActive = controller.currentStep.value == stepIndex;
                  return Column(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? controller.myGlobalController.color : const Color.fromARGB(255, 204, 204, 204),
                        ),
                        child: Center(
                          child: Text(
                            '${stepIndex + 1}',
                            style: TextStyle(
                              color: isActive ? const Color.fromRGBO(255, 255, 255, 1) : const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w300,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4), // Espaço entre o círculo e a label
                      Text(
                        _getStepLabel(stepIndex), // Label para cada step
                        style: TextStyle(
                          color: isActive ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  );
                }),
              );
            }
          }),
        ),
        const SizedBox(height: 20), // Espaço entre o Stepper e o conteúdo
        Obx(() {
          int currentStep = controller.currentStep.value;
          Widget content;
          switch (currentStep) {
            case 0:
              content = StepOne();
              break;
            case 1:
              content = StepTwo();
              break;
            case 2:
              content = StepThree();
              break;
            default:
              content = Text('Conteúdo não definido para este step');
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: content,
          );
        }),
      ],
    );
  }

  String _getStepLabel(int index) {
    switch (index) {
      case 0:
        return 'Dados';
      case 1:
        return 'Descrição';
      default:
        return 'Anunciar';
    }
  }
}

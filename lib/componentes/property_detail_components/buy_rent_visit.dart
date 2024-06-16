import 'package:flutter/material.dart';

class BuyRentVisit extends StatelessWidget {
  final VoidCallback onPressed;
  var  advertiserData;

  BuyRentVisit({
    Key? key,
    required this.onPressed,
    required this.advertiserData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Icon(Icons.door_sliding),
            ),
            SizedBox(width: 5),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color.fromARGB(255, 0, 0, 0), // Cor da borda
                    width: 0.5, // Largura da borda
                  ),
                ),
              ),
              child: Text(
                'Agendar uma visita',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Arredondamento dos cantos
            ),
          ),
          onPressed: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(107, 203, 194, 18),
                  Color.fromARGB(255, 203, 194, 18),
                  Color.fromARGB(255, 237, 161, 8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10), // Arredondamento dos cantos
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              constraints: BoxConstraints(
                minHeight: 40, // Altura mínima
                minWidth: 100, // Largura mínima
              ),
              child: Text(
                'Comprar/alugar agora',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                  fontSize: 11

                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

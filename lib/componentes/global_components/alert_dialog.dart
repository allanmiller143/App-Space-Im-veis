import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onSend;

  const MyAlertDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,10,8,0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  height: 1.2
                ),
                
              ),
            )
          ),
          IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            }, 
            icon: const Icon(Icons.close,))
        ]
      
      ),
      titlePadding: EdgeInsets.fromLTRB(15,5,5,0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(subtitle),
          const SizedBox(height: 10),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fecha o diálogo
          },
          child: const Text('Cancelar', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        ),
        TextButton(
          onPressed: () {
            onSend(); // Chama a função passada como parâmetro
          },
          child: const Text('Continuar', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        ),
      ],
    );
  }
}

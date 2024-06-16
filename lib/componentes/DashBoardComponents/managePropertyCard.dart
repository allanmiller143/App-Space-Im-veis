import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ManagePropertyCardController extends GetxController {
  var isExpanded = false.obs;

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }

  String formatNumber(dynamic number) {
    if (number == null) return 'N/A';
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(number);
  } 
}

// Defina a classe do cartão da propriedade
class ManagePropertyCard extends StatelessWidget {
  var property;

  ManagePropertyCard({
    required this.property,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Cada card terá seu próprio controlador
    final ManagePropertyCardController controller = Get.put(ManagePropertyCardController(), tag: property['id']);
    return GestureDetector(
      onTap: controller.toggleExpand,

      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.fromLTRB(0,0,0,5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: const Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 221, 221, 221).withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children:[ 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: 50,
                            height: 50,
                            child: property['pictures'] != null
                              ? Image.network(
                                  property['pictures'][0]['url'],
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/imgs/corretor.jpg',
                                  fit: BoxFit.cover,
                              ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(property['property_type'], style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12,fontWeight: FontWeight.w400)),
                              Text(
                                  '${property['address']}-${property['house_number']}, ${property['city']} - ${property['state']}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 9,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w300
                                  ),
                                  maxLines: 2,
                                )
                            ],
                          ),
                        ), 
                        SizedBox(width: 10), 
                        Container(
                            height: 45,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (property['is_highlighted'] == false && property['is_published'] == false) ?
                                    'Arquivado':
                                    (property['is_highlighted'] == true && property['is_published'] == false) ?
                                    'Destaques' : 'Populares',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400
                                    )
                                  ),
                                  Text(
                                    'Em análise',
                                    style: TextStyle(
                                      color: Color.fromARGB(194, 127, 9, 9),
                                      fontSize: 8,
                                    )
                                  ),
                                ],
                              )
                            ),
                          ),
                      ],
                    ),
                  ),
                  Obx(() => AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.isExpanded.value) ...[
                          // Adicione as informações estáticas aqui antes de expandir
                          SizedBox(height: 10),
                          Text('Outros detalhes da propriedade', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                          Text(property['description'], style: TextStyle(fontSize: 9)),
                          Text(property['sell_price'] != null ? 'Preço de venda R\$ ${controller.formatNumber(property['sell_price'])}' : '', style: TextStyle(fontSize: 9)),
                          Text(property['rent_price'] != null ? 'Preço de Aluguel R\$ ${controller.formatNumber(property['rent_price'])}/mês' : '', style: TextStyle(fontSize: 9)),
                          property['property_type'] == 'Terreno' ? SizedBox() :
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.bed_outlined, size: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                                  SizedBox(width: 2),
                                  Text(
                                    property['bedrooms'].toString(),
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(width: 5),
                              Row(
                                children: [
                                  Icon(Icons.shower_outlined, size: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                                  SizedBox(width: 2),
                                  Text(
                                    property['bathrooms'].toString(),
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(width: 5),
                              Row(
                                children: [
                                  Icon(Icons.garage_outlined, size: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                                  SizedBox(width: 2),
                                  Text(
                                    property['parking_spaces'].toString(),
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 0.3,
                            color: Color.fromARGB(255, 65, 106, 110),
                          ),
                          Text('Ações', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tb('Editar Imóvel', (){ print('porra');}),
                              tb('Arquivar Imóvel', (){ print('porra');}),
                              tb('Excluir Imóvel', (){ print('porra');}, color: Color.fromARGB(255, 154, 51, 22)),
                            
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tb('Editar Imóvel', (){ print('porra');}),
                              tb('Excluir Imóvel', (){ print('porra');}),
                              tb('Arquivar Imóvel', (){ print('porra');}),
                            ],
                          ),
                          SizedBox(height: 5),
                    
                          
                        ],
                      ],
                    ),
                  )),
                ],
              ),

              Container(
                height: 53,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Icon(Icons.arrow_drop_down, size: 15, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
                
            ]
          ),
        
      ),
    );
  }
}

Widget tb(String title,VoidCallback onTap, {Color color = const  Color.fromARGB(255, 65, 106, 110),}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 10
        ),
      ),
    ),
  );
}
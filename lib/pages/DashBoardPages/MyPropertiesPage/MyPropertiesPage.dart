import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:space_imoveis/componentes/DashBoardComponents/manageFilters.dart';
import 'package:space_imoveis/componentes/DashBoardComponents/managePropertyCard.dart';
import 'package:space_imoveis/componentes/inser_property_components/mandatory.dart';
import 'package:space_imoveis/pages/DashBoardPages/MyPropertiesPage/MyPropertiesPageController.dart';

class MyPropertiesPage extends StatelessWidget {
  MyPropertiesPage({Key? key}) : super(key: key);
  final controller = Get.put(MyPropertiesPageController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 9, 47, 70),
      body: FutureBuilder(
        future: controller.init(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          ManageFilter(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Column(
                        children: [
                          MandatoryOptional(
                            text: 'Seus imóveis',
                            subtext: controller.totalItens.value.toString(),
                            subtext2: '',
                          ),
                          Obx(() {
                            if (controller.loading.value) {
                              return Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    return Shimmer.fromColors(
                                      baseColor: Color.fromARGB(255, 223, 223, 223),
                                      highlightColor: Color.fromARGB(255, 192, 192, 192),
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else if (controller.myProperties.isEmpty) {
                              return Expanded(
                                child: Center(
                                  child: Text('Nenhuma propriedade encontrada.'),
                                ),
                              );
                            } else {
                              return Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: controller.myProperties.length,
                                  itemBuilder: (context, index) {
                                    final property = controller.myProperties[index];
                                    return ManagePropertyCard(property: property);
                                  },
                                ),
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    int totalPages = (controller.totalItens / 6).ceil();
                    int initialPage = controller.currentPage.value;
                    
                    // Garantir que initialPage nunca exceda totalPages - 1 e não seja negativo
                    initialPage = initialPage.clamp(0, totalPages > 0 ? totalPages - 1 : 0);

                    // Se não houver itens, não renderizar o paginador
                    if (totalPages <= 1) {
                      return SizedBox.shrink();
                    }

                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                      child: NumberPaginator(
                        initialPage: initialPage,
                        numberPages: totalPages,
                        onPageChange: (int index) {
                          controller.currentPage.value = index;
                          controller.getUserProperties(context);
                          scrollController.animateTo(
                            0, // Scroll to top when page changes
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        showNextButton: true,
                        showPrevButton: true,
                        config: NumberPaginatorUIConfig(
                          buttonSelectedBackgroundColor: const Color.fromARGB(255, 168, 192, 211),
                          buttonUnselectedForegroundColor: const Color.fromARGB(255, 0, 0, 0),
                          buttonUnselectedBackgroundColor: Colors.white,
                          buttonSelectedForegroundColor: Colors.white,
                          buttonPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          buttonShape: CircleBorder(),
                          height: 35,
                          buttonTextStyle: TextStyle(fontSize: 10),
                        ),
                      ),
                    );
                  }),
                ],
              );
            } else {
              return Center(child: const Text('Ocorreu um erro inesperado'));
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 253, 72, 0),
              ),
            );
          }
        },
      ),
    );
  }
}

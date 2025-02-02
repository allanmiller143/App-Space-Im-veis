import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/home_carousel_slider/card.dart';
import 'package:space_imoveis/componentes/global_components/home_carousel_slider/controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:space_imoveis/componentes/global_components/home_carousel_slider/loading_card.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';



class PropertyCarousel extends StatelessWidget {
  final List<dynamic> properties;
  final MyGlobalController globalController;

  const PropertyCarousel({required this.properties, required this.globalController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: properties.length,
      itemBuilder: (context, index, realIdx) {
        var property = properties[index];
        globalController.userFavorites.contains(property['id']);
        return PropertyCard(property: property);
      },
      options: CarouselOptions(
        height: 260, // Adjust the height to control the size of the cards
        enlargeCenterPage: true,
        autoPlay: false,
        aspectRatio: 16 / 12,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 1000),
        viewportFraction: 0.6, // Adjust the viewport fraction to control spacing and size
        disableCenter: true,
      ),
    );
  }
}





class PropertyLoadingCarousel extends StatelessWidget {
  const PropertyLoadingCarousel({ Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 0,
      itemBuilder: (context, index, realIdx) {
        return PropertyLoadingCard();
      },
      options: CarouselOptions(
        height: 260,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 1000),
        viewportFraction: 0.6,
        disableCenter: true,

      ),
    );
  }
}



class PropertyList extends StatelessWidget {
  final PropertyController controller = Get.put(PropertyController());
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Center(
                child: Text(
                  'Destaques',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            controller.isLoading.value ? 
            PropertyLoadingCarousel() 
            :
            PropertyCarousel(properties: controller.properties, globalController: controller.myGlobalController),
            SizedBox(height: 8),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed('all_highligthed_property');
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25,5,25,5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(width: 0.5)
                      ),
                      child: Text('Ver mais', style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 10),),
                    )
                  ),
                  SizedBox(width: 15), // Espaço entre os botões
                  GestureDetector(
                    onTap: (){
                      Get.toNamed('insert_property');
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25,5,25,5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: controller.myGlobalController.color,
                      ),
                      child: Text('Anunciar', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 10),),
                    )
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}
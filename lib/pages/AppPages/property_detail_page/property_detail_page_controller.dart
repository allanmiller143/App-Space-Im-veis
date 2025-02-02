// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, unused_catch_clause

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';

class PropertyDetailController extends GetxController {
  late MyGlobalController myGlobalController;
  final String propertyId = Get.parameters['id']!;
  late var property = {};

  @override
  void onInit()async {   
    myGlobalController = Get.find();
    super.onInit();
  }

  String formatNumber(dynamic number) {
    if (number == null) return 'N/A'; // Verifica se o número é nulo
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(number);
  }

  init() async {
    try{
      var response = await get('properties/$propertyId');
      if(response['status'] == 200 || response['status'] == 201){
        property = response['data'];
      }else{
        print('deu ruim');
      }
    }catch(e){
      print('caiu no catch');
    }
    return true;
  }

}

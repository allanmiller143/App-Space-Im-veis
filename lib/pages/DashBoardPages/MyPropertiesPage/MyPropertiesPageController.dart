import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';

class MyPropertiesPageController extends GetxController {
  var myProperties = [].obs;
  var totalItens = 0.obs;
  var currentPage = 0.obs;
  RxBool loading = false.obs;
  RxString state = ''.obs;
  RxString advertsType = ''.obs;
  RxString status = ''.obs;
  RxString city = ''.obs;
  RxString shared = ''.obs;
  var isExpanded = false.obs;
  var StateList = ['AM', 'AC', 'AL', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO'];
  var AdvertsTypeList =  ['Venda','Aluguel','Ambas'];
  var StatusList = ['Arquivado','Populares','Destaques'];
  var CityList = ['Recife','Araguaia','Aveiro','Beja','Braga','Braganca','Castelo Branco','Coimbra','Estarreja','Faro','Guarda','Leiria','Lisboa','Portalegre','Porto','Santarem','Setubal','Sines','Viseu'];
  late MyGlobalController myGlobalController;
  @override
  void onInit() {
    super.onInit();
    myGlobalController = Get.find();
  }

  init(context) async {
    // Aqui você pode buscar os dados das propriedades de uma API ou de uma fonte de dados local
     myGlobalController = Get.find();
    await getUserProperties(context);
    return true;
  }


getUserProperties(context) async {
  MyGlobalController mgc = Get.find();
  var formJson = {
    'allProperties': true,
    'email': mgc.userInfo['email'],
    'announcementType': advertsType.value,
    'state': state.value,
  };

  if (status.value.isNotEmpty) {
    formJson['allProperties'] = false;
  }

  bool h = false;
  bool p = false;

  if (status.value == 'Arquivado') {
    h = false;
    p = false;
  } else if (status.value == 'Populares') {
    h = false;
    p = true;
  } else if (status.value == 'Destaques') {
    h = true;
    p = true;
  }

  if (!formJson['allProperties'] && h) {
    formJson.addAll({'onlyHighlighted': true});
  } else if (!formJson['allProperties'] && p) {
    formJson.addAll({'onlyPublished': true});
  }

  if (city.value.isNotEmpty) {
    formJson.addAll({'city': city.value});
  }
  if (shared.value.isNotEmpty) {
    formJson.addAll({'shared': shared.value});
  }
  if (advertsType.value == 'Ambas') {
    formJson['announcementType'] = '';
  }

  formJson.forEach(
    (key, value) => print('$key: $value'),
  );

  loading.value = true;

  try {
    var response = await put('properties/filter?page=${currentPage.value + 1}', formJson);
    if (response['status'] == 200) {
      myProperties.value = response['data']['properties'];
      totalItens.value = response['data']['pagination']['total'];
      loading.value = false;
    } else {
      print('Erro ao buscar as propriedades: ${response['message']}');
    }
  } catch (e) {
    print('Erro ao buscar as propriedades: $e');
    loading.value = false;
  }
}


  cleanFilters() async{
    state.value = '';
    city.value = '';
    shared.value = '';
    advertsType.value = '';
    status.value = '';
    isExpanded.value = false;
    await getUserProperties(Get.context!);
  }
}


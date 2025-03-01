import 'package:geapp/app/models/select_object.dart';

class SaleFormConstants {
  static List<SelectObject> paymentStatus = [
    SelectObject(key: 1, value: "A Receber"),
    SelectObject(key: 2, value: "Aguardando Cliente"),
    SelectObject(key: 3, value: "Reservado"),
    SelectObject(key: 4, value: "Pago"),
    SelectObject(key: 5, value: "Concluído"),
    SelectObject(key: 6, value: "Cancelado"),
  ];

  static List<SelectObject> paymentMethods = [
    SelectObject(key: 1, value: "Pix"),
    SelectObject(key: 2, value: "Dinheiro"),
    SelectObject(key: 3, value: "Cartão de Crédito"),
    SelectObject(key: 4, value: "Cartão de Débito"),
    SelectObject(key: 5, value: "Boleto Bancário"),
    SelectObject(key: 6, value: "Outros"),
  ];

  static List<SelectObject> paymentConditions = [
    SelectObject(key: 1, value: "A Vista"),
    SelectObject(key: 2, value: "30 Dias"),
    SelectObject(key: 3, value: "30/60 Dias"),
    SelectObject(key: 4, value: "30/60/90 Dias"),
    SelectObject(key: 5, value: "Parcelamento Personalizado"),
  ];
}

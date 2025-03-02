import 'dart:convert';

import 'package:uuid/uuid.dart';

class CustomerModel {
  int? id;
  bool? isLegal;
  String? code;
  String? cpf;
  String? cnpj;
  String? name;
  String? phone;
  String? email;
  String? fantasy;
  String? contact;
  String? inscription;
  String? addressUF;
  String? addressCity;
  String? addressName;
  String? addressNumber;
  String? addressZipCode;
  String? addressComplement;
  String? addressNeighborhood;
  String createdAt;
  String updatedAt;

  CustomerModel({
    this.id,
    this.isLegal = false,
    this.code,
    this.cpf,
    this.cnpj,
    this.name,
    this.phone,
    this.email,
    this.fantasy,
    this.contact,
    this.inscription,
    this.addressUF,
    this.addressCity,
    this.addressName,
    this.addressNumber,
    this.addressZipCode,
    this.addressComplement,
    this.addressNeighborhood,
    String? createdAt,
    String? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String(),
       updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  CustomerModel copyWith({
    int? id,
    bool? isLegal,
    String? code,
    String? cpf,
    String? cnpj,
    String? name,
    String? phone,
    String? email,
    String? fantasy,
    String? contact,
    String? inscription,
    String? addressUF,
    String? addressCity,
    String? addressName,
    String? addressNumber,
    String? addressZipCode,
    String? addressComplement,
    String? addressNeighborhood,
    String? createdAt,
    String? updatedAt,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      isLegal: isLegal ?? this.isLegal,
      code: code ?? this.code,
      cpf: cpf ?? this.cpf,
      cnpj: cnpj ?? this.cnpj,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      fantasy: fantasy ?? this.fantasy,
      contact: contact ?? this.contact,
      inscription: inscription ?? this.inscription,
      addressUF: addressUF ?? this.addressUF,
      addressCity: addressCity ?? this.addressCity,
      addressName: addressName ?? this.addressName,
      addressNumber: addressNumber ?? this.addressNumber,
      addressZipCode: addressZipCode ?? this.addressZipCode,
      addressComplement: addressComplement ?? this.addressComplement,
      addressNeighborhood: addressNeighborhood ?? this.addressNeighborhood,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    var uuid = const Uuid();
    String uniqueCode = code ?? uuid.v4();

    return <String, dynamic>{
      'isLegal': isLegal == true ? 1 : 2,
      'code': uniqueCode,
      'cpf': cpf,
      'cnpj': cnpj,
      'name': name,
      'phone': phone,
      'email': email,
      'fantasy': fantasy,
      'contact': contact,
      'inscription': inscription,
      'addressUF': addressUF,
      'addressCity': addressCity,
      'addressName': addressName,
      'addressNumber': addressNumber,
      'addressZipCode': addressZipCode,
      'addressComplement': addressComplement,
      'addressNeighborhood': addressNeighborhood,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] != null ? map['id'] as int : null,
      isLegal:
          map['isLegal'] != null
              ? map['isLegal'] == 1
                  ? true
                  : false
              : null,
      code: map['code'] != null ? map['code'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      cnpj: map['cnpj'] != null ? map['cnpj'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      fantasy: map['fantasy'] != null ? map['fantasy'] as String : null,
      contact: map['contact'] != null ? map['contact'] as String : null,
      inscription:
          map['inscription'] != null ? map['inscription'] as String : null,
      addressUF: map['addressUF'] != null ? map['addressUF'] as String : null,
      addressCity:
          map['addressCity'] != null ? map['addressCity'] as String : null,
      addressName:
          map['addressName'] != null ? map['addressName'] as String : null,
      addressNumber:
          map['addressNumber'] != null ? map['addressNumber'] as String : null,
      addressZipCode:
          map['addressZipCode'] != null
              ? map['addressZipCode'] as String
              : null,
      addressComplement:
          map['addressComplement'] != null
              ? map['addressComplement'] as String
              : null,
      addressNeighborhood:
          map['addressNeighborhood'] != null
              ? map['addressNeighborhood'] as String
              : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerModel(id: $id, isLegal: $isLegal, code: $code, cpf: $cpf, cnpj: $cnpj, name: $name, phone: $phone, email: $email, fantasy: $fantasy, contact: $contact, inscription: $inscription, addressUF: $addressUF, addressCity: $addressCity, addressName: $addressName, addressNumber: $addressNumber, addressZipCode: $addressZipCode, addressComplement: $addressComplement, addressNeighborhood: $addressNeighborhood, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant CustomerModel other) {
    if (identical(this, other)) return true;

    return other.isLegal == isLegal &&
        other.id == id &&
        other.code == code &&
        other.cpf == cpf &&
        other.cnpj == cnpj &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.fantasy == fantasy &&
        other.contact == contact &&
        other.inscription == inscription &&
        other.addressUF == addressUF &&
        other.addressCity == addressCity &&
        other.addressName == addressName &&
        other.addressNumber == addressNumber &&
        other.addressZipCode == addressZipCode &&
        other.addressComplement == addressComplement &&
        other.addressNeighborhood == addressNeighborhood &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return isLegal.hashCode ^
        id.hashCode ^
        code.hashCode ^
        cpf.hashCode ^
        cnpj.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        fantasy.hashCode ^
        contact.hashCode ^
        inscription.hashCode ^
        addressUF.hashCode ^
        addressCity.hashCode ^
        addressName.hashCode ^
        addressNumber.hashCode ^
        addressZipCode.hashCode ^
        addressComplement.hashCode ^
        addressNeighborhood.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

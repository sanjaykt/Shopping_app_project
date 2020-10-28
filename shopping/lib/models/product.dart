import 'dart:io';

class Product {
  int id;
  String productName;
  String productDetails;
  String productBrand;
  String productBarcode;
  String imageUrl;
  File image;
  int createdByUserId;
  int modifiedByUserId;
  DateTime createdDate;
  DateTime modifiedDate;
  int statusId;

  Product();

  clone() => Product.fromJson(toJson());

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productName = json['productName'],
        productDetails = json['productDetails'],
        productBrand = json['productBrand'],
        productBarcode = json['productBarcode'],
        imageUrl = json['imageUrl'],
        createdByUserId = json['createdByUserId'],
        modifiedByUserId = json['modifiedByUserId'],
        createdDate = (json['createdDate'] != null
            ? DateTime.parse(json['createdDate'])
            : null),
        modifiedDate = (json['modifiedDate'] != null
            ? DateTime.parse(json['modifiedDate'])
            : null),
        statusId = json['statusId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'productDetails': productDetails,
        'productBrand ': productBrand,
        'productBarcode': productBarcode,
        'imageUrl': imageUrl,
        if (createdDate != null) 'createdDate': createdDate.toString(),
        if (modifiedDate != null) 'modifiedDate': modifiedDate.toString(),
        'createdByUserId': createdByUserId,
        'modifiedByUserId': modifiedByUserId,
        if (statusId != null) 'statusId': statusId,
      };
}

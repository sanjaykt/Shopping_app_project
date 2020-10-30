import 'dart:io';

class Item {
  int id;
  int productId;
  int quantity;
  double price;
  double total;
  int createdByUserId;
  int modifiedByUserId;
  DateTime createdDate;
  DateTime modifiedDate;
  int statusId;

  Item();

  clone() => Item.fromJson(toJson());

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productId = json['productId'],
        quantity = json['quantity'],
        price = json['price'],
        total = json['total'] != null ? json['total'].toDouble() : null,
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
        'productId': productId,
        'quantity': quantity,
        'price': price,
        'total ': total,
        if (createdDate != null) 'createdDate': createdDate.toString(),
        if (modifiedDate != null) 'modifiedDate': modifiedDate.toString(),
        'createdByUserId': createdByUserId,
        'modifiedByUserId': modifiedByUserId,
        if (statusId != null) 'statusId': statusId,
      };
}

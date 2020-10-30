import 'dart:io';

class Order {
  int id;
  int itemId;
  int userId;
  int cartId;
  double total;
  int createdByUserId;
  int modifiedByUserId;
  DateTime createdDate;
  DateTime modifiedDate;
  int statusId;

  Order();

  clone() => Order.fromJson(toJson());

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        itemId = json['itemId'],
        userId = json['userId'],
        cartId = json['cartId'],
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
        'itemId': itemId,
        'userId': userId,
        'cartId ': cartId,
        'total': total,
        if (createdDate != null) 'createdDate': createdDate.toString(),
        if (modifiedDate != null) 'modifiedDate': modifiedDate.toString(),
        'createdByUserId': createdByUserId,
        'modifiedByUserId': modifiedByUserId,
        if (statusId != null) 'statusId': statusId,
      };
}

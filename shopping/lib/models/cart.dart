import 'dart:io';

class Cart {
  int id;
  int itemId;
  int userId;
  int total;
  int createdByUserId;
  int modifiedByUserId;
  DateTime createdDate;
  DateTime modifiedDate;
  int statusId;

  Cart();

  clone() => Cart.fromJson(toJson());

  Cart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        itemId = json['itemId'],
        userId = json['userId'],
        total = json['total'],
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
        'total ': total,
        if (createdDate != null) 'createdDate': createdDate.toString(),
        if (modifiedDate != null) 'modifiedDate': modifiedDate.toString(),
        'createdByUserId': createdByUserId,
        'modifiedByUserId': modifiedByUserId,
        if (statusId != null) 'statusId': statusId,
      };
}

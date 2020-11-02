class Address {
  int id;
  String addressLine1;
  String addressLine2;
  int pinCode;
  Map<String, dynamic> latLng; //TODO: next feature
  int createdByUserId;
  int modifiedByUserId;
  DateTime createdDate;
  DateTime modifiedDate;
  int statusId;

  Address();

  clone() => Address.fromJson(toJson());

  Address.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        addressLine1 = json['addressLine1'],
        addressLine2 = json['addressLine2'],
        pinCode = json['pinCode'],
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
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'pinCode ': pinCode,
        if (createdDate != null) 'createdDate': createdDate.toString(),
        if (modifiedDate != null) 'modifiedDate': modifiedDate.toString(),
        'createdByUserId': createdByUserId,
        'modifiedByUserId': modifiedByUserId,
        if (statusId != null) 'statusId': statusId,
      };
}

class test {
  int? code;
  String? msg;
  List<Data>? data;

  test({this.code, this.msg, this.data});

  test.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Data {
  dynamic id;
  dynamic remark;
  dynamic createdBy;
  dynamic createdAt;
  dynamic updatedBy;
  dynamic updatedAt;
  dynamic delFlag;
  dynamic belongCustomerId;
  dynamic appCode;
  String? agreementName;
  String? functionCode;
  dynamic richTextId;
  String? richTextContent;
  dynamic updateBy;

  Data(
      {this.id,
      this.remark,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.delFlag,
      this.belongCustomerId,
      this.appCode,
      this.agreementName,
      this.functionCode,
      this.richTextId,
      this.richTextContent,
      this.updateBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remark = json['remark'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedBy = json['updatedBy'];
    updatedAt = json['updatedAt'];
    delFlag = json['delFlag'];
    belongCustomerId = json['belongCustomerId'];
    appCode = json['appCode'];
    agreementName = json['agreementName'];
    functionCode = json['functionCode'];
    richTextId = json['richTextId'];
    richTextContent = json['richTextContent'];
    updateBy = json['updateBy'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['remark'] = remark;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['updatedBy'] = updatedBy;
    data['updatedAt'] = updatedAt;
    data['delFlag'] = delFlag;
    data['belongCustomerId'] = belongCustomerId;
    data['appCode'] = appCode;
    data['agreementName'] = agreementName;
    data['functionCode'] = functionCode;
    data['richTextId'] = richTextId;
    data['richTextContent'] = richTextContent;
    data['updateBy'] = updateBy;
    return data;
  }
}

class CreateInvoiceResponse {
  bool? ok;
  String? result;

  CreateInvoiceResponse({this.ok, this.result});

  CreateInvoiceResponse.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ok'] = ok;
    data['result'] = result;
    return data;
  }
}

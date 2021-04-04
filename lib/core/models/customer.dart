import 'package:json_annotation/json_annotation.dart';
part 'customer.g.dart';

@JsonSerializable()
class Customer {
  final String CustomerUID;
  final String Name;
  final String CustomerType;
  final String DisplayName;
  final List<Customer> Children;
  Customer(
      {this.CustomerUID,
      this.Name,
      this.CustomerType,
      this.Children,
      this.DisplayName});

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

List<Customer> customerList = [
  Customer(
      CustomerUID: "",
      Name: "L&T CONSTRUCTION EQUIPMENT LTD",
      CustomerType: "Dealer",
      DisplayName: "L&T CONSTRUCTION EQUIPMENT LTD",
      Children: []),
  Customer(
      CustomerUID: "",
      Name: "L&T CONSTRUCTION EQUIPMENT LTD",
      CustomerType: "Dealer",
      DisplayName: "L&T CONSTRUCTION EQUIPMENT LTD",
      Children: []),
  Customer(
      CustomerUID: "",
      Name: "L&T CONSTRUCTION EQUIPMENT LTD",
      CustomerType: "Dealer",
      DisplayName: "L&T CONSTRUCTION EQUIPMENT LTD",
      Children: []),
  Customer(
      CustomerUID: "",
      Name: "L&T CONSTRUCTION EQUIPMENT LTD",
      CustomerType: "Dealer",
      DisplayName: "L&T CONSTRUCTION EQUIPMENT LTD",
      Children: []),
  Customer(
      CustomerUID: "",
      Name: "L&T CONSTRUCTION EQUIPMENT LTD",
      CustomerType: "Dealer",
      DisplayName: "L&T CONSTRUCTION EQUIPMENT LTD",
      Children: []),
  Customer(
      CustomerUID: "",
      Name: "L&T CONSTRUCTION EQUIPMENT LTD",
      CustomerType: "Dealer",
      DisplayName: "L&T CONSTRUCTION EQUIPMENT LTD",
      Children: []),
];

@JsonSerializable()
class CustomersResponse {
  final String UserUID;
  final List<Customer> Customers;
  CustomersResponse({this.UserUID, this.Customers});
  factory CustomersResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersResponseToJson(this);
}

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customer.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class Customer {
  @HiveField(0)
  final String? CustomerUID;
  @HiveField(1)
  final String? Name;
  @HiveField(2)
  final String? CustomerType;
  @HiveField(3)
  final String? DisplayName;
  @HiveField(4)
  final List<Customer>? Children;
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
  final String? UserUID;
  final List<Customer>? Customers;
  CustomersResponse({this.UserUID, this.Customers});
  factory CustomersResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersResponseToJson(this);
}

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customer.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class Customer {
  //@JsonKey(name: "customerUid")
  @HiveField(0)
  final String? CustomerUID;
  //@JsonKey(name: "name")
  @HiveField(1)
  final String? Name;
  //@JsonKey(name: "customerType")
  @HiveField(2)
  final String? CustomerType;
  //@JsonKey(name: "displayName")
  @HiveField(3)
  final String? DisplayName;
  //@JsonKey(name: "children")
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
  @JsonKey(name: "UserUid")
  final String? UserUID;
   @JsonKey(name: "Customers")
  final List<Customer>? Customers;
  CustomersResponse({this.UserUID, this.Customers});
  factory CustomersResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersResponseToJson(this);
}

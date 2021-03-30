import 'package:flutter/foundation.dart';

class Category{
final int id;
final String name;
final String image;
Category(this.id,this.name,this.image);
}
final List<Category> categories=[
  Category(1,"DASHBOARD","assets/images/clock.svg"),
  Category(2,"FLEET","assets/images/truck.svg"),
  Category(3,"UTILIZATION","assets/images/support.svg"),
  Category(4,"ASSET OPERATION","assets/images/assetmanager.svg"),
  Category(5,"LOCATION","assets/images/location.svg"),
  Category(6,"HEALTH","assets/images/van.svg"),
  Category(7,"MAINTENANCE","assets/images/mainta.svg"),
  Category(8,"ADMINISTRATION","assets/images/admin.svg"),
  Category(9,"PLANT","assets/images/plant.svg"),
  Category(10,"SUBSCRIPTION","assets/images/subs.svg"),
  Category(11,"NOTIFICATION","assets/images/noti.svg")
];

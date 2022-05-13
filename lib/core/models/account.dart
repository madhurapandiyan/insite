import 'package:hive/hive.dart';
import 'package:insite/utils/enums.dart';

import 'customer.dart';
part 'account.g.dart';

@HiveType(typeId: 6)
class AccountData {
  @HiveField(0)
  final AccountType? selectionType;
  @HiveField(1)
  final Customer? value;
  @HiveField(2)
  bool? isSelected;
  AccountData({
    this.selectionType,
    this.value,
    this.isSelected,
  });
}

import 'package:floor/floor.dart';

@Entity(tableName: 'Dogs')
class Dog {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String name;
  final int age;

  Dog({required this.name, required this.age});
}

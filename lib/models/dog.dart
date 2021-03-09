import 'package:floor/floor.dart';

@Entity(tableName: 'Dogs')
class Dog {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final int age;

  Dog({required this.id, required this.name, required this.age});
}

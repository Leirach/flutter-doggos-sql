import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sql/models/dog.dart';

@dao
abstract class DogDao {
  @Query('SELECT * FROM dogs')
  Future<List<Dog>> findAllDogs();

  @Query('SELECT * FROM dogs WHERE id = :id')
  Future<Dog?> findDogById(int id);

  @insert
  Future<void> insertDog(Dog dog);

  @Query('UPDATE dogs SET name = :name, age = :age WHERE id = :id')
  Future<Dog?> updateDog(int id, String name, int age);

  @Query('DELETE FROM dogs WHERE id = :id')
  Future<void> delete(int id);
}

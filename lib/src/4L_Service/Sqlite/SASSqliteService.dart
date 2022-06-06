import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yourlucky/src/3L_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/3L_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/4L_Service/Base/SABBaseService.dart';

class Dog extends SABBaseModel {
  Dog({
    required this.id,
    required this.name,
    required this.age,
  });
  final int? id;
  final String name;
  final int age;

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  Dog.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as int,
          name: json['name'] as String,
          age: json['age'] as int,
        );

  @override
  String getModelName() {
    return 'dogs';
  }

  @override
  int? getModelId() {
    return id;
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  // 重写 toString 方法，以便使用 print 方法查看每个狗狗信息的时候能更清晰。
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

class SASSqliteService extends SABBaseService {
  late final database = openDataBase();
  Future<Database> openDataBase() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    final databaseResult = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      // 设置数据库的路径。注意：使用 `path` 包中的 `join` 方法是
      // 确保在多平台上路径都正确的最佳实践。
      join(await getDatabasesPath(), 'sa_database.db'),
      // When the database is first created, create a table to store dogs.
      // 当数据库第一次被创建的时候，创建一个数据表，用以存储狗狗们的数据。
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        // 创建多张表
        await db.execute(
          'CREATE TABLE easy(id INTEGER PRIMARY KEY AUTOINCREMENT, easy TEXT, time TEXT,usefulDeity TEXT)',
        );
        await db.execute(
          'CREATE TABLE easy(id INTEGER PRIMARY KEY AUTOINCREMENT, easy TEXT, time TEXT,usefulDeity TEXT)',
        );

        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      // 设置版本。它将执行 onCreate 方法，同时提供数据库升级和降级的路径。
      version: 1,
    );
    return databaseResult;
  }

  // Define a function that inserts dogs into the database
  Future<void> insertModel(SABBaseModel sabModel) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      sabModel.getModelName(),
      sabModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<SABBaseModel>> query(SABBaseModel sabModel) async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps =
        await db.query(sabModel.getModelName());
    // Convert the List<Map<String, dynamic> into a List<Dog> (将 List<Map<String, dynamic> 转换成 List<Dog> 数据类型)
    return List.generate(maps.length, (i) {
      Type tempType = sabModel.runtimeType;
      if (tempType == SABEasyDigitModel) {
        return SABEasyDigitModel.fromJson(maps[i]);
      } else {
        return Dog.fromJson(maps[i]);
      }
    });
  }

  Future<void> updateModel(SABBaseModel sabModel) async {
    // Get a reference to the database (获得数据库引用)
    final db = await database;
    // Update the given Dog (修改给定的狗狗的数据)
    await db.update(
      sabModel.getModelName(),
      sabModel.toJson(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [sabModel.getModelId()],
    );
  }

  Future<void> deleteModel(SABBaseModel sabModel) async {
    // Get a reference to the database (获得数据库引用)
    final db = await database;
    // Remove the Dog from the database (将狗狗从数据库移除)
    await db.delete(
      sabModel.getModelName(),
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [sabModel.getModelId()],
    );
  }
  //
  // /// Dog
  // // Define a function that inserts dogs into the database
  // Future<void> insertDog(Dog dog) async {
  //   // Get a reference to the database.
  //   final db = await database;
  //
  //   // Insert the Dog into the correct table. You might also specify the
  //   // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //   //
  //   // In this case, replace any previous data.
  //   await db.insert(
  //     'dogs',
  //     dog.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
  //
  // // A method that retrieves all the dogs from the dogs table.
  // Future<List<Dog>> dogs() async {
  //   // Get a reference to the database.
  //   final db = await database;
  //
  //   // Query the table for all The Dogs.
  //   final List<Map<String, dynamic>> maps = await db.query('dogs');
  //   // Convert the List<Map<String, dynamic> into a List<Dog> (将 List<Map<String, dynamic> 转换成 List<Dog> 数据类型)
  //   return List.generate(maps.length, (i) {
  //     return Dog(
  //       id: maps[i]['id'],
  //       name: maps[i]['name'],
  //       age: maps[i]['age'],
  //     );
  //   });
  // }
  //
  // Future<void> updateDog(Dog dog) async {
  //   // Get a reference to the database (获得数据库引用)
  //   final db = await database;
  //   // Update the given Dog (修改给定的狗狗的数据)
  //   await db.update(
  //     'dogs',
  //     dog.toMap(),
  //     // Ensure that the Dog has a matching id.
  //     where: 'id = ?',
  //     // Pass the Dog's id as a whereArg to prevent SQL injection.
  //     whereArgs: [dog.id],
  //   );
  // }
  //
  // Future<void> deleteDog(int id) async {
  //   // Get a reference to the database (获得数据库引用)
  //   final db = await database;
  //   // Remove the Dog from the database (将狗狗从数据库移除)
  //   await db.delete(
  //     'dogs',
  //     // Use a `where` clause to delete a specific dog.
  //     where: 'id = ?',
  //     // Pass the Dog's id as a whereArg to prevent SQL injection.
  //     whereArgs: [id],
  //   );
  // }

  Future<void> testDog() async {
    // Create a Dog and add it to the dogs table
    var fido = Dog(
      id: 10,
      name: 'Fido',
      age: 35,
    );
    await insertModel(fido);

    // Now, use the method above to retrieve all the dogs.
    print(await query(fido)); // Prints a list that include Fido.

    // Update Fido's age and save it to the database.
    fido = Dog(
      id: fido.id,
      name: fido.name,
      age: fido.age + 7,
    );
    await updateModel(fido);

    // Print the updated results.
    print(await query(fido)); // Prints Fido with age 42.

    // Delete Fido from the database.
    await deleteModel(fido);
    // Print the list of dogs (empty) [打印一个列表的狗狗们 (这里已经空了)]
    print(await query(fido));
  }
}

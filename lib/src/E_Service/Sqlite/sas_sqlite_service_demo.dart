
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/E_Service/Base/sas_base_service.dart';
import 'sas_sqlite_service.dart';

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

class SASSqliteDemoService extends SASBaseService {

  Future<void> testDog() async {
    final SASSqliteService sqlService =  SASSqliteService();
    // Create a Dog and add it to the dogs table
    var fido = Dog(
      id: 10,
      name: 'Fido',
      age: 35,
    );
    await sqlService.insertModel(fido, (json) {
      printMsg('Dog:${Dog.fromJson(json)}');
    });

    // Now, use the method above to retrieve all the dogs.

    sqlService.query(fido.getModelName(), (json) {
      Dog.fromJson(json);
      printMsg(Dog.fromJson(json) as String?);
    }, () {});

    // Update Fido's age and save it to the database.
    fido = Dog(
      id: fido.id,
      name: fido.name,
      age: fido.age + 7,
    );
    await sqlService.updateModel(fido,(int count){});

    // Print the updated results.
    sqlService.query(fido.getModelName(), (json) {
      Dog.fromJson(json);
      printMsg(Dog.fromJson(json) as String?);
    }, () {});

    // Delete Fido from the database.
    await sqlService.deleteModel(fido);
    // Print the list of dogs (empty) [打印一个列表的狗狗们 (这里已经空了)]
    sqlService.query(fido.getModelName(), (json) {
      Dog.fromJson(json);
      printMsg(Dog.fromJson(json) as String?);
    }, () {});
  }
}

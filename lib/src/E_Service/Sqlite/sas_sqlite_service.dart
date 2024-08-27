import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/E_Service/Base/sas_base_service.dart';


class SASSqliteService extends SABBaseService {
  Database? database;
  Future<void> openDataBase(void Function(Database db) databaseFunc) async {
    if (null == database) {
      // Avoid errors caused by flutter upgrade.
      // Importing 'package:flutter/widgets.dart' is required.
      WidgetsFlutterBinding.ensureInitialized();
      // Open the database and store the reference.
      database = await openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        // 设置数据库的路径。注意：使用 `path` 包中的 `join` 方法是
        // 确保在多平台上路径都正确的最佳实践。
        join(await getDatabasesPath(), 'sa_database.db'),
        // When the database is first created, create a table to store dogs.
        onCreate: (db, version) async {
          printMsg('onCreate');
        },
        onOpen: (db) async {
          printMsg('onOpen:${db.path}');
          // Run the CREATE TABLE statement on the database.
          // 创建多张表
          await db.execute(
            'CREATE TABLE IF NOT EXISTS easy(id INTEGER PRIMARY KEY AUTOINCREMENT, easyGoal TEXT, easy TEXT, time TEXT,usefulDeity TEXT,strategy TEXT,dataJson TEXT)',
          );

          await db.execute(
            'CREATE TABLE IF NOT EXISTS easy_log(id INTEGER PRIMARY KEY AUTOINCREMENT, dataId INTEGER, dataJson TEXT, msg TEXT)',
          );

          await db.execute(
            'CREATE TABLE IF NOT EXISTS dogs(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
          );

          await db.execute(
            'CREATE TABLE IF NOT EXISTS setting(id INTEGER PRIMARY KEY AUTOINCREMENT, settingKey TEXT, settingTitle TEXT, intValue INTEGER,stringValue TEXT,settingType INTEGER, stringRemark TEXT)',
          );

          await db.execute(
            'CREATE TABLE IF NOT EXISTS develop_task(id INTEGER PRIMARY KEY AUTOINCREMENT, goal TEXT, relationData TEXT, time TEXT,usefulDeity TEXT,strategy TEXT,dataJson TEXT)',
          );

          await db.execute(
            'CREATE TABLE IF NOT EXISTS user_sign(id INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT, userPassword TEXT,userMail TEXT,loginType INTEGER,dataJson TEXT)',
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        // 设置版本。它将执行 onCreate 方法，同时提供数据库升级和降级的路径。
        version: 1,
      );
    } //else {}
    databaseFunc(database!);
  }

  // Define a function that inserts dogs into the database
  Future<void> insertModel(
    SABBaseModel sabModel,
    void Function(Map<String, Object?> json) insertResult,
  ) async {
    // Get a reference to the database.
    await openDataBase((db) async {
      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      String tableName = sabModel.getModelName();
      Batch theBatch = db.batch();
      theBatch.insert(
        tableName,
        sabModel.toJson(),
      );
      String querySql = 'SELECT * FROM $tableName ORDER BY `id` DESC LIMIT 1';
      theBatch.rawQuery(querySql);
      // theBatch.query(tableName, orderBy: 'id', limit: 1);
      final List<Object?> batchResults = await theBatch.commit();
      List<Map<String, dynamic>> maps =
          batchResults[1] as List<Map<String, dynamic>>;
      for (Object? data in maps) {
        if (data is Map) {
          insertResult(data as Map<String, dynamic>);
        }
      }
    });
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<void> query(String table, void Function(Map<String, Object?> json) createModel,
      void Function() finish) async {
    // Get a reference to the database.
    await openDataBase((db) async {
      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query(table);
      for (Map<String, dynamic> data in maps) {
        createModel(data);
      }
      finish();
    });
  }

  Future<void> updateModel(SABBaseModel sabModel,void Function(int count) updateResult) async {
    // Get a reference to the database (获得数据库引用)
    await openDataBase((db) async {
      // Update the given model (修改给定的model的数据)
      int count = await db.update(
        sabModel.getModelName(),
        sabModel.toJson(),
        // Ensure that the Dog has a matching id.
        where: 'id = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [sabModel.getModelId()],
      );
      updateResult(count);
    });
  }

  Future<void> deleteModel(SABBaseModel sabModel) async {
    // Get a reference to the database (获得数据库引用)
    await openDataBase((db) async {
      // Remove the Dog from the database (将model从数据库移除)
      await db.delete(
        sabModel.getModelName(),
        // Use a `where` clause to delete a specific dog.
        where: 'id = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [sabModel.getModelId()],
      );
    });
  }
}

class T {}

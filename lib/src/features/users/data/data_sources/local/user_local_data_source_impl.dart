import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:totalx_assessment/src/core/utils/constants.dart';

import '../../../../../core/utils/result.dart';
import '../image_pick_data_source.dart';
import 'user_local_data_source.dart';
import 'user_model.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
    final ImagePickerDataSource imagePickerDataSource;
  static const _databaseName = "app_database.db";
  static const _databaseVersion = 1;

  Database? _database;

  UserLocalDataSourceImpl(this.imagePickerDataSource);

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $userTable (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      age INTEGER NOT NULL,
      imagePath TEXT
    )
    ''');
  }

  @override
  Future<Result<bool>> addUser(UserModel user) async {
    try {
      final db = await database;
      var res = await db.insert(userTable, user.toMap());
      return res > 0
          ? Result(StatusCode.success, 'user added', true)
          : Result(StatusCode.failure, "unable to add user", false);
    } catch (e) {
      return Result(StatusCode.unExpectedError, e.toString(), false);
    }
  }

  @override
  Future<Result<List<UserModel>>> getUsers(int offset, int limit) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> listOfUsers = await db.query(
        userTable,
        limit: limit,
        offset: offset,
      );

      var users = List.generate(listOfUsers.length, (i) {
        return UserModel.fromMap(listOfUsers[i]);
      });
      return  Result(StatusCode.success, 'fetched users', users);
     
    } catch (e) {
      return Result(StatusCode.unExpectedError, e.toString(), []);
    }
  }

  @override
  Future<Result<String?>> pickImage() async {
    try {
      final result = await imagePickerDataSource.pickImage();
      return result;
    } catch (e) {
      return Result(StatusCode.unExpectedError, e.toString(), '');
    }
  }
}

import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:mysql1/mysql1.dart';

var _conn;


Future<void> connectToMyDB() async
{
  var settings = new ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: 'root',
      db: 'leen12'
  );
  _conn = await MySqlConnection.connect(settings);
}


Future<void> showUsers() async
{
  connectToMyDB();
  // Query the database using a parameterized query
  var results = await _conn.query(
    'select * from users',);
  for (var row in results) {
    print('userID: ${row[0]}, firstName: ${row[1]} lastName: ${row[2]}');
  }
}


Future<void> insertUser(firstname,lastname, password) async
{
  connectToMyDB();
  var result = await _conn.query(
      'insert into users (firstName, password, lastName) values (?, ?, ?)',
      [firstname, lastname, password]);
  print('Inserted row id=${result.insertId}');
  await _conn.close();
}


Future<void> insertJob(JobModel jb) async
{
  connectToMyDB();
  var result = await _conn.query(
      'insert into jobs (JobName, Location, Description) values (?, ?, ?)',
      [jb.JobTitle,jb.Location,jb.Description]);
  print('Inserted row id=${result.insertId}');

  await _conn.close();

}

Future<Results> CheckLogin(UserModel user)async
{
  connectToMyDB();
  var result= await _conn.query(
    'select * from users where firstname=? and password=?',
    [user.FirstName,user.Password]);
  await _conn.close();
  return result;
}
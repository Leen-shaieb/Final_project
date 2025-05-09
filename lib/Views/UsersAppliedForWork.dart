import 'dart:collection';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/Utils/clientConfig.dart';
import 'dart:convert';
import 'EditProfileScreen.dart';
import 'JobDetails.dart';

class UsersappliedforworkScreen extends StatefulWidget {
  UsersappliedforworkScreen({super.key, required this.title,required this.jb});

  final String title;
  final JobModel jb;




  @override
  State<UsersappliedforworkScreen> createState() => UsersappliedforworkScreenPageState();

}
late  JobModel? jb;


class UsersappliedforworkScreenPageState extends State<UsersappliedforworkScreen> {



  Future getUsersApplied() async {
    var url = "/usersApplied/getUsersApplied.php?jobID="+ widget.jb.jobID;
    print(serverPath + url);

    final response = await http.get(Uri.parse(serverPath + url));
    print(response.body);
    print(serverPath + url);
    List<UserModel> arr = [];

    for (Map<String, dynamic> i in json.decode(response.body)) {
      arr.add(UserModel.fromJson(i));
    }
    return arr;
  }
  Future deleteUserApplied(UserModel us) async {
    var url = "/usersApplied/deleteUserApplied.php?jobID="+ widget.jb.jobID + "&userID=" + us.userID.toString();
    print(serverPath + url);

    final response = await http.get(Uri.parse(serverPath + url));
    print(response.body);
    print(serverPath + url);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsersappliedforworkScreen(title: 'Users Applied', jb: widget.jb)),
    );
  }
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).colorScheme.onPrimary,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder(
        future: getUsersApplied(),
        builder: (context, projectSnap) {
          if (projectSnap.hasData) {
            if (projectSnap.data.length == 0) {
              return Center(
                child: Text(
                  'אין תוצאות',
                  style: TextStyle(fontSize: 23, color: Theme.of(context).colorScheme.onBackground),
                ),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: projectSnap.data.length,
                itemBuilder: (context, index) {
                  UserModel user = projectSnap.data[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        user.FirstName ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Text(
                        user.Email != null ? "[${user.Email}]" : '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // هنا تقدر تضيف منطق الحذف
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("هل أنت متأكد؟"),
                              content: const Text("سيتم حذف هذا المستخدم من الطلبات."),
                              actions: [
                                TextButton(
                                  child: const Text("إلغاء"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: const Text("حذف", style: TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    deleteUserApplied(user);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          } else if (projectSnap.hasError) {
            return Center(
              child: Text(
                'שגיאה, נסה שוב',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.deepPurple),
          );
        },
      ),
    );
  }


}





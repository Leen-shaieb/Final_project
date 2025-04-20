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
    var url = "/User/getUsersApplied.php?jobID="+ widget.jb.jobID;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: <Widget>[
        ],
      ),
      body: FutureBuilder(
        future: getUsersApplied(),
        builder: (context, projectSnap) {
          if (projectSnap.hasData) {
            if (projectSnap.data.length == 0) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                 child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'אין תוצאות',
                    style: TextStyle(fontSize: 23, color: Colors.black),
                  ),
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: projectSnap.data.length,
                      itemBuilder: (context, index) {
                        UserModel project = projectSnap.data[index];

                        return Card(
                          child: ListTile(
                            onTap: () {
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetailsScreen(title:"jobdetails", jb:project),
                                ),
                              );*/
                            },
                            title: Text(
                              project.FirstName!.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Text(
                              "[" + project.Email! + "]" + "\n",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            isThreeLine: false,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          } else if (projectSnap.hasError) {
            print(projectSnap.error);
            return Center(
                child: Text('שגיאה, נסה שוב',
                    style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
          }
          return Center(
            child: new CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}





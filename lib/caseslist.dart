import 'package:flutterwithjsonserver/detailwidget.dart';
import 'package:flutter/material.dart';
import '../models/cases.dart';

class  CasesList extends StatelessWidget {
   final List<Cases> cases;
  const  CasesList({super.key, required this.cases});

   @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
          itemCount: cases == null ? 0 : cases.length,
          itemBuilder: (BuildContext context, int index) {
            return
              Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailWidget(cases[index])),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(cases[index].name),
                      subtitle: Text(cases[index].age.toString()),
                    ),
                  )
              );
          });
  }

}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/CompanyDetailsModel.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Companies List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
   final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CompanyDetailsModel listCompanyDetailsModel;

  @override
  void initState() {
    // TODO: implement initState
    getComapnyDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(height: MediaQuery.of(context).size.height,
          child:listCompanyDetailsModel!=null? ListView.builder(
          itemCount: listCompanyDetailsModel.companies.length,
          itemBuilder: (context,index){
            return Container(
              height: MediaQuery.of(context).size.height/8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                    Container(width: 100,height: 100,
                        child: Image.network(listCompanyDetailsModel.companies[index].logoUrl)),
                  Padding(
                    padding:  EdgeInsets.only(left:8.0),
                    child: Column(
                      children: [
                        Text(listCompanyDetailsModel.companies[index].company),
                        Text(listCompanyDetailsModel.companies[index].ceo),
                      ],
                    ),
                  )
                ],),
              ),
            );
          },
        ):Container(child: Text("Loading..."),))
      ),

    );
  }
  getComapnyDetails () async{
    var url = "https://clouce.com/companies.json";
    var response =  await http.get(url);
    if (response.body!=null){
      setState(() {
        listCompanyDetailsModel =CompanyDetailsModel.fromJson(jsonDecode(response.body));
      });
    }
  }
}

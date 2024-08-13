import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/sqlhelper.dart';

import 'customcard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _alldata = [];
  bool isloading = true;
  void _refreshData() async {
    final data = await SQLHelper.getALLData();
    setState(() {
      _alldata = data;
      isloading = false;
    });
  }

  void initstate() {
    super.initState();
    _refreshData();
  }

  Future<void> _addData() async {
    await SQLHelper.createData(Title.text, desc.text);
    _refreshData();
  }

  Future<void> _update(int id) async {
    await SQLHelper.updateData(id, Title.text, desc.text);
    _refreshData();
  }

  Future<void> _Delete(int id) async {
    await SQLHelper.deleteData(
      id,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Delete Data'),
        backgroundColor: Colors.red, // Set the background color here
      ),
    );

    _refreshData();
  }

  final TextEditingController Title = TextEditingController();

  final TextEditingController desc = TextEditingController();
  showBottomSheet(int? id) {
    if (id != null) {
      final exstingData =
          _alldata.firstWhere((_element) => _element['id'] == id);
      Title.text = exstingData['title'];
      desc.text = exstingData['desc'];
    }
    showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context: context, builder: (_)=>Container(
      padding: EdgeInsets.only(
        top: 30,
left: 15,right: 15,bottom: MediaQuery.of(context).viewInsets.bottom+50      ),
     child: Column(mainAxisSize: MainAxisSize.min,children: [
      TextFormField(controller: Title,decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Title"
      ),),
SizedBox(
  height: 20,
),

       TextFormField(controller:desc,decoration: InputDecoration(
           border: OutlineInputBorder(),
           hintText: "Desc"
       ),),
       SizedBox(
         height: 10,
       ),
       Center(child: ElevatedButton(onPressed: ()async{
         if(id==null){
           await _addData();

         }
         if(id!=null){
           await _update(id);

         }
Title.text="";
         desc.text="";
     Navigator.of(context).pop();

       }, child: Padding(

         padding: EdgeInsets.all(18.0),
         child: Text(id==null?"Add Data":"UpdateData"),
       ),),)
     ],),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:isloading? Center(
        child:CircularProgressIndicator(),
      ):ListView.builder(
        itemBuilder: (context, index) {
          return Customcard(title: _alldata[index]['title'], desc: _alldata[index]['desc'], onPressed1: () { showBottomSheet(_alldata[index]['id']); }, onPressed2: () { _Delete(_alldata[index]['id']); },);
        },
        itemCount: _alldata.length,
        shrinkWrap: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()=>showBottomSheet(null),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
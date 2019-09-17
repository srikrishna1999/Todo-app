import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 // DateTime now = DateTime.now();
  //String date =  DateFormat("dd-MM-yyyy hh:mm:ss").format(now);
  List<String> passenger = [];
  int flag = 0;
  TextEditingController textFieldHandler = TextEditingController();
  var ans = "";
  SharedPreferences prefs;
  @override
  initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance;
    passenger = (prefs.getStringList("passenger")??[]);
    setState(() {
     if(passenger.isNotEmpty)
     {
       flag = 1;
     }
     passenger = passenger; 
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF3C40C6),
      body: ListView.builder(
        itemCount: passenger.length + 1,
        itemBuilder: (BuildContext context, int i) {
          return i == 0
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 44.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Icon(Icons.format_list_bulleted,
                                size: 35.0, color: Colors.lightBlue),
                          ),
                          Text(
                            "Todo's",
                            style: TextStyle(
                                color: Color(0XFF192A56),
                                fontSize: 35.0,
                                fontFamily: "Kaushan Script"),
                          ),
                          Text(
                            " List",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.0,
                                fontFamily: "Kaushan Script"),
                          ),
                        ],
                      ),
                    ), 
                    SizedBox(
                      height: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextField(
                            controller: textFieldHandler,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Enter todo's",
                              labelStyle: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(50.0)),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 130.0),
                         child: Container(
                          decoration : BoxDecoration(
                              color: Color(0XFF192A56),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (textFieldHandler.text != "") {
                                  flag = 1;
                                  ans = textFieldHandler.text;
                                  passenger.add(ans);
                                  textFieldHandler.clear();
                                }
                                prefs.setStringList("passenger", passenger);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Add",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (flag == 0)
                      Padding(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "No Todo's Today",
                                style: TextStyle(color: Colors.white, fontSize: 20.0,fontFamily: "Kaushan Script"),
                              ),
                              SizedBox(height: 10.0,),
                              Icon(Icons.library_books,color: Color(0XFF192A56),size: 70.0,),
                            ],
                          ),
                          
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 70.0),
                      )
                  ],
                )
              : Column(
                  children: <Widget>[
                    
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 25.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFF67E6DC),
                          ),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(passenger[i - 1],
                                      style: TextStyle(
                                        color: Color(0XFF192A56),
                                        fontSize: 20.0,
                                      )),
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove_circle,
                                      color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      passenger.removeAt(i - 1);
                                      if (passenger.isEmpty) {
                                        flag = 0;
                                      }
                                      prefs.setStringList("passenger", passenger);
                                    });
                                  },
                                ),
                              ],
                            ),
                            //subtitle: Text("$now"),
                          ),
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
void main() => runApp(SettingsPage());

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: ListView(
          children: <Widget>[
            SizedBox(height: 10,),
            Column(
              children: <Widget>[
                Center(
                  child: Stack(children: <Widget>[
                    CircleAvatar(
                      radius: 100.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/istock.jpg'),
                    ),
                    Positioned(
                        top: 120,
                        right: 12,
                        child: Icon(Icons.edit, color: Colors.black, size: 40,)
                    ),
                  ],),
                ),
                SizedBox(height: 5,),
                Center(child:
                Text("@UserName", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),
              ],
            ),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      top: BorderSide(color: Colors.grey),
                      bottom: BorderSide(color: Colors.grey),
                      right: BorderSide(color: Colors.grey),
                      left: BorderSide(color: Colors.grey),
                    )
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Username", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),),
                          Row(
                            children: <Widget>[
                              Text("@username", style: TextStyle(fontSize: 20, color: Colors.grey),),
                              SizedBox(width: 3,),
                              Icon(Icons.edit,size: 20,),
                            ],

                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Password", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),),
                          Row(
                            children: <Widget>[
                              Text("....................", style: TextStyle(fontSize: 20, color: Colors.grey),),
                              SizedBox(width: 3,),
                              Icon(Icons.edit,size: 20,),
                            ],

                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Email Address", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),),
                          Row(
                            children: <Widget>[
                              Text("haha@s,com", style: TextStyle(fontSize: 20, color: Colors.grey),),
                              SizedBox(width: 3,),
                              Icon(Icons.edit,size: 20,),
                            ],

                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Auto Sync", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),),
                          Icon(Icons.slideshow)
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Theme", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30,), textAlign: TextAlign.left,),
                          DropdownButton(items: null, onChanged: null),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
            ),

            SizedBox(height: 10,),
            Center(
              child:FlatButton(onPressed: null, child: Text("Log Out", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),)),
            )
            // Stack(
            //     children: <Widget>[
            //       Container(
            //         decoration: BoxDecoration(
            //           image: DecorationImage(image: AssetImage("assets/images/istock.jpg"), fit: BoxFit.fill), shape: BoxShape.circle,),),
            //     ]),
          ],
        ),

      ),
    );
  }
}



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         //ask if it needs an app bar but i don't think it needs one cause it has it's own page. Back doesn't navigate to anything
//         appBar: AppBar(
//           title: Text("Settings") ,
//         ),
//         body: ListView(
//           children: <Widget>[
//             Stack(
//               children: <Widget>[
//                 Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(image: AssetImage("assets/images/istock.jpg"), fit: BoxFit.fill), shape: BoxShape.circle,),),
//   ])
//               ],
//             ),
//
//         ),
//       );
//   }
// }

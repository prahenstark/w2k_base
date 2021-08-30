import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:w2k/providers/UserProvider.dart';

class ProfileDrawerWidget extends StatefulWidget {
  static const String id = 'drawer';

  @override
  _ProfileDrawerWidgetState createState() => _ProfileDrawerWidgetState();
}

class _ProfileDrawerWidgetState extends State<ProfileDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = Provider.of<UserProvider>(context).user.name;
    final email = Provider.of<UserProvider>(context).user.email;
    final urlImage = 'assets/user.jpeg';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 167, 109),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Profile'),
            Text(
              'LOGOUT',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color.fromARGB(40, 9, 167, 109),
        //color: Color.fromRGBO(50, 75, 205, 1),
        //color: Colors.deepOrangeAccent,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: "Hi $name",
              email: email,
              onClicked: () {},
            ),
            Divider(
              color: Colors.black54,
              indent: 20.0,
              endIndent: 20.0,
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  //const SizedBox(height: 12),
                  //buildSearchField(),
                  //const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'My QR Code',
                    icon: Icons.qr_code_scanner_outlined,
                    //onClicked: () => selectedItem(context, 0),
                  ),
                  buildMenuItem(
                    text: 'Subsciptions',
                    icon: Icons.favorite_border,
                    //onClicked: () => selectedItem(context, 1),
                  ),
                  buildMenuItem(
                    text: 'My Address',
                    icon: Icons.location_on_outlined,
                    //onClicked: () => selectedItem(context, 2),
                  ),
                  buildMenuItem(
                    text: 'Change Password',
                    icon: Icons.lock_outline,
                    //onClicked: () => selectedItem(context, 2),
                  ),
                  Divider(color: Colors.black54),
                  buildMenuItem(
                    text: 'Help',
                    icon: Icons.help_outline,
                    //onClicked: () => selectedItem(context, 4),
                  ),
                  buildMenuItem(
                    text: 'About Us',
                    icon: Icons.alternate_email_outlined,
                    //onClicked: () => selectedItem(context, 3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    String urlImage,
    String name,
    String email,
    VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 20)),
          child: Row(
            children: [
              Stack(
                //fit: StackFit.expand,
                overflow: Overflow.visible,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(urlImage),
                  ),
                  Positioned(
                    right: 10,
                    bottom: -5,
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        color: Color.fromARGB(255, 9, 167, 109),
                        onPressed: () {},
                        child: null,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 17,
                    bottom: 2,
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.white,
                      size: 12.5,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Likun',
                    //name,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '7539870451',
                    //email,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'parijaprahen@gmail.com',
                        //email,
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(width: 65,),
                      Icon(
                        Icons.verified_user_rounded,
                        color: Color.fromARGB(255, 9, 167, 109),
                        size: 15,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Edit Details',
                    //email,
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 9, 167, 109),
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Spacer(),
              // CircleAvatar(
              //   radius: 24,
              //   backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              //   child: Icon(Icons.add_comment_outlined, color: Colors.white),
              // )
            ],
          ),
        ),
      );

  // Widget buildSearchField() {
  //   final color = Colors.white;
  //
  //   return TextField(
  //     style: TextStyle(color: color),
  //     decoration: InputDecoration(
  //       contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //       hintText: 'Search',
  //       hintStyle: TextStyle(color: color),
  //       prefixIcon: Icon(Icons.search, color: color),
  //       filled: true,
  //       fillColor: Colors.white12,
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //     ),
  //   );
  // }

  Widget buildMenuItem({
    String text,
    IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.black54;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  // void selectedItem(BuildContext context, int index) {
  //   Navigator.of(context).pop();
  //
  //   switch (index) {
  //     case 0:
  //       Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) => ProfilePage(),
  //       ));
  //       break;
  //     case 1:
  //       Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) => YogaPage(),
  //       ));
  //       break;
  //   }
  // }
}

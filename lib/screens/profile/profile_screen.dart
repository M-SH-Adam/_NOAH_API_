import 'package:ark_2/screens/profile/profile_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/custom_colors.dart';
import '../../widgets/nav_bar_widget.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: CustomColors.mainColor,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildCard(
                        Icon(
                          Icons.person,
                          color: Colors.teal,
                        ),
                        context.watch<ProfileViewModel>().user['Name'],
                        ""),
                    buildCard(
                        Icon(
                          Icons.phone,
                          color: Colors.teal,
                        ),
                        context.watch<ProfileViewModel>().user['Phone Number'],
                        "Your Phone Number"),
                    buildCard(
                        Icon(
                          Icons.email_outlined,
                          color: Colors.teal,
                        ),
                        context.watch<ProfileViewModel>().user['Email'],
                        "Your Email"),
                    buildCard(
                        Icon(
                          Icons.home,
                          color: Colors.teal,
                        ),
                        context.watch<ProfileViewModel>().user['Address'],
                        "Your Address"),
                    buildCard(
                        Icon(
                          Icons.calendar_today,
                          color: Colors.teal,
                        ),
                        context.watch<ProfileViewModel>().user['BirthDate'] ==
                                null
                            ? null
                            : context
                                .watch<ProfileViewModel>()
                                .user['BirthDate']
                                .toString()
                                .split(" ")
                                .first,
                        "Your BirthDate"),
                  ],
                ),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.mainColor,
          onPressed: () {
            context.read<ProfileViewModel>().editProfile(context);
          },
          child: Icon(
            Icons.edit,
            size: 35,
          )),
    );
  }

  Card buildCard(Icon icon, String? text, String empty) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          leading: icon,
          title: Text(
            text != null ? text : empty,
            style: text != null
                ? TextStyle(
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                    fontSize: 18.0,
                  )
                : TextStyle(
                    color: Colors.black26,
                    fontFamily: 'Source Sans Pro',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
          ),
        ));
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = CustomColors.mainColor;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

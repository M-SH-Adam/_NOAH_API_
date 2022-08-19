import 'package:ark_2/app/routes.dart';
import 'package:ark_2/classes/formsControls/NavControls.dart';
import 'package:ark_2/screens/login/login_viewModel.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void animal() => Navigator.pushReplacementNamed(context, Routes.myAnimals);
    void request() => Navigator.pushReplacementNamed(context, Routes.map);
    void profile() => Navigator.pushReplacementNamed(context, Routes.profile);
    void noTHing() {}
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          NavControls.navProfile(),
          NavControls.navButtons(Icons.person, 'My profile', profile),
          NavControls.navButtons(Icons.request_page, 'Request', request),
          NavControls.navButtons(Icons.pets, 'My Animals', animal),
          NavControls.navButtons(Icons.map, 'City', noTHing),
          NavControls.navButtons(Icons.history, 'Request history', noTHing),
          NavControls.navButtons(Icons.share, 'Intercity', noTHing),
          NavControls.navButtons(
              Icons.security, 'Safety and Security', noTHing),
          Divider(),
          NavControls.navButtons(Icons.settings, 'Settings', noTHing),
          NavControls.navButtons(Icons.help, 'Help', noTHing),
          Divider(),
          NavControls.navButtons(Icons.exit_to_app, 'Sign Out', () {
            LoginViewModel().signOut(context);
          }),
        ],
      ),
    );
  }
}

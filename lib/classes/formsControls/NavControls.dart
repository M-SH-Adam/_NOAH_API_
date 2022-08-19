import 'package:flutter/material.dart';

import '../../theme/custom_assets.dart';
import '../../theme/custom_colors.dart';

class NavControls {
  static Widget navProfile() {
    return UserAccountsDrawerHeader(
      accountName: Text(
        "Yahia" + " " + "Ibrahim",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      accountEmail: Text(
        "",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        child: ClipOval(
          child: Image.asset(
            CustomAssets.profile,
            fit: BoxFit.cover,
            width: 90,
            height: 90,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: CustomColors.mainColor,
        image: DecorationImage(
            fit: BoxFit.fill, image: AssetImage(CustomAssets.noahLogo)),
      ),
    );
  }

  static Widget navButtons(
      IconData icon, String buttonTitle, Function function) {
    return ListTile(
      leading: Icon(icon),
      title: Text(buttonTitle),
      onTap: () => function(),
    );
  }
}

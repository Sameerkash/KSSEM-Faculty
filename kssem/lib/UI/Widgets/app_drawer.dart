import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kssem/UI/Screens/coc.dart';
import 'package:kssem/Utilities/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Notifiers/theme_changer.dart';
import 'package:provider/provider.dart';
// import 'package:kssem/Services/authentication.dart';
// import 'package:kssem/UI/Widgets/platform_alert_dialog.dart';
// import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer(this.displayName);
  final String displayName;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context, listen: false);
    return Drawer(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, left: 15, right: 10),
                    child: Text(
                      "Welcome,",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, left: 15, right: 10),
                    child: Text(
                      displayName,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, left: 15, right: 10),
                    child: Text(
                      "to KSSEM Connect",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              buildListTile(
                title: "Arohana",
                subtitle: "Coming Soon",
                icon: MaterialCommunityIcons.movie,
              ),
              buildListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CodeOfConduct())),
                title: "COC",
                subtitle: "code of conduct",
                icon: MaterialCommunityIcons.flag,
              ),
              SizedBox(
                height: 5,
              ),
              buildListTile(
                  onTap: () async {
                    String subject = "KSSEM App Bug Report";
                    String uri =
                        'mailto:sameera.s.kashyap@gmail.com?subject=${Uri.encodeComponent(subject)}';
                    if (await canLaunch(uri)) {
                      await launch(uri);
                    } else {
                      print('Could not launch $uri');
                    }
                  },

                  //   SchedulerBinding.instance.addPostFrameCallback((_) {
                  //     // close the app drawer
                  //     Navigator.of(context).pop();
                  //     _confirmSignOut(context);
                  //   });
                  // },

                  // Navigator.pop(context);
                  // Navigator.of(context).pop();

                  title: "Feedback",
                  subtitle: "Contact the Developer",
                  icon: Icons.mail),
              // IconButton(
              //   icon: Icon(Icons.lightbulb_outline),
              //   onPressed: () {
              //     if (theme.getTheme() == ThemeData.dark()) {
              //       theme.setTheme(ThemeData.light());
              //     } else {
              //       theme.setTheme(ThemeData.dark());
              //     }
              //   },
              // ),
              Row(children: [
                Switch(
                    value: Provider.of<ThemeChanger>(context).isDarkModeOn,
                    onChanged: (booleanValue) {
                      Provider.of<ThemeChanger>(context, listen: false)
                          .updateTheme(booleanValue);
                    }),
                // Spacer(),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Dark Mode",
                  style: TextStyle(fontSize: 18),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _signOut(BuildContext context) async {
  //   try {
  //     final auth = Provider.of<UserProvider>(context, listen: false);
  //     await auth.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<void> _confirmSignOut(BuildContext context) async {
  //   final didRequestSignOut = await PlatformAlertDialog(
  //     title: 'Logout',
  //     content: 'Are you sure that you want to logout?',
  //     cancelActionText: 'Cancel',
  //     defaultActionText: 'Logout',
  //   ).show(context);
  //   if (didRequestSignOut == true) {
  //     _signOut(context);
  //   }
  // }

  ListTile buildListTile(
      {String title, String subtitle, IconData icon, Function onTap}) {
    return ListTile(
      onTap: onTap,
      subtitle: Text(subtitle),
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      leading: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}

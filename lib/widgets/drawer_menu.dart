import "dart:io";

import "package:bhuvan_cv/models/user_details_model.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "package:provider/src/provider.dart";
import "../blocs/theme_bloc.dart";
import "../config/config.dart";
import "../util/app_service.dart";
import "cached_image.dart";

class DrawerMenu extends StatelessWidget {
  final UserDetails user;

  const DrawerMenu({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tb = context.watch<ThemeBloc>();
    final List titles = [];

    final List icons = [
      Icons.cast_for_education,
      Icons.try_sms_star_outlined,
      Icons.logout,
      Icons.exit_to_app
    ];

    final List colors = [
      Colors.blueAccent,
      Colors.blueGrey,
      Colors.green,
      Colors.redAccent,
      Colors.blueAccent,
      Colors.blue,
      Colors.blueAccent,
      Colors.orangeAccent,
      Colors.blueGrey,
      Colors.green,
      Colors.green,
      Colors.redAccent,
      Colors.blueAccent,
      Colors.blue,
      Config.ACCENT_COLOR
    ];
    final List actions = [];

    return Drawer(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerHeader(
                margin: EdgeInsets.all(0.0),
                child: AppDrawerTop(
                  user: user,
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 4),
                    // shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          actions[index].call();
                        },
                        child: Card(
                          margin: EdgeInsets.only(left: 4, right: 4, top: 4),
                          // color:Config.BLUE_DIANNE,
                          child: Container(
                            height: 35,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(6),
                            // margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                                // color: Colors.red
                                ),
                            child: Row(
                              children: [
                                Icon(
                                  icons[index],
                                  color: colors[index],
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  titles[index],
                                  style: TextStyle(),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text("dark mode"),
                    leading: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(Icons.sunny, size: 22, color: Colors.white),
                    ),
                    trailing: Switch(
                        activeColor: Theme.of(context).primaryColor,
                        value: context.watch<ThemeBloc>().darkTheme!,
                        onChanged: (bool) {
                          context.read<ThemeBloc>().toggleTheme();
                        }),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Bhuvaneshvar CV"),
                          Container(
                            width: 2,
                            height: 25,
                            color: Config.ACCENT_COLOR,
                          ),
                          Column(
                            children: [
                              Text("Last Updated"),
                              Text("12/12/2012")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppDrawerTop extends StatelessWidget {
  final UserDetails user;

  const AppDrawerTop({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tb = context.watch<ThemeBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // children: [
      //   CircleAvatar(
      //     radius: 32,
      //     backgroundColor: Config.ACCENT_COLOR,
      //     child: CustomCacheImage(
      //       imageUrl: user.imageUrl,
      //       radius: 0,
      //     ),
      //   ),
      //   Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Text(
      //         user.name,
      //         maxLines: 3,
      //       ),
      //       Text(
      //         user.rollNumber,
      //         style: labelLarge(tb.darkTheme),
      //       )
      //     ],
      //   ),
      // ],
    );
  }
}

import 'package:bhuvan_cv/blocs/token_bloc.dart';
import 'package:bhuvan_cv/util/app_service.dart';
import 'package:bhuvan_cv/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../blocs/theme_bloc.dart';
import '../models/user_details_model.dart';
import '../widgets/drawer_menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final user = context.watch<TokenBloc>().user!;
    final tb = context.watch<ThemeBloc>();
    return Scaffold(
      drawer: true ? null : DrawerMenu(user: user),
      appBar: AppBar(
        actions: [
          IconButton(
              tooltip: "Email ${user.name}",
              onPressed: () {
                AppService()
                    .openLink(context, "mailto:bhuvaneshvar8@gmail.com");
              },
              icon: Icon(Icons.email)),
          IconButton(
              onPressed: () {
                context.read<TokenBloc>().getUserData(1, "");
              },
              icon: Icon(Icons.refresh)),
          IconButton(
            onPressed: () {
              context.read<ThemeBloc>().toggleTheme();
            },
            tooltip: "Night Mode",
            icon: Icon(Icons.sunny),
          ),
          IconButton(
              onPressed: () {},
              tooltip: "Print this page",
              icon: Icon(Icons.print)),
        ],
      ),
      key: scaffoldKey,
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
              ),
              Container(
                height: 150,
                child: UserTopDetails(
                    avatarUrl: user.avatarUrl,
                    name: user.name,
                    role: user.currentRole,
                    location: user.currentLocation),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  ("${user.subjectLine} ") * 24,
                  maxLines: 10,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SkillSection(user.skills),
              SizedBox(
                height: 32,
              ),
              ExperienceSection(
                experience: user.experience,
                actionOnRoleClick: (str) {
                  //todo open bottom sheet to show role details
                },
                actionOnCompanyClick: (str) {
                  //todo open bottom sheet to show company details
                },
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ExperienceSection extends StatelessWidget {
  final List<Experience> experience;
  final Function(String) actionOnRoleClick;
  final Function(String) actionOnCompanyClick;

  const ExperienceSection(
      {Key? key,
      required this.experience,
      required this.actionOnRoleClick,
      required this.actionOnCompanyClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return experience.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Experience",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.only(left: 64),
                child: ListView.builder(
                  itemCount: experience.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final cur = experience[index];
                    return Container(
                      child: TimelineTile(
                        indicatorStyle: IndicatorStyle(
                          width: 8,
                          indicatorXY: .45,
                          padding: EdgeInsets.all(2),
                          color: index == 0 ? Colors.green : Colors.grey,
                        ),
                        beforeLineStyle: LineStyle(thickness: 2),
                        afterLineStyle: LineStyle(thickness: 2),
                        endChild: Padding(
                          padding:
                              const EdgeInsets.only(left: 32.0, bottom: 32),
                          child: ExperienceCard(
                            role: cur.role,
                            company: cur.company,
                            duration: "${cur.start} - ${cur.end}",
                            actionOnCompanyClick: () {
                              actionOnCompanyClick(cur.company);
                            },
                            actionOnRoleClick: () {
                              actionOnRoleClick(cur.company);
                            },
                          ),
                        ),
                        isFirst: index == 0,
                        isLast: index == experience.length - 1,
                      ),
                    );
                  },
                ),
              )
            ],
          )
        : SizedBox();
  }
}

class ExperienceCard extends StatelessWidget {
  final String role;
  final String company;
  final String duration;
  final Function actionOnRoleClick;
  final Function actionOnCompanyClick;

  const ExperienceCard(
      {Key? key,
      required this.role,
      required this.company,
      required this.duration,
      required this.actionOnRoleClick,
      required this.actionOnCompanyClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => actionOnRoleClick,
          child: Text(
            role,
            maxLines: 1,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        InkWell(
          onTap: () => actionOnCompanyClick,
          child: Text(company,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
        ),
        SizedBox(
          height: 4,
        ),
        Text(duration),
      ],
    );
  }
}

class SkillSection extends StatelessWidget {
  final List<Skill> skills;

  const SkillSection(this.skills, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: skills.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Skills",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: skills
                      .map((e) => SkillCard(imgUrl: e.imgUrl, title: e.title))
                      .toList(growable: false),
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}

class SkillCard extends StatelessWidget {
  final String imgUrl;
  final String title;

  const SkillCard({Key? key, required this.imgUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: CustomCacheImage(
              imageUrl: imgUrl,
              radius: 0.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}

class UserTopDetails extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String role;
  final String location;

  const UserTopDetails(
      {Key? key,
      required this.avatarUrl,
      required this.name,
      required this.role,
      required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            height: 150,
            child: CustomCacheImage(
              imageUrl: avatarUrl,
              radius: 16,
              circularShape: true,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.only(
              left: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    (name + " ") * 30,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Arial Rounded MT Bold"),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: Text(
                    (role + " ") * 30,
                    maxLines: 2,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 18,
                    ),
                    Text(
                      location,
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

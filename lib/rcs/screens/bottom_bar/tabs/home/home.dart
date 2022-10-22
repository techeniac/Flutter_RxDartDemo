import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutterExample/rcs/bloc/bottom_bar_bloc.dart';
import 'package:flutterExample/rcs/bloc/home_bloc.dart';
import 'package:flutterExample/rcs/manager/prefs_manager.dart';
import 'package:flutterExample/rcs/models/TestModel.dart';
import 'package:flutterExample/rcs/screens/bottom_bar/tabs/home/players_list.dart';
import 'package:flutterExample/rcs/utils/colors.dart';
import 'package:flutterExample/rcs/utils/strings.dart';
import 'package:flutterExample/rcs/widgets/common_webview.dart';
import 'package:flutterExample/rcs/widgets/common_widget.dart';
import 'package:flutterExample/rcs/widgets/player_card.dart';

import '../../../../models/UserModel.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key, required this.bottomBarBloc}) : super(key: key);
  final BottomBarBloc bottomBarBloc;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late double width;
  late TextTheme _textTheme;
  final HomeBloc _homeBloc = HomeBloc();
  final PrefsManager _prefsManager = PrefsManager();

  @override
  void initState() {
    getProfileFromPrefs();
    _homeBloc.getTestData();
    super.initState();
  }

  Future<UserModel?> getProfileFromPrefs() async {
    final UserModel? profile = await _prefsManager.getUserData();
    return profile;
  }

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    width = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
        stream: _homeBloc.getLogoutStream,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topNameBox,
                StreamBuilder<List<TestModel>>(
                  stream: _homeBloc.getTestDataStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox(
                        height: width / 4,
                        width: width,
                        child: const BuilderLoader(),
                      );
                    }
                    final List<TestModel> dataList = snapshot.data!;
                    return Column(
                      children: [
                        componentLabel(
                          label: AppStrings.players,
                          prefixWidget: TextButton(
                            onPressed: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PlayersListScreen(players: dataList),
                                  ),
                                ),
                            child: Text(
                              AppStrings.viewAll,
                              style: _textTheme.bodyText2!.copyWith(
                                color: AppColors.secondaryAccentColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        PlayerSlider(players: dataList),
                      ],
                    );
                  },
                ),
                componentLabel(label: AppStrings.joinUs),
                appLaunch(),
                StreamBuilder<bool>(
                    stream: _homeBloc.getLogoutStream,
                    builder: (context, snapshot) {
                      print("snapshot.hasData${snapshot.hasData}");
                      if (snapshot.hasData) {
                        final bool isLogout = snapshot.data!;
                        print("isLogout : $isLogout");
                        return !isLogout
                            ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CommonButton(
                            text: AppStrings.logout,
                            onPressed: () async =>
                            {
                              _prefsManager.setUserSignedIn(false),
                              _homeBloc.logout(),
                            },
                          ),
                        )
                            : const SizedBox();
                      }
                      return _prefsManager.isSignedIn
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CommonButton(
                          text: AppStrings.logout,
                          onPressed: () async =>
                          {
                            _prefsManager.setUserSignedIn(false),
                            _homeBloc.logout(),
                          },
                        ),
                      )
                          : const SizedBox();
                    }),
              ],
            ),
          );
        }
          );
  }

  Widget get topNameBox => Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.appTitle.toUpperCase(),
                    maxLines: 2,
                    style: _textTheme.bodyText2!.copyWith(
                      color: AppColors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  _prefsManager.isSignedIn
                      ? FutureBuilder<UserModel?>(
                          future: getProfileFromPrefs(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                AppStrings.loading,
                                style: _textTheme.bodyText2!.copyWith(
                                    color: AppColors.gray, fontSize: 10),
                              );
                            }
                            return Text(
                              'Hi, ${snapshot.data!.user!.name}',
                              maxLines: 2,
                              style: _textTheme.bodyText2!.copyWith(
                                  color: AppColors.black, fontSize: 10),
                            );
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            AppLogoWithName(size: width * 0.25)
          ],
        ),
      );

  Widget componentLabel({required String label, Widget? prefixWidget}) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: _textTheme.bodyText2!.copyWith(
                  color: AppColors.black,
                  fontSize: 16,
                ),
              ),
            ),
            prefixWidget ?? const SizedBox(),
          ],
        ),
      );

  Widget appLaunch() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appButton(
            asset: 'instagram',
            url: AppStrings.instaLink,
            appBarName: 'Instagram',
          ),
          appButton(
            asset: 'facebook',
            url: AppStrings.instaLink,
            appBarName: 'Facebook',
          ),
          appButton(
            asset: 'twitter',
            url: AppStrings.instaLink,
            appBarName: 'Twitter',
          ),
          appButton(
            asset: 'snapchat',
            url: AppStrings.instaLink,
            appBarName: 'Snapchat',
          ),
          appButton(
            asset: 'tiktok',
            url: AppStrings.instaLink,
            appBarName: 'TikTok',
          ),
        ],
      );

  Widget appButton({String? asset, String? url, String? appBarName}) =>
      IconButton(
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InAppWebView(
                    url: url!,
                    appBarName: appBarName!,
                  ),
                ),
              ),
          icon: Image.asset(
            '${AppStrings.pngPath}${asset!}.png',
          ));
}

class PlayerSlider extends StatelessWidget {
  const PlayerSlider({Key? key, required this.players}) : super(key: key);
  final List<TestModel> players;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1,
          aspectRatio: 2.1,
        ),
        items: players
            .map((item) => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TeamPlayerCard(data: item),
                ))
            .toList(),
      ),
    );
  }
}

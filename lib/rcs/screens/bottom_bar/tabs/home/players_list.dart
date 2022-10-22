import 'package:flutter/material.dart';
import 'package:flutterExample/rcs/models/TestModel.dart';
import 'package:flutterExample/rcs/utils/colors.dart';
import 'package:flutterExample/rcs/utils/strings.dart';
import 'package:flutterExample/rcs/widgets/player_card.dart';

class PlayersListScreen extends StatefulWidget {
  const PlayersListScreen({Key? key, required this.players}) : super(key: key);
  final List<TestModel> players;
  @override
  State<PlayersListScreen> createState() => _PlayersListScreenState();
}

class _PlayersListScreenState extends State<PlayersListScreen> {
  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            AppStrings.players,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColors.black,
                  fontSize: 20,
                ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.black,
            ),
          ),
        ),
        body: body,
      ),
    );
  }

  Widget get body => ListView.builder(
        shrinkWrap: true,
        itemCount: widget.players.length,
        itemBuilder: ((context, index) => Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: width * 0.04, vertical: 5),
              child: TeamPlayerCard(data: widget.players[index]),
            )),
      );
}

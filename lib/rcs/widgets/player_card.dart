import 'package:flutter/material.dart';
import 'package:flutterExample/rcs/models/TestModel.dart';
import 'package:flutterExample/rcs/utils/colors.dart';
import 'package:flutterExample/rcs/utils/strings.dart';

class TeamPlayerCard extends StatelessWidget {
  const TeamPlayerCard({Key? key, required this.data}) : super(key: key);
  final TestModel data;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return AspectRatio(
      aspectRatio: 2.2,
      child: Container(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.black26,
                      Colors.black87,
                      Colors.black,
                      Colors.black,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: width * 0.03,
                horizontal: width * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.name ?? "",
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                      fontSize: height * 0.025,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: AppColors.primaryColor,
                          ),
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            data.profileImage ?? "",
                            height: width * 0.20,
                            width: width * 0.20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      playerInfo(textTheme),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget playerInfo(TextTheme textTheme) {
    return Expanded(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.hash,
                style: textTheme.bodyText2!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.yellow,
                ),
              ),
              Text(
                AppStrings.location,
                style: textTheme.bodyText2!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.yellow,
                ),
              ),
              Text(
                AppStrings.date,
                style: textTheme.bodyText2!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.yellow,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.colun + data.id!,
                  style: textTheme.bodyText2!.copyWith(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppStrings.colun + data.location!,
                  style: textTheme.bodyText2!.copyWith(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppStrings.colun + data.createdAt!,
                  style: textTheme.bodyText2!.copyWith(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

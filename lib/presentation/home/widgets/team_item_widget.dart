import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersqlite/core/app_export.dart';
import 'package:fluttersqlite/domain/entities/teams_data_model/team.dart';
import 'package:fluttersqlite/localization/app_localization.dart';
import 'package:fluttersqlite/presentation/home/cubit/home_cubit.dart';
import 'package:fluttersqlite/widgets/custom_icon_widget.dart';

// ignore: must_be_immutable
class BuildTeamItemWidget extends StatelessWidget {
  BuildTeamItemWidget(
    this._homeCubit, {
    Key? key,
    required this.team,
  }) : super(
          key: key,
        );

  late final HomeCubit _homeCubit;
  final Team team;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 9.h,
        vertical: 9.v,
      ),
      margin: EdgeInsets.all(10.adaptSize),
      decoration: AppDecoration.outlineBlack.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder29,
          boxShadow: [
            BoxShadow(color: Color(0xff000000), spreadRadius: 1, blurRadius: 12)
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 8.v),
          //show the team info and left and right indicator
          _buildTeamInfo(),
          SizedBox(height: 16.v),
          //show all the player info
          _buildPlayersInfo(),
        ],
      ),
    );
  }

  BlocSelector<HomeCubit, HomeState, int> _buildPlayersInfo() {
    return BlocSelector<HomeCubit, HomeState, int>(
      selector: (state) {
        return team.playerIndex;
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 17.h,
            vertical: 17.v,
          ),
          decoration: AppDecoration.outlineWhite.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder25,
              color: _homeCubit.getCurrentTeamColor()),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //build total player
              _buildTotalPlayer(),
              SizedBox(height: 11.v),
              //build slider
              _buildSliderIndicator(),
              SizedBox(height: 64.v),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //current player name
                  _buildPlayeName(),
                  SizedBox(height: 31.v),
                  //current player score
                  _buildPlayerScore(),
                  SizedBox(height: 85.v),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _buildPlayerScore() {
    return Padding(
      padding: EdgeInsets.only(
        left: 2.h,
        right: 2.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BuildCustomImageWidget(
            imagePath: ImageAssets.imgArrowLeft,
            height: 20.adaptSize,
            width: 20.adaptSize,
            onTap: () {
              //decrement player current index
              _homeCubit.decPlayerIndex(team, _homeCubit);
            },
          ),
          Spacer(
            flex: 50,
          ),
          CustomIconButtonWidget(
            height: 42.adaptSize,
            width: 42.adaptSize,
            onTap: () {
              //decrement player score
              _homeCubit.decPlayerScore(
                  team.players![team.playerIndex], _homeCubit);
            },
            padding: EdgeInsets.all(11.h),
            child: BuildCustomImageWidget(
              imagePath: ImageAssets.imgMinus,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.h, right: 28.h),
            child: BlocSelector<HomeCubit, HomeState, String?>(
              selector: (state) {
                return team.players![team.playerIndex].score;
              },
              builder: (context, state) {
                return Text(
                  "${team.players![team.playerIndex].score}",
                  style: theme.textTheme.titleLarge,
                );
              },
            ),
          ),
          CustomIconButtonWidget(
            height: 42.adaptSize,
            width: 42.adaptSize,
            onTap: () {
              // increment current player score
              _homeCubit.incPlayerScore(
                  team.players![team.playerIndex], _homeCubit);
            },
            padding: EdgeInsets.all(12.h),
            child: BuildCustomImageWidget(
              imagePath: ImageAssets.imgPlus,
            ),
          ),
          Spacer(
            flex: 50,
          ),
          BuildCustomImageWidget(
            imagePath: ImageAssets.imgArrowRight,
            height: 20.adaptSize,
            onTap: () {
              //increment current player index
              _homeCubit.incPlayerIndex(team, _homeCubit);
            },
            width: 20.adaptSize,
          ),
        ],
      ),
    );
  }

  Text _buildPlayeName() {
    return Text(
      "${'lbl_player_name'.tr} : ${team.players![team.playerIndex].name}",
      style: theme.textTheme.headlineSmall,
    );
  }

  Widget _buildSliderIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(team.players!.length, (index) {
        return Expanded(
          child: Container(
            height: 7.v,
            margin: EdgeInsets.only(right: 10.adaptSize, left: 10.adaptSize),
            decoration: BoxDecoration(
              color: appTheme.white
                  .withOpacity(team.playerIndex == index ? 1 : 0.5),
              borderRadius: BorderRadius.circular(
                3.h,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTotalPlayer() {
    return Padding(
      padding: EdgeInsets.only(
        left: 3.h,
        right: 3.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${'lbl_total_player'.tr} ",
            style: CustomTextStyles.bodyLargeWhite,
          ),
          Text(
            "${team.playerIndex + 1}/${team.players?.length}",
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  Padding _buildTeamInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BuildCustomImageWidget(
            imagePath: ImageAssets.imgArrowLeft,
            height: 20.adaptSize,
            width: 20.adaptSize,
            onTap: () {
              // decrement team current index
              _homeCubit.decTeamIndex(_homeCubit);
            },
          ),
          Column(
            children: [
              Text(
                "${team.teamName}",
                style: CustomTextStyles.titleLarge20,
              ),
              SizedBox(
                height: 12.v,
              ),
              Opacity(
                opacity: 0.5,
                child: Text(
                  "${'lbl_team_id'.tr} : ${team.team}",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          BuildCustomImageWidget(
            imagePath: ImageAssets.imgArrowRight,
            height: 20.adaptSize,
            width: 20.adaptSize,
            onTap: () {
              // increment current team index
              _homeCubit.incTeamIndex(_homeCubit);
            },
          ),
        ],
      ),
    );
  }
}

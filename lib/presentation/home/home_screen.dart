import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersqlite/core/app_export.dart';
import 'package:fluttersqlite/localization/app_localization.dart';
import 'package:fluttersqlite/presentation/home/cubit/home_cubit.dart';
import 'package:fluttersqlite/presentation/home/widgets/team_item_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(
    this._homeCubit, {
    Key? key,
  }) : super(key: key,);

  final HomeCubit _homeCubit;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        //Show the loading indicator when loading data
        if (state is HomeInitialState) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        return Scaffold(
          backgroundColor: _homeCubit.getCurrentTeamColor(),
          appBar: AppBar(
            title: Text(
              "lbl_sports".tr,
              textAlign: TextAlign.center,
              style: theme.textTheme.displayMedium,
            ),
            centerTitle: true,
            backgroundColor: _homeCubit.getCurrentTeamColor(),
          ),
          body: Center(
            
            child: _buildSliderTeams(context,state as HomeLoadedState),
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildSliderTeams(BuildContext context,HomeLoadedState state) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //show the carousel for sliding teams
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 490.v,
                initialPage: 0,
                autoPlay: false,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (
                  index,
                  reason,
                ) {
                  //update the current team index 
                  _homeCubit.updateTeamIndex(index,_homeCubit);
                },
              ),
              carouselController: _homeCubit.carouselController,
              itemCount: state.teams?.length,
              itemBuilder: (context, index, realIndex) {
                final team = state.teams![index];
                return BuildTeamItemWidget(_homeCubit,team: team);
              },
            ),
            SizedBox(height: 16.v),
            //dots indicator
            SizedBox(
              height: 6.v,
              child: AnimatedSmoothIndicator(
                activeIndex: _homeCubit.teamIndex,
                count: state.teams!.length,
                axisDirection: Axis.horizontal,
                effect: ScrollingDotsEffect(
                  spacing: 7,
                  activeDotColor: appTheme.white,
                  dotColor: appTheme.grayC2,
                  dotHeight: 6.v,
                  activeDotScale: 1.5.v,
                  dotWidth: 6.h,
                ),
              ),
            ),
          ],
        );
  }
}

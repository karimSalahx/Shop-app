import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc/home_bloc.dart';
import '../../../../locator.dart';
import '../widgets/home_grid_view.dart';
import '../widgets/home_page_app_bar.dart';
import '../widgets/home_page_bottom_navigation_bar.dart';
import '../widgets/home_top_carousel_slider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(GetHomeProductsEvent()),
      child: Scaffold(
        appBar: HomePageAppBar(),
        bottomNavigationBar: HomePageBottomNavigationBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: HomeTopCarouselSlider(),
            ),
            HomeGridView(),
          ],
        ),
      ),
    );
  }
}

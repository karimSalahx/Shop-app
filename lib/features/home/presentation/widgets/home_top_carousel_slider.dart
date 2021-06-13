import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc/home_bloc.dart';

class HomeTopCarouselSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (
        context,
        state,
      ) {
        if (state is HomeLoadedState) {
          return CarouselSlider(
            options: CarouselOptions(
              height: height * .25,
              autoPlay: true,
              viewportFraction: 1.1,
            ),
            items: state.homeModel.data.banners.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.network(
                        i.image,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              },
            ).toList(),
          );
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}
// ! Slivers should always be placed inside custom scroll view
// ! We cannot use standard widgets as slivers but use their sliver equivalent
// ! we defind sliver list or sliver grid interface which takes a delegate property
// ! it consists of SliverChildBuilderDelegate to build items on demand => listview.builder or SliverChildListDelegate => listview
// ! SliverToBoxAdapter to add one item
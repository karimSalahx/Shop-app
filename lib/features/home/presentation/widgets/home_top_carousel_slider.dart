import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_test/features/home/presentation/bloc/bloc/home_bloc.dart';

class HomeTopCarouselSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeBloc, HomeState>(builder: (
      context,
      state,
    ) {
      if (state is HomeLoadingState)
        return Center(
          child: CircularProgressIndicator(),
        );
      else if (state is HomeLoadedState) {
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
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Image.network(
                      i.image,
                    ),
                  );
                },
              );
            },
          ).toList(),
        );
      } else if (state is HomeErrorState) {
        return Center(
          child: Text(
            state.message,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      } else
        return Center(
          child: Text('Not working'),
        );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc/home_bloc.dart';

class HomeGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (
        context,
        state,
      ) {
        if (state is HomeLoadedState) {
          return Expanded(
            child: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent:
                    (height / 2.5) - (AppBar().preferredSize.height),
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => Stack(
                  children: [
                    Positioned.fill(
                      bottom: 0.0,
                      child: GridTile(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Image.network(
                                  state.homeModel.data.products[index].image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        state.homeModel.data.products[index]
                                            .name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              state.homeModel.data
                                                  .products[index].price
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              state.homeModel.data
                                                  .products[index].oldPrice
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.favorite_border_outlined,
                                              color: Colors.grey,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                childCount: state.homeModel.data.products.length,
              ),
            ),
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
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}

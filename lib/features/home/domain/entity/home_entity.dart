import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class HomeEntity extends Equatable {
  final bool status;
  final DataEntity data;

  HomeEntity({
    @required this.status,
    @required this.data,
  });

  @override
  List<Object> get props => [this.status, this.data];
}

@immutable
class DataEntity extends Equatable {
  final List<BannersEntity> banners;
  final List<ProductsEntity> products;
  final String ad;

  DataEntity({
    @required this.banners,
    @required this.products,
    @required this.ad,
  });

  @override
  List<Object> get props => [this.banners, this.products, this.ad];
}

@immutable
class BannersEntity extends Equatable {
  final int id;
  final String image;
  final CategoryEntity category;

  BannersEntity({
    @required this.id,
    @required this.image,
    @required this.category,
  });

  @override
  List<Object> get props => [this.id, this.image, this.category];
}

@immutable
class CategoryEntity extends Equatable {
  final int id;
  final String image;
  final String name;

  CategoryEntity({
    @required this.id,
    @required this.image,
    @required this.name,
  });

  @override
  List<Object> get props => [this.id, this.image, this.name];
}

@immutable
class ProductsEntity extends Equatable {
  final int id;
  final double price;
  final double oldPrice;
  final int discount;
  final String image;
  final String name;
  final String description;
  final List<String> images;
  final bool inFavorites;
  final bool inCart;

  ProductsEntity({
    @required this.id,
    @required this.price,
    @required this.oldPrice,
    @required this.discount,
    @required this.image,
    @required this.name,
    @required this.description,
    @required this.images,
    @required this.inFavorites,
    @required this.inCart,
  });

  @override
  List<Object> get props => [
        this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description,
        this.images,
        this.inFavorites,
        this.inCart,
      ];
}

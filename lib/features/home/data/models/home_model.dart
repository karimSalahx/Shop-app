import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class HomeModel extends Equatable {
  HomeModel({
    @required this.status,
    @required this.data,
  });

  final bool status;
  final DataModel data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        data: DataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };

  @override
  List<Object> get props => [this.status, this.data];
}

@immutable
class DataModel extends Equatable {
  DataModel({
    @required this.banners,
    @required this.products,
    @required this.ad,
  });

  final List<BannerModel> banners;
  final List<ProductModel> products;
  final String ad;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        banners: List<BannerModel>.from(
            json["banners"].map((x) => BannerModel.fromJson(x))),
        products: List<ProductModel>.from(
          json["products"].map(
            (x) => ProductModel.fromJson(x),
          ),
        ),
        ad: json["ad"],
      );

  Map<String, dynamic> toJson() => {
        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "ad": ad,
      };

  @override
  List<Object> get props => [this.banners, this.products, this.ad];
}

@immutable
class BannerModel extends Equatable {
  BannerModel({
    @required this.id,
    @required this.image,
    @required this.category,
  });

  final int id;
  final String image;
  final CategoryModel category;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        image: json["image"],
        category: CategoryModel.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "category": category.toJson(),
      };

  @override
  List<Object> get props => [this.id, this.image, this.category];
}

@immutable
class CategoryModel extends Equatable {
  CategoryModel({
    @required this.id,
    @required this.image,
    @required this.name,
  });

  final int id;
  final String image;
  final String name;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
      };

  @override
  List<Object> get props => [this.id, this.image, this.name];
}

@immutable
class ProductModel extends Equatable {
  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        price: json["price"].toDouble(),
        oldPrice: json["old_price"].toDouble(),
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        inFavorites: json["in_favorites"],
        inCart: json["in_cart"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
        "name": name,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "in_favorites": inFavorites,
        "in_cart": inCart,
      };

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

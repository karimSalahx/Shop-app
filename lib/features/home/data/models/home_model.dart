import 'package:meta/meta.dart';
import '../../domain/entity/home_entity.dart';

@immutable
class HomeModel extends HomeEntity {
  HomeModel({
    @required bool status,
    @required DataModel data,
  }) : super(status: status, data: data);

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        data: DataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": (data as DataModel).toJson(),
      };
}

@immutable
class DataModel extends DataEntity {
  DataModel({
    @required List<BannerModel> banners,
    @required List<ProductModel> products,
    @required String ad,
  }) : super(banners: banners, products: products, ad: ad);

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        banners: List<BannerModel>.from(
          json["banners"].map(
            (x) => BannerModel.fromJson(x),
          ),
        ),
        products: List<ProductModel>.from(
          json["products"].map(
            (x) => ProductModel.fromJson(x),
          ),
        ),
        ad: json["ad"],
      );

  Map<String, dynamic> toJson() => {
        "banners": List<dynamic>.from(
          banners.map(
            (x) => (x as BannerModel).toJson(),
          ),
        ),
        "products": List<dynamic>.from(
          products.map(
            (x) => (x as ProductModel).toJson(),
          ),
        ),
        "ad": ad,
      };

  @override
  List<Object> get props => [this.banners, this.products, this.ad];
}

@immutable
class BannerModel extends BannersEntity {
  BannerModel({
    @required int id,
    @required CategoryModel category,
    @required String image,
  }) : super(id: id, category: category, image: image);

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        image: json["image"],
        category: CategoryModel.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "category": (category as CategoryModel).toJson(),
      };
}

@immutable
class CategoryModel extends CategoryEntity {
  CategoryModel({
    @required int id,
    @required String image,
    @required String name,
  }) : super(id: id, image: image, name: name);

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
class ProductModel extends ProductsEntity {
  ProductModel({
    @required int id,
    @required double price,
    @required double oldPrice,
    @required int discount,
    @required String image,
    @required String name,
    @required String description,
    @required List<String> images,
    @required bool inFavorites,
    @required bool inCart,
  }) : super(
          description: description,
          discount: discount,
          id: id,
          image: image,
          images: images,
          inCart: inCart,
          inFavorites: inFavorites,
          name: name,
          oldPrice: oldPrice,
          price: price,
        );

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
}

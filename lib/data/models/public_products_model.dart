import 'dart:convert';


ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

class ProductResponse {
  bool? success;
  String? message;
  ProductDataWrapper? data;

  ProductResponse({this.success, this.message, this.data});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ProductDataWrapper.fromJson(json['data']) : null;
  }
}

class ProductDataWrapper {
  int? currentPage;
  List<Product>? data;

  ProductDataWrapper({this.currentPage, this.data});

  ProductDataWrapper.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  int? id;
  int? categoryId;
  int? subcategoryId;
  int? brandId;
  String? name;
  String? slug;
  String? price;
  String? discount;
  int? point;
  int? approvalStatus;
  bool? isActive;
  dynamic ratingsAvgRating;
  int? ratingsCount;
  Category? category;
  Subcategory? subcategory;
  Brand? brand;
  List<dynamic>? images;

  Product({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.brandId,
    this.name,
    this.slug,
    this.price,
    this.discount,
    this.point,
    this.approvalStatus,
    this.isActive,
    this.ratingsAvgRating,
    this.ratingsCount,
    this.category,
    this.subcategory,
    this.brand,
    this.images,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    brandId = json['brand_id'];
    name = json['name'];
    slug = json['slug'];
    // The API can return these as either JSON numbers or strings.
    price = json['price']?.toString();
    discount = json['discount']?.toString();
    point = json['point'];
    approvalStatus = json['approval_status'];
    isActive = json['is_active'];
    ratingsAvgRating = json['ratings_avg_rating'];
    ratingsCount = json['ratings_count'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    subcategory = json['subcategory'] != null ? Subcategory.fromJson(json['subcategory']) : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    if (json['images'] != null) {
      images = List<dynamic>.from(json['images']);
    }
  }
}

class Category {
  int? id;
  String? name;
  String? slug;

  Category({this.id, this.name, this.slug});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }
}

class Subcategory {
  int? id;
  String? name;

  Subcategory({this.id, this.name});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Brand {
  int? id;
  String? name;

  Brand({this.id, this.name});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

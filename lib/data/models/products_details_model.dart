class ProductDetails {
  bool? success;
  String? message;
  ProductDetailData? data;
  List<ProductDetailData>? categoryProducts; 

  ProductDetails({this.success, this.message, this.data, this.categoryProducts});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ProductDetailData.fromJson(json['data']) : null;
    if (json['category_products'] != null) {
      categoryProducts = <ProductDetailData>[];
      json['category_products'].forEach((v) {
        categoryProducts!.add(ProductDetailData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (categoryProducts != null) {
      data['category_products'] = categoryProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetailData {
  int? id;
  int? categoryId;
  int? subcategoryId;
  int? brandId;
  String? name;
  String? slug;
  String? sku;
  String? summary;
  String? description;
  String? purchasePrice;
  String? price;
  String? discount;
  int? stockQuantity;
  int? minStock;
  bool? isActive;
  int? approvalStatus;
  dynamic adminRemark; 
  bool? isFeatured;
  bool? isOnSale;
  String? metaTitle;
  String? metaDescription;
  String? metaKeywords;
  int? sv;
  int? point;
  int? totalClick;
  String? createdAt;
  String? updatedAt;
  dynamic ratingsAvgRating; 
  int? ratingsCount;
  Category? category;
  Category? subcategory;
  Category? brand;
  List<Variants>? variants;
  List<dynamic>? images; 

  ProductDetailData({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.brandId,
    this.name,
    this.slug,
    this.sku,
    this.summary,
    this.description,
    this.purchasePrice,
    this.price,
    this.discount,
    this.stockQuantity,
    this.minStock,
    this.isActive,
    this.approvalStatus,
    this.adminRemark,
    this.isFeatured,
    this.isOnSale,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.sv,
    this.point,
    this.totalClick,
    this.createdAt,
    this.updatedAt,
    this.ratingsAvgRating,
    this.ratingsCount,
    this.category,
    this.subcategory,
    this.brand,
    this.variants,
    this.images,
  });

  ProductDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    brandId = json['brand_id'];
    name = json['name'];
    slug = json['slug'];
    sku = json['sku'];
    summary = json['summary'];
    description = json['description'];
    purchasePrice = json['purchase_price'];
    price = json['price'];
    discount = json['discount'];
    stockQuantity = json['stock_quantity'];
    minStock = json['min_stock'];
    isActive = json['is_active'];
    approvalStatus = json['approval_status'];
    adminRemark = json['admin_remark'];
    isFeatured = json['is_featured'];
    isOnSale = json['is_on_sale'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    sv = json['sv'];
    point = json['point'];
    totalClick = json['total_click'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ratingsAvgRating = json['ratings_avg_rating'];
    ratingsCount = json['ratings_count'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    subcategory = json['subcategory'] != null ? Category.fromJson(json['subcategory']) : null;
    brand = json['brand'] != null ? Category.fromJson(json['brand']) : null;
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = List<dynamic>.from(json['images']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['subcategory_id'] = subcategoryId;
    data['brand_id'] = brandId;
    data['name'] = name;
    data['slug'] = slug;
    data['sku'] = sku;
    data['summary'] = summary;
    data['description'] = description;
    data['purchase_price'] = purchasePrice;
    data['price'] = price;
    data['discount'] = discount;
    data['stock_quantity'] = stockQuantity;
    data['min_stock'] = minStock;
    data['is_active'] = isActive;
    data['approval_status'] = approvalStatus;
    data['admin_remark'] = adminRemark;
    data['is_featured'] = isFeatured;
    data['is_on_sale'] = isOnSale;
    data['meta_title'] = metaTitle;
    data['meta_description'] = metaDescription;
    data['meta_keywords'] = metaKeywords;
    data['sv'] = sv;
    data['point'] = point;
    data['total_click'] = totalClick;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['ratings_avg_rating'] = ratingsAvgRating;
    data['ratings_count'] = ratingsCount;
    if (category != null) data['category'] = category!.toJson();
    if (subcategory != null) data['subcategory'] = subcategory!.toJson();
    if (brand != null) data['brand'] = brand!.toJson();
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images;
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Variants {
  int? id;
  int? productId;
  String? color;
  String? size;
  String? price;
  int? stockQuantity;
  String? discount;

  Variants({this.id, this.productId, this.color, this.size, this.price, this.stockQuantity, this.discount});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    color = json['color'];
    size = json['size'];
    price = json['price'];
    stockQuantity = json['stock_quantity'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['color'] = color;
    data['size'] = size;
    data['price'] = price;
    data['stock_quantity'] = stockQuantity;
    data['discount'] = discount;
    return data;
  }
}
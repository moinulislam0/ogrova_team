class GetCategoriesProductsModel {
  bool? success;
  String? message;
  CategoryDetail? category; 
  Products? products;

  GetCategoriesProductsModel({this.success, this.message, this.category, this.products});

  GetCategoriesProductsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    category = json['category'] != null ? CategoryDetail.fromJson(json['category']) : null;
    products = json['products'] != null ? Products.fromJson(json['products']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (products != null) {
      data['products'] = products!.toJson();
    }
    return data;
  }
}

class CategoryDetail {
  int? id;
  String? name;
  String? slug;
  String? image; 
  String? metaTitle;
  String? metaDescription;
  String? metaKeywords;
  String? ogTitle;
  String? ogDescription;
  String? ogImage; 
  String? canonicalUrl;
  String? robots;
  bool? indexable;

  CategoryDetail({
    this.id, this.name, this.slug, this.image, this.metaTitle,
    this.metaDescription, this.metaKeywords, this.ogTitle,
    this.ogDescription, this.ogImage, this.canonicalUrl,
    this.robots, this.indexable,
  });

  CategoryDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    ogTitle = json['og_title'];
    ogDescription = json['og_description'];
    ogImage = json['og_image'];
    canonicalUrl = json['canonical_url'];
    robots = json['robots'];
    indexable = json['indexable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    data['meta_title'] = metaTitle;
    data['meta_description'] = metaDescription;
    data['meta_keywords'] = metaKeywords;
    data['og_title'] = ogTitle;
    data['og_description'] = ogDescription;
    data['og_image'] = ogImage;
    data['canonical_url'] = canonicalUrl;
    data['robots'] = robots;
    data['indexable'] = indexable;
    return data;
  }
}

class Products {
  int? currentPage;
  List<ProductData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Products({
    this.currentPage, this.data, this.firstPageUrl, this.from,
    this.lastPage, this.lastPageUrl, this.links, this.nextPageUrl,
    this.path, this.perPage, this.prevPageUrl, this.to, this.total,
  });

  Products.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = <String, dynamic>{};
    res['current_page'] = currentPage;
    if (data != null) {
      res['data'] = data!.map((v) => v.toJson()).toList();
    }
    res['first_page_url'] = firstPageUrl;
    res['from'] = from;
    res['last_page'] = lastPage;
    res['last_page_url'] = lastPageUrl;
    if (links != null) {
      res['links'] = links!.map((v) => v.toJson()).toList();
    }
    res['next_page_url'] = nextPageUrl;
    res['path'] = path;
    res['per_page'] = perPage;
    res['prev_page_url'] = prevPageUrl;
    res['to'] = to;
    res['total'] = total;
    return res;
  }
}

class ProductData {
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
  String? adminRemark;
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
  SimpleCategory? category;
  SimpleCategory? subcategory;
  SimpleCategory? brand;
  List<Variants>? variants;
  List<dynamic>? images; 

  ProductData({
    this.id, this.categoryId, this.subcategoryId, this.brandId, this.name,
    this.slug, this.sku, this.summary, this.description, this.purchasePrice,
    this.price, this.discount, this.stockQuantity, this.minStock, this.isActive,
    this.approvalStatus, this.adminRemark, this.isFeatured, this.isOnSale,
    this.metaTitle, this.metaDescription, this.metaKeywords, this.sv,
    this.point, this.totalClick, this.createdAt, this.updatedAt,
    this.ratingsAvgRating, this.ratingsCount, this.category,
    this.subcategory, this.brand, this.variants, this.images,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
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
    category = json['category'] != null ? SimpleCategory.fromJson(json['category']) : null;
    subcategory = json['subcategory'] != null ? SimpleCategory.fromJson(json['subcategory']) : null;
    brand = json['brand'] != null ? SimpleCategory.fromJson(json['brand']) : null;
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
    images = json['images'] != null ? List<dynamic>.from(json['images']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    if (category != null) data['category'] = category!.toJson();
    if (subcategory != null) data['subcategory'] = subcategory!.toJson();
    if (brand != null) data['brand'] = brand!.toJson();
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    data['images'] = images;
    return data;
  }
}

class SimpleCategory {
  int? id;
  String? name;

  SimpleCategory({this.id, this.name});

  SimpleCategory.fromJson(Map<String, dynamic> json) {
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
  String? discount;
  int? stockQuantity;
  String? sku;
  String? createdAt;
  String? updatedAt;

  Variants({
    this.id, this.productId, this.color, this.size, this.price,
    this.discount, this.stockQuantity, this.sku, this.createdAt, this.updatedAt,
  });

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    color = json['color'];
    size = json['size'];
    price = json['price'];
    discount = json['discount'];
    stockQuantity = json['stock_quantity'];
    sku = json['sku'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['color'] = color;
    data['size'] = size;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
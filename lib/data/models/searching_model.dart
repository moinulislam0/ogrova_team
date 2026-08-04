class SearchModel {
  int? currentPage;
  List<Data>? data;
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

  SearchModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  SearchModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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
    prevPageUrl = json['prev_page_url']?.toString();
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
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
  String? adminRemark; // Null? থেকে String? করা হয়েছে
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
  dynamic ratingsAvgRating; // ratings হতে পারে double বা int তাই dynamic
  int? ratingsCount;
  Category? category;
  Subcategory? subcategory;
  Subcategory? brand;
  List<dynamic>? images; // List<Null>? থেকে List<dynamic>? করা হয়েছে

  Data({
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
    this.images,
  });

  Data.fromJson(Map<String, dynamic> json) {
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
    subcategory = json['subcategory'] != null ? Subcategory.fromJson(json['subcategory']) : null;
    brand = json['brand'] != null ? Subcategory.fromJson(json['brand']) : null;
    
    // Images parsing ঠিক করা হয়েছে
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
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (subcategory != null) {
      data['subcategory'] = subcategory!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
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
  String? slug;

  Category({this.id, this.name, this.slug});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
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
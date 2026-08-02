class GetCategoriesModel {
  bool? success;
  List<Data>? data;

  GetCategoriesModel({this.success, this.data});

  GetCategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['success'] = success;
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    return dataMap;
  }
}

class Data {
  int? id;
  String? name;
  String? slug;
  String? description;
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
  int? sortOrder;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.ogTitle,
    this.ogDescription,
    this.ogImage,
    this.canonicalUrl,
    this.robots,
    this.indexable,
    this.sortOrder,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
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
    sortOrder = json['sort_order'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
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
    data['sort_order'] = sortOrder;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
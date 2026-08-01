class ShoppingCartModel {
  String? message;
  String? reg;
  List<CartData>? data;

  ShoppingCartModel({this.message, this.reg, this.data});

  ShoppingCartModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    reg = json['reg'];
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data!.add(CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['reg'] = reg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  int? id;
  String? reg;
  int? productId;
  int? variantId;
  int? userId;
  int? quantity;
  String? price;
  String? discount;
  String? payableAmount;
  int? point;
  String? note; // Changed from Null? to String?
  String? createdAt;
  String? updatedAt;
  Product? product;
  Variant? variant;
  User? user;

  CartData({
    this.id,
    this.reg,
    this.productId,
    this.variantId,
    this.userId,
    this.quantity,
    this.price,
    this.discount,
    this.payableAmount,
    this.point,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.variant,
    this.user,
  });

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reg = json['reg'];
    productId = json['product_id'];
    variantId = json['variant_id'];
    userId = json['user_id'];
    quantity = json['quantity'];
    price = json['price']?.toString();
    discount = json['discount']?.toString();
    payableAmount = json['payable_amount']?.toString();
    point = json['point'];
    note = json['note']?.toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    variant = json['variant'] != null ? Variant.fromJson(json['variant']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  /// Values returned by the cart API are per unit. These getters ensure the
  /// card and order summary use the selected quantity consistently.
  int get effectiveQuantity =>
      (quantity != null && quantity! > 0) ? quantity! : 1;

  double get unitPayableAmount {
    final payable = double.tryParse(payableAmount ?? '');
    if (payable != null) return payable;

    final originalPrice = double.tryParse(price ?? '') ?? 0;
    final savedAmount = double.tryParse(discount ?? '') ?? 0;
    return originalPrice - savedAmount;
  }

  double get totalPayableAmount => unitPayableAmount * effectiveQuantity;

  int get totalPoints => (point ?? 0) * effectiveQuantity;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reg'] = reg;
    data['product_id'] = productId;
    data['variant_id'] = variantId;
    data['user_id'] = userId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['discount'] = discount;
    data['payable_amount'] = payableAmount;
    data['point'] = point;
    data['note'] = note;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) data['product'] = product!.toJson();
    if (variant != null) data['variant'] = variant!.toJson();
    if (user != null) data['user'] = user!.toJson();
    return data;
  }
}

class Product {
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
  String? adminRemark; // Changed from Null? to String?
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
  List<dynamic>? images; // Changed from List<Null>? to List<dynamic>?

  Product({
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
    this.images,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    brandId = json['brand_id'];
    name = json['name'];
    slug = json['slug'];
    sku = json['sku'];
    summary = json['summary'];
    description = json['description'];
    purchasePrice = json['purchase_price']?.toString();
    price = json['price']?.toString();
    discount = json['discount']?.toString();
    stockQuantity = json['stock_quantity'];
    minStock = json['min_stock'];
    isActive = json['is_active'];
    approvalStatus = json['approval_status'];
    adminRemark = json['admin_remark']?.toString();
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
    data['images'] = images;
    return data;
  }
}

class Variant {
  int? id;
  int? productId;
  String? color;
  String? size;
  String? price;
  String? discount;
  int? stockQuantity;
  String? sku; // Changed from Null? to String?
  String? createdAt;
  String? updatedAt;

  Variant({
    this.id,
    this.productId,
    this.color,
    this.size,
    this.price,
    this.discount,
    this.stockQuantity,
    this.sku,
    this.createdAt,
    this.updatedAt,
  });

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    color = json['color'];
    size = json['size'];
    price = json['price']?.toString();
    discount = json['discount']?.toString();
    stockQuantity = json['stock_quantity'];
    sku = json['sku']?.toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'color': color,
      'size': size,
      'price': price,
      'discount': discount,
      'stock_quantity': stockQuantity,
      'sku': sku,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? userId;
  String? phone;
  String? photo;
  String? dob;
  String? gender;
  String? bloodGroup;
  String? role;
  bool? isActive;
  String? walletBalance;
  String? createdAt;
  String? updatedAt;
  // ... other fields can be added as String? if needed

  User({
    this.id,
    this.name,
    this.email,
    this.userId,
    this.phone,
    this.photo,
    this.dob,
    this.gender,
    this.bloodGroup,
    this.role,
    this.isActive,
    this.walletBalance,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userId = json['user_id'];
    phone = json['phone'];
    photo = json['photo']?.toString();
    dob = json['dob'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    role = json['role'];
    isActive = json['is_active'];
    walletBalance = json['wallet_balance']?.toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'user_id': userId,
      'phone': phone,
      'photo': photo,
      'dob': dob,
      'gender': gender,
      'blood_group': bloodGroup,
      'role': role,
      'is_active': isActive,
      'wallet_balance': walletBalance,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

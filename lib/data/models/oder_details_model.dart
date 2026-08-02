class OrderDetailsModel {
  bool? success;
  String? message;
  PaginatedData? data;

  OrderDetailsModel({this.success, this.message, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? PaginatedData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PaginatedData {
  int? currentPage;
  List<Order>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  PaginatedData({
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

  PaginatedData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Order>[];
      json['data'].forEach((v) {
        data!.add(Order.fromJson(v));
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

class Order {
  int? id;
  String? reg;
  String? slug;
  String? date;
  int? userId;
  dynamic couponId;
  dynamic couponCode;
  String? amount;
  String? couponDiscount;
  String? shippingCharge;
  String? tax;
  String? discount;
  String? payableAmount;
  String? paidAmount;
  String? dueAmount;
  String? currency;
  int? point;
  String? paymentMethod;
  String? paymentStatus;
  dynamic paidAt;
  dynamic submittedAt;
  String? status;
  bool? referralBonusPaid;
  String? contactName;
  String? contactNumber;
  String? contactEmail;
  String? shippingAddress;
  int? divisionId;
  int? districtId;
  int? upazilaId;
  int? policeStationId;
  String? postalCode;
  dynamic remarks;
  dynamic processingAt;
  dynamic pickedAt;
  dynamic confirmedAt;
  dynamic shippedAt;
  dynamic deliveredAt;
  dynamic cancelledAt;
  String? ipAddress;
  String? userAgent;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  User? user;
  dynamic coupon;
  Division? division;
  District? district;
  Upazila? upazila;
  PoliceStation? policeStation;
  dynamic payment;
  List<Items>? items;

  Order({
    this.id,
    this.reg,
    this.slug,
    this.date,
    this.userId,
    this.couponId,
    this.couponCode,
    this.amount,
    this.couponDiscount,
    this.shippingCharge,
    this.tax,
    this.discount,
    this.payableAmount,
    this.paidAmount,
    this.dueAmount,
    this.currency,
    this.point,
    this.paymentMethod,
    this.paymentStatus,
    this.paidAt,
    this.submittedAt,
    this.status,
    this.referralBonusPaid,
    this.contactName,
    this.contactNumber,
    this.contactEmail,
    this.shippingAddress,
    this.divisionId,
    this.districtId,
    this.upazilaId,
    this.policeStationId,
    this.postalCode,
    this.remarks,
    this.processingAt,
    this.pickedAt,
    this.confirmedAt,
    this.shippedAt,
    this.deliveredAt,
    this.cancelledAt,
    this.ipAddress,
    this.userAgent,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.coupon,
    this.division,
    this.district,
    this.upazila,
    this.policeStation,
    this.payment,
    this.items,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reg = json['reg'];
    slug = json['slug'];
    date = json['date'];
    userId = json['user_id'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    amount = json['amount'];
    couponDiscount = json['coupon_discount'];
    shippingCharge = json['shipping_charge'];
    tax = json['tax'];
    discount = json['discount'];
    payableAmount = json['payable_amount'];
    paidAmount = json['paid_amount'];
    dueAmount = json['due_amount'];
    currency = json['currency'];
    point = json['point'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    paidAt = json['paid_at'];
    submittedAt = json['submitted_at'];
    status = json['status'];
    referralBonusPaid = json['referral_bonus_paid'];
    contactName = json['contact_name'];
    contactNumber = json['contact_number'];
    contactEmail = json['contact_email'];
    shippingAddress = json['shipping_address'];
    divisionId = json['division_id'];
    districtId = json['district_id'];
    upazilaId = json['upazila_id'];
    policeStationId = json['police_station_id'];
    postalCode = json['postal_code'];
    remarks = json['remarks'];
    processingAt = json['processing_at'];
    pickedAt = json['picked_at'];
    confirmedAt = json['confirmed_at'];
    shippedAt = json['shipped_at'];
    deliveredAt = json['delivered_at'];
    cancelledAt = json['cancelled_at'];
    ipAddress = json['ip_address'];
    userAgent = json['user_agent'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    coupon = json['coupon'];
    division = json['division'] != null ? Division.fromJson(json['division']) : null;
    district = json['district'] != null ? District.fromJson(json['district']) : null;
    upazila = json['upazila'] != null ? Upazila.fromJson(json['upazila']) : null;
    policeStation = json['police_station'] != null ? PoliceStation.fromJson(json['police_station']) : null;
    payment = json['payment'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reg'] = reg;
    data['slug'] = slug;
    data['date'] = date;
    data['user_id'] = userId;
    data['coupon_id'] = couponId;
    data['coupon_code'] = couponCode;
    data['amount'] = amount;
    data['coupon_discount'] = couponDiscount;
    data['shipping_charge'] = shippingCharge;
    data['tax'] = tax;
    data['discount'] = discount;
    data['payable_amount'] = payableAmount;
    data['paid_amount'] = paidAmount;
    data['due_amount'] = dueAmount;
    data['currency'] = currency;
    data['point'] = point;
    data['payment_method'] = paymentMethod;
    data['payment_status'] = paymentStatus;
    data['paid_at'] = paidAt;
    data['submitted_at'] = submittedAt;
    data['status'] = status;
    data['referral_bonus_paid'] = referralBonusPaid;
    data['contact_name'] = contactName;
    data['contact_number'] = contactNumber;
    data['contact_email'] = contactEmail;
    data['shipping_address'] = shippingAddress;
    data['division_id'] = divisionId;
    data['district_id'] = districtId;
    data['upazila_id'] = upazilaId;
    data['police_station_id'] = policeStationId;
    data['postal_code'] = postalCode;
    data['remarks'] = remarks;
    data['processing_at'] = processingAt;
    data['picked_at'] = pickedAt;
    data['confirmed_at'] = confirmedAt;
    data['shipped_at'] = shippedAt;
    data['delivered_at'] = deliveredAt;
    data['cancelled_at'] = cancelledAt;
    data['ip_address'] = ipAddress;
    data['user_agent'] = userAgent;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['coupon'] = coupon;
    if (division != null) {
      data['division'] = division!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (upazila != null) {
      data['upazila'] = upazila!.toJson();
    }
    if (policeStation != null) {
      data['police_station'] = policeStation!.toJson();
    }
    data['payment'] = payment;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? userId;
  String? phone;
  dynamic photo;
  dynamic vendorsId;
  String? dob;
  String? gender;
  String? bloodGroup;
  dynamic nationalId;
  dynamic religion;
  String? role;
  dynamic designation;
  bool? isActive;
  int? isProfileCompleted;
  String? presentAddress;
  String? permanentAddress;
  dynamic emailVerifiedAt;
  dynamic phoneVerifiedAt;
  dynamic otpExpiresAt;
  dynamic facebookId;
  dynamic googleId;
  dynamic githubId;
  String? lastLoginAt;
  String? lastLoginIp;
  String? walletBalance;
  dynamic referId;
  int? isMatch;
  String? rank;
  dynamic parentId;
  dynamic leftChildId;
  dynamic rightChildId;
  int? leftTotalPoint;
  int? rightTotalPoint;
  int? leftCarryPoint;
  int? rightCarryPoint;
  int? ownTotalPoint;
  int? totalMatch;
  String? createdAt;
  String? updatedAt;
  String? bonusBalance;
  int? totalPoints;
  int? totalOwnPoints;
  int? totalCalculation;

  User({
    this.id,
    this.name,
    this.email,
    this.userId,
    this.phone,
    this.photo,
    this.vendorsId,
    this.dob,
    this.gender,
    this.bloodGroup,
    this.nationalId,
    this.religion,
    this.role,
    this.designation,
    this.isActive,
    this.isProfileCompleted,
    this.presentAddress,
    this.permanentAddress,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.otpExpiresAt,
    this.facebookId,
    this.googleId,
    this.githubId,
    this.lastLoginAt,
    this.lastLoginIp,
    this.walletBalance,
    this.referId,
    this.isMatch,
    this.rank,
    this.parentId,
    this.leftChildId,
    this.rightChildId,
    this.leftTotalPoint,
    this.rightTotalPoint,
    this.leftCarryPoint,
    this.rightCarryPoint,
    this.ownTotalPoint,
    this.totalMatch,
    this.createdAt,
    this.updatedAt,
    this.bonusBalance,
    this.totalPoints,
    this.totalOwnPoints,
    this.totalCalculation,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userId = json['user_id'];
    phone = json['phone'];
    photo = json['photo'];
    vendorsId = json['vendors_id'];
    dob = json['dob'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    nationalId = json['national_id'];
    religion = json['religion'];
    role = json['role'];
    designation = json['designation'];
    isActive = json['is_active'];
    isProfileCompleted = json['is_profile_completed'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    otpExpiresAt = json['otp_expires_at'];
    facebookId = json['facebook_id'];
    googleId = json['google_id'];
    githubId = json['github_id'];
    lastLoginAt = json['last_login_at'];
    lastLoginIp = json['last_login_ip'];
    walletBalance = json['wallet_balance'];
    referId = json['refer_id'];
    isMatch = json['is_match'];
    rank = json['rank'];
    parentId = json['parent_id'];
    leftChildId = json['left_child_id'];
    rightChildId = json['right_child_id'];
    leftTotalPoint = json['left_total_point'];
    rightTotalPoint = json['right_total_point'];
    leftCarryPoint = json['left_carry_point'];
    rightCarryPoint = json['right_carry_point'];
    ownTotalPoint = json['own_total_point'];
    totalMatch = json['total_match'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bonusBalance = json['bonus_balance'];
    totalPoints = json['total_points'];
    totalOwnPoints = json['total_own_points'];
    totalCalculation = json['total_calculation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['user_id'] = userId;
    data['phone'] = phone;
    data['photo'] = photo;
    data['vendors_id'] = vendorsId;
    data['dob'] = dob;
    data['gender'] = gender;
    data['blood_group'] = bloodGroup;
    data['national_id'] = nationalId;
    data['religion'] = religion;
    data['role'] = role;
    data['designation'] = designation;
    data['is_active'] = isActive;
    data['is_profile_completed'] = isProfileCompleted;
    data['present_address'] = presentAddress;
    data['permanent_address'] = permanentAddress;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['otp_expires_at'] = otpExpiresAt;
    data['facebook_id'] = facebookId;
    data['google_id'] = googleId;
    data['github_id'] = githubId;
    data['last_login_at'] = lastLoginAt;
    data['last_login_ip'] = lastLoginIp;
    data['wallet_balance'] = walletBalance;
    data['refer_id'] = referId;
    data['is_match'] = isMatch;
    data['rank'] = rank;
    data['parent_id'] = parentId;
    data['left_child_id'] = leftChildId;
    data['right_child_id'] = rightChildId;
    data['left_total_point'] = leftTotalPoint;
    data['right_total_point'] = rightTotalPoint;
    data['left_carry_point'] = leftCarryPoint;
    data['right_carry_point'] = rightCarryPoint;
    data['own_total_point'] = ownTotalPoint;
    data['total_match'] = totalMatch;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['bonus_balance'] = bonusBalance;
    data['total_points'] = totalPoints;
    data['total_own_points'] = totalOwnPoints;
    data['total_calculation'] = totalCalculation;
    return data;
  }
}

class Division {
  int? id;
  String? name;
  String? bnName;
  String? url;
  String? createdAt;
  String? updatedAt;

  Division({this.id, this.name, this.bnName, this.url, this.createdAt, this.updatedAt});

  Division.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bnName = json['bn_name'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['bn_name'] = bnName;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class District {
  int? id;
  int? divisionId;
  String? name;
  String? bnName;
  String? url;
  String? createdAt;
  String? updatedAt;

  District({this.id, this.divisionId, this.name, this.bnName, this.url, this.createdAt, this.updatedAt});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    divisionId = json['division_id'];
    name = json['name'];
    bnName = json['bn_name'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['division_id'] = divisionId;
    data['name'] = name;
    data['bn_name'] = bnName;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Upazila {
  int? id;
  int? divisionId;
  int? districtId;
  dynamic upazilaId;
  String? name;
  String? bnName;
  String? url;
  String? createdAt;
  String? updatedAt;

  Upazila({this.id, this.divisionId, this.districtId, this.upazilaId, this.name, this.bnName, this.url, this.createdAt, this.updatedAt});

  Upazila.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    divisionId = json['division_id'];
    districtId = json['district_id'];
    upazilaId = json['upazila_id'];
    name = json['name'];
    bnName = json['bn_name'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['division_id'] = divisionId;
    data['district_id'] = districtId;
    data['upazila_id'] = upazilaId;
    data['name'] = name;
    data['bn_name'] = bnName;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PoliceStation {
  int? id;
  int? divisionId;
  int? districtId;
  int? upazilaId;
  String? name;
  String? bnName;
  dynamic url;
  String? createdAt;
  String? updatedAt;

  PoliceStation({this.id, this.divisionId, this.districtId, this.upazilaId, this.name, this.bnName, this.url, this.createdAt, this.updatedAt});

  PoliceStation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    divisionId = json['division_id'];
    districtId = json['district_id'];
    upazilaId = json['upazila_id'];
    name = json['name'];
    bnName = json['bn_name'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['division_id'] = divisionId;
    data['district_id'] = districtId;
    data['upazila_id'] = upazilaId;
    data['name'] = name;
    data['bn_name'] = bnName;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Items {
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
  dynamic note;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Items({this.id, this.reg, this.productId, this.variantId, this.userId, this.quantity, this.price, this.discount, this.payableAmount, this.point, this.note, this.createdAt, this.updatedAt, this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reg = json['reg'];
    productId = json['product_id'];
    variantId = json['variant_id'];
    userId = json['user_id'];
    quantity = json['quantity'];
    price = json['price'];
    discount = json['discount'];
    payableAmount = json['payable_amount'];
    point = json['point'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

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
    if (product != null) {
      data['product'] = product!.toJson();
    }
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
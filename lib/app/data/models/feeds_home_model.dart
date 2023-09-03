class FeedsHome {
  int? id;
  int? userId;
  String? description;
  String? location;
  String? type;
  String? title;
  String? meetingPoint;
  String? include;
  String? exclude;
  String? others;
  String? categoryId;
  String? dateStart;
  String? dateEnd;
  int? fee;
  int? maxPerson;
  String? paymentAccount;
  String? createdAt;
  String? updatedAt;
  List<FeedImage>? feedImage;
  UserHome? user;
  List<FeedsHomeLikes>? feedsLikes;
  List<FeedsHomeLikes>? feedsSaves;
  List<FeedsHomeLikes>? feedsJoin;

  FeedsHome(
      {this.id,
      this.userId,
      this.description,
      this.location,
        this.title,
        this.type,
        this.meetingPoint,
        this.include,
        this.exclude,
        this.others,
        this.categoryId,
        this.dateStart,
        this.dateEnd,
        this.fee,
        this.maxPerson,
        this.paymentAccount,
      this.createdAt,
      this.updatedAt,
      this.feedImage,
      this.user,
      this.feedsLikes,
      this.feedsSaves});

  FeedsHome.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    userId = json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null;
    description = json['description'];
    location = json['location'];
    type = json['type'];
    title = json['title'];
    meetingPoint = json['meetingPoint'];
    include = json['include'];
    exclude = json['exclude'];
    others = json['others'];
    categoryId = json['category_id'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    fee = json['fee'];
    maxPerson = json['max_person'];
    paymentAccount = json['payment_account'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['feed_image'] != null) {
      feedImage = <FeedImage>[];
      json['feed_image'].forEach((v) {
        feedImage?.add(FeedImage.fromJson(v));
      });
    }
    user = json['user'] != null ? UserHome?.fromJson(json['user']) : null;
    if (json['feeds_likes'] != null) {
      feedsLikes = <FeedsHomeLikes>[];
      json['feeds_likes'].forEach((v) {
        feedsLikes?.add(FeedsHomeLikes.fromJson(v));
      });
    }
    if (json['feeds_saves'] != null) {
      feedsSaves = <FeedsHomeLikes>[];
      json['feeds_saves'].forEach((v) {
        feedsSaves?.add(FeedsHomeLikes.fromJson(v));
      });
    }
    if (json['feeds_join'] != null) {
      feedsJoin = <FeedsHomeLikes>[];
      json['feeds_join'].forEach((v) {
        feedsJoin?.add(FeedsHomeLikes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['description'] = description;
    data['location'] = location;
    data['type'] = type;
    data['title'] = title;
    data['include'] = include;
    data['exclude'] = exclude;
    data['others'] = others;
    data['category_id'] = categoryId;
    data['date_start'] = dateStart;
    data['date_end'] = dateEnd;
    data['fee'] = fee;
    data['max_person'] = maxPerson;
    data['payment_account'] = paymentAccount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (feedImage != null) {
      data['feed_image'] = feedImage?.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user?.toJson();
    }
    if (feedsLikes != null) {
      data['feeds_likes'] = feedsLikes?.map((v) => v.toJson()).toList();
    }else{
      data['feeds_likes'] = [];
    }
    if (feedsSaves != null) {
      data['feeds_saves'] = feedsSaves?.map((v) => v.toJson()).toList();
    }else {
      data['feeds_saves'] = [];
    }
    if (feedsJoin != null) {
      data['feeds_join'] = feedsJoin?.map((v) => v.toJson()).toList();
    }else {
      data['feeds_join'] = [];
    }
    return data;
  }
}

class FeedImage {
  int? id;
  int? feedId;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  FeedImage(
      {this.id, this.feedId, this.imageUrl, this.createdAt, this.updatedAt});

  FeedImage.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    feedId = json['feed_id'] != null ? int.tryParse(json['feed_id'].toString()) : null;
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['feed_id'] = feedId;
    data['image_url'] = imageUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UserHome {
  int? id;
  String? name;
  dynamic username;
  String? email;
  String? emailVerifiedAt;
  dynamic birthdate;
  dynamic bio;
  dynamic links;
  dynamic phoneNumber;
  String? otpCode;
  dynamic twoFactorConfirmedAt;
  dynamic currentTeamId;
  dynamic profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  String? role;
  String? file;
  String? profilePhotoUrl;

  UserHome(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.emailVerifiedAt,
      this.birthdate,
      this.bio,
      this.links,
      this.phoneNumber,
      this.otpCode,
      this.twoFactorConfirmedAt,
      this.currentTeamId,
      this.profilePhotoPath,
      this.createdAt,
      this.updatedAt,
      this.role,
      this.file,
      this.profilePhotoUrl});

  UserHome.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    birthdate = json['birthdate'];
    bio = json['bio'];
    links = json['links'];
    phoneNumber = json['phone_number'];
    otpCode = json['otp_code'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
    file = json['file'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['birthdate'] = birthdate;
    data['bio'] = bio;
    data['links'] = links;
    data['phone_number'] = phoneNumber;
    data['otp_code'] = otpCode;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['current_team_id'] = currentTeamId;
    data['profile_photo_path'] = profilePhotoPath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['role'] = role;
    data['file'] = file;
    data['profile_photo_url'] = profilePhotoUrl;
    return data;
  }
}

class FeedsHomeLikes {
  int? id;
  int? feedId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  FeedsHomeLikes(
      {this.id, this.feedId, this.userId, this.createdAt, this.updatedAt});

  FeedsHomeLikes.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    feedId = json['feed_id'] != null ? int.tryParse(json['feed_id'].toString()) : null;
    userId = json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['feed_id'] = feedId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

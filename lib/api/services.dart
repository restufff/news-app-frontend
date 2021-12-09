import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.name,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.image,
    this.articles,
    this.categoryId,
  });

  String id;
  String name;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  CategoryImage image;
  List<Article> articles;
  String categoryId;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        image: CategoryImage.fromJson(json["image"]),
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
        categoryId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "published_at": publishedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "image": image.toJson(),
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
        "id": categoryId,
      };
}

class Article {
  Article({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.content,
    this.articlePublishedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.image,
    this.category,
    this.articleId,
  });

  String id;
  String title;
  String description;
  DateTime publishedAt;
  String content;
  DateTime articlePublishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  ArticleImage image;
  String category;
  String articleId;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
        articlePublishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        image: ArticleImage.fromJson(json["image"]),
        category: json["category"],
        articleId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "publishedAt":
            "${publishedAt.year.toString().padLeft(4, '0')}-${publishedAt.month.toString().padLeft(2, '0')}-${publishedAt.day.toString().padLeft(2, '0')}",
        "content": content,
        "published_at": articlePublishedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "image": image.toJson(),
        "category": category,
        "id": articleId,
      };
}

class ArticleImage {
  ArticleImage({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.width,
    this.height,
    this.url,
    this.providerMetadata,
    this.formats,
    this.provider,
    this.related,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.imageId,
  });

  String id;
  String name;
  String alternativeText;
  String caption;
  String hash;
  Ext ext;
  Mime mime;
  double size;
  int width;
  int height;
  String url;
  ProviderMetadata providerMetadata;
  PurpleFormats formats;
  String provider;
  List<String> related;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String imageId;

  factory ArticleImage.fromJson(Map<String, dynamic> json) => ArticleImage(
        id: json["_id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
        size: json["size"].toDouble(),
        width: json["width"],
        height: json["height"],
        url: json["url"],
        providerMetadata: ProviderMetadata.fromJson(json["provider_metadata"]),
        formats: PurpleFormats.fromJson(json["formats"]),
        provider: json["provider"],
        related: List<String>.from(json["related"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        imageId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "width": width,
        "height": height,
        "url": url,
        "provider_metadata": providerMetadata.toJson(),
        "formats": formats.toJson(),
        "provider": provider,
        "related": List<dynamic>.from(related.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": imageId,
      };
}

enum Ext { JPEG, JPG, PNG }

final extValues =
    EnumValues({".jpeg": Ext.JPEG, ".jpg": Ext.JPG, ".png": Ext.PNG});

class PurpleFormats {
  PurpleFormats({
    this.thumbnail,
    this.small,
    this.medium,
  });

  Thumbnail thumbnail;
  Thumbnail small;
  Thumbnail medium;

  factory PurpleFormats.fromJson(Map<String, dynamic> json) => PurpleFormats(
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        small: Thumbnail.fromJson(json["small"]),
        medium:
            json["medium"] == null ? null : Thumbnail.fromJson(json["medium"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "small": small.toJson(),
        "medium": medium == null ? null : medium.toJson(),
      };
}

class Thumbnail {
  Thumbnail({
    this.name,
    this.hash,
    this.ext,
    this.mime,
    this.width,
    this.height,
    this.size,
    this.path,
    this.url,
    this.providerMetadata,
  });

  String name;
  String hash;
  Ext ext;
  Mime mime;
  int width;
  int height;
  double size;
  dynamic path;
  String url;
  ProviderMetadata providerMetadata;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        name: json["name"],
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
        providerMetadata: ProviderMetadata.fromJson(json["provider_metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
        "provider_metadata": providerMetadata.toJson(),
      };
}

enum Mime { IMAGE_JPEG, IMAGE_PNG }

final mimeValues =
    EnumValues({"image/jpeg": Mime.IMAGE_JPEG, "image/png": Mime.IMAGE_PNG});

class ProviderMetadata {
  ProviderMetadata({
    this.publicId,
    this.resourceType,
  });

  String publicId;
  ResourceType resourceType;

  factory ProviderMetadata.fromJson(Map<String, dynamic> json) =>
      ProviderMetadata(
        publicId: json["public_id"],
        resourceType: resourceTypeValues.map[json["resource_type"]],
      );

  Map<String, dynamic> toJson() => {
        "public_id": publicId,
        "resource_type": resourceTypeValues.reverse[resourceType],
      };
}

enum ResourceType { IMAGE }

final resourceTypeValues = EnumValues({"image": ResourceType.IMAGE});

class CategoryImage {
  CategoryImage({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.width,
    this.height,
    this.url,
    this.providerMetadata,
    this.formats,
    this.provider,
    this.related,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.imageId,
  });

  String id;
  String name;
  String alternativeText;
  String caption;
  String hash;
  Ext ext;
  Mime mime;
  double size;
  int width;
  int height;
  String url;
  ProviderMetadata providerMetadata;
  FluffyFormats formats;
  String provider;
  List<String> related;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String imageId;

  factory CategoryImage.fromJson(Map<String, dynamic> json) => CategoryImage(
        id: json["_id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
        size: json["size"].toDouble(),
        width: json["width"],
        height: json["height"],
        url: json["url"],
        providerMetadata: ProviderMetadata.fromJson(json["provider_metadata"]),
        formats: FluffyFormats.fromJson(json["formats"]),
        provider: json["provider"],
        related: List<String>.from(json["related"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        imageId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "width": width,
        "height": height,
        "url": url,
        "provider_metadata": providerMetadata.toJson(),
        "formats": formats.toJson(),
        "provider": provider,
        "related": List<dynamic>.from(related.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": imageId,
      };
}

class FluffyFormats {
  FluffyFormats({
    this.thumbnail,
  });

  Thumbnail thumbnail;

  factory FluffyFormats.fromJson(Map<String, dynamic> json) => FluffyFormats(
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

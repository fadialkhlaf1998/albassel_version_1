import 'dart:convert';

class Collections {
  Collections({
    this.smartCollections,
  });

  List<Collection>? smartCollections;

  factory Collections.fromJson(String str) => Collections.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Collections.fromMap(Map<String, dynamic> json) => Collections(
    smartCollections: List<Collection>.from(json["smart_collections"].map((x) => Collection.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "smart_collections": List<dynamic>.from(smartCollections!.map((x) => x.toMap())),
  };
}

class Collection {
  Collection({
    this.id,
    this.handle,
    this.title,
    this.updatedAt,
    this.bodyHtml,
    this.publishedAt,
    this.sortOrder,
    this.templateSuffix,
    this.disjunctive,
    this.rules,
    this.publishedScope,
    this.adminGraphqlApiId,
    this.image,
  });

  int? id;
  String? handle;
  String? title;
  String? updatedAt;
  String? bodyHtml;
  String? publishedAt;
  String? sortOrder;
  String? templateSuffix;
  bool? disjunctive;
  List<Rule>? rules;
  String? publishedScope;
  String? adminGraphqlApiId;
  CollectionImage? image;

  factory Collection.fromJson(String str) => Collection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Collection.fromMap(Map<String, dynamic> json) => Collection(
    id: json["id"],
    handle: json["handle"],
    title: json["title"],
    updatedAt: json["updated_at"],
    bodyHtml: json["body_html"],
    publishedAt: json["published_at"],
    sortOrder: json["sort_order"],
    templateSuffix: json["template_suffix"],
    disjunctive: json["disjunctive"],
    rules: List<Rule>.from(json["rules"].map((x) => Rule.fromMap(x))),
    publishedScope: json["published_scope"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
    image: json["image"]==null?null:CollectionImage.fromMap(json["image"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "handle": handle,
    "title": title,
    "updated_at": updatedAt,
    "body_html": bodyHtml,
    "published_at": publishedAt,
    "sort_order": sortOrder,
    "template_suffix": templateSuffix,
    "disjunctive": disjunctive,
    "rules": List<dynamic>.from(rules!.map((x) => x.toMap())),
    "published_scope": publishedScope,
    "admin_graphql_api_id": adminGraphqlApiId,
    "image": image!.toMap(),
  };
}

class CollectionImage {
  CollectionImage({
    this.createdAt,
    this.alt,
    this.width,
    this.height,
    this.src,
  });

  String? createdAt;
  dynamic? alt;
  int? width;
  int? height;
  String? src;

  factory CollectionImage.fromJson(String str) => CollectionImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CollectionImage.fromMap(Map<String, dynamic> json) => CollectionImage(
    createdAt: json["created_at"],
    alt: json["alt"],
    width: json["width"],
    height: json["height"],
    src: json["src"],
  );

  Map<String, dynamic> toMap() => {
    "created_at": createdAt,
    "alt": alt,
    "width": width,
    "height": height,
    "src": src,
  };
}

class Rule {
  Rule({
    this.column,
    this.relation,
    this.condition,
  });

  String? column;
  String? relation;
  String? condition;

  factory Rule.fromJson(String str) => Rule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rule.fromMap(Map<String, dynamic> json) => Rule(
    column: json["column"],
    relation: json["relation"],
    condition: json["condition"],
  );

  Map<String, dynamic> toMap() => {
    "column": column,
    "relation": relation,
    "condition": condition,
  };
}

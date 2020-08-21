// To parse this JSON data, do
//
//     final catalogModel = catalogModelFromJson(jsonString);

import 'dart:convert';

CatalogModel catalogModelFromJson(String str) => CatalogModel.fromJson(json.decode(str));

String catalogModelToJson(CatalogModel data) => json.encode(data.toJson());

class CatalogModel {
    CatalogModel({
        this.sections,
        this.categories,
        this.products,
        this.farmers,
    });

    final List<Item> sections;
    final List<Category> categories;
    final List<Product> products;
    final List<Item> farmers;

    CatalogModel copyWith({
        List<Item> sections,
        List<Category> categories,
        List<Product> products,
        List<Item> farmers,
    }) => 
        CatalogModel(
            sections: sections ?? this.sections,
            categories: categories ?? this.categories,
            products: products ?? this.products,
            farmers: farmers ?? this.farmers,
        );

    factory CatalogModel.fromJson(Map<String, dynamic> json) => CatalogModel(
        sections: List<Item>.from(json["sections"].map((x) => Item.fromJson(x))),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        farmers: List<Item>.from(json["farmers"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "farmers": List<dynamic>.from(farmers.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.id,
        this.sectionId,
        this.title,
        this.icon,
    });

    final int id;
    final int sectionId;
    final String title;
    final String icon;

    Category copyWith({
        int id,
        int sectionId,
        String title,
        String icon,
    }) => 
        Category(
            id: id ?? this.id,
            sectionId: sectionId ?? this.sectionId,
            title: title ?? this.title,
            icon: icon ?? this.icon,
        );

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        sectionId: json["sectionId"],
        title: json["title"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sectionId": sectionId,
        "title": title,
        "icon": icon,
    };
}

class Item {
    Item({
        this.id,
        this.title,
    });

    final int id;
    final String title;

    Item copyWith({
        int id,
        String title,
    }) => 
        Item(
            id: id ?? this.id,
            title: title ?? this.title,
        );

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}

class Product {
    Product({
        this.id,
        this.sectionId,
        this.categoryId,
        this.farmerId,
        this.title,
        this.unit,
        this.totalRating,
        this.ratingCount,
        this.image,
        this.shortDescription,
        this.description,
        this.price,
        this.characteristics,
        this.isFavourite,
    });

    final int id;
    final int sectionId;
    final int categoryId;
    final int farmerId;
    final String title;
    final String unit;
    final num totalRating;
    final int ratingCount;
    final String image;
    final String shortDescription;
    final String description;
    final num price;
    final List<Characteristic> characteristics;
    final bool isFavourite;

    Product copyWith({
        int id,
        int sectionId,
        int categoryId,
        int farmerId,
        String title,
        String unit,
        num totalRating,
        int ratingCount,
        String image,
        String shortDescription,
        String description,
        num price,
        List<Characteristic> characteristics,
        bool isFavourite,
    }) => 
        Product(
            id: id ?? this.id,
            sectionId: sectionId ?? this.sectionId,
            categoryId: categoryId ?? this.categoryId,
            farmerId: farmerId ?? this.farmerId,
            title: title ?? this.title,
            unit: unit ?? this.unit,
            totalRating: totalRating ?? this.totalRating,
            ratingCount: ratingCount ?? this.ratingCount,
            image: image ?? this.image,
            shortDescription: shortDescription ?? this.shortDescription,
            description: description ?? this.description,
            price: price ?? this.price,
            characteristics: characteristics ?? this.characteristics,
            isFavourite: isFavourite ?? this.isFavourite,
        );

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        sectionId: json["sectionId"],
        categoryId: json["categoryId"],
        farmerId: json["farmerId"],
        title: json["title"],
        unit: json["unit"],
        totalRating: json["totalRating"],
        ratingCount: json["ratingCount"],
        image: json["image"],
        shortDescription: json["shortDescription"],
        description: json["description"],
        price: json["price"],
        characteristics: List<Characteristic>.from(json["characteristics"].map((x) => Characteristic.fromJson(x))),
        isFavourite: false,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sectionId": sectionId,
        "categoryId": categoryId,
        "farmerId": farmerId,
        "title": title,
        "unit": unit,
        "totalRating": totalRating,
        "ratingCount": ratingCount,
        "image": image,
        "shortDescription": shortDescription,
        "description": description,
        "price": price,
        "characteristics": List<dynamic>.from(characteristics.map((x) => x.toJson())),
    };
}

class Characteristic {
    Characteristic({
        this.title,
        this.value,
    });

    final String title;
    final String value;

    Characteristic copyWith({
        String title,
        String value,
    }) => 
        Characteristic(
            title: title ?? this.title,
            value: value ?? this.value,
        );

    factory Characteristic.fromJson(Map<String, dynamic> json) => Characteristic(
        title: json["title"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
    };
}

double checkDouble(dynamic value) {
  if (value is String) {
    return double.parse(value);
  } else {
    return value;
  }
}

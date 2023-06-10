import 'dart:convert';

class CategoryModel {
  String? id;
  String imageUrl;
  String name;
  CategoryModel({required this.imageUrl, required this.name, this.id});

  Map<String, dynamic> toMap() {
    return {
      'categoryImage': imageUrl,
      'categoryName': name,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        imageUrl: map['categoryImage'] ?? '',
        name: map['categoryName'] ?? '',
        id: map['categoryId'] ?? ' ');
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}

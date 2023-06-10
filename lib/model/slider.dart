import 'dart:convert';

class Slider {
  String? id;
  String? imageUrl;
  String? title;
  Slider({
    this.imageUrl,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
    };
  }

  factory Slider.fromMap(Map<String, dynamic> map) {
    return Slider(
      imageUrl: map['imageUrl'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Slider.fromJson(String source) => Slider.fromMap(json.decode(source));
}

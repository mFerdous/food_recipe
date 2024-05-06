class FoodRecipeSearchResponseModel {
  final List<Result>? results;
  final int? offset;
  final int? number;
  final int? totalResults;

  FoodRecipeSearchResponseModel({
    this.results,
    this.offset,
    this.number,
    this.totalResults,
  });

  factory FoodRecipeSearchResponseModel.fromJson(Map<String, dynamic> json) =>
      FoodRecipeSearchResponseModel(
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        offset: json["offset"],
        number: json["number"],
        totalResults: json["totalResults"],
      );
}

class Result {
  final int? id;
  final String? title;
  final String? image;
  final String? imageType;

  Result({
    this.id,
    this.title,
    this.image,
    this.imageType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imageType: json["imageType"],
      );


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'imageType': imageType
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      imageType: map['imageType']
    );
  }

}

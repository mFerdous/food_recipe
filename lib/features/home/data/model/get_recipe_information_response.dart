class GetRecipeInformationResponseModel {
  final bool? vegetarian;
  final bool? vegan;
  final bool? glutenFree;
  final bool? dairyFree;
  final bool? veryHealthy;
  final bool? cheap;
  final bool? veryPopular;
  final bool? sustainable;
  final bool? lowFodmap;
  final int? weightWatcherSmartPoints;
  final String? gaps;
  final int? preparationMinutes;
  final int? cookingMinutes;
  final int? aggregateLikes;
  final int? healthScore;
  final String? creditsText;
  final String? sourceName;
  final double? pricePerServing;
  final List<ExtendedIngredient>? extendedIngredients;
  final int? id;
  final String? title;
  final int? readyInMinutes;
  final int? servings;
  final String? sourceUrl;
  final String? image;
  final String? imageType;
  final Taste? taste;
  final String? summary;
  final List<dynamic>? cuisines;
  final List<String>? dishTypes;
  final List<String>? diets;
  final List<String>? occasions;
  final WinePairing? winePairing;
  final String? instructions;
  final List<AnalyzedInstruction>? analyzedInstructions;
  final dynamic originalId;
  final double? spoonacularScore;

  GetRecipeInformationResponseModel({
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.lowFodmap,
    this.weightWatcherSmartPoints,
    this.gaps,
    this.preparationMinutes,
    this.cookingMinutes,
    this.aggregateLikes,
    this.healthScore,
    this.creditsText,
    this.sourceName,
    this.pricePerServing,
    this.extendedIngredients,
    this.id,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.image,
    this.imageType,
    this.taste,
    this.summary,
    this.cuisines,
    this.dishTypes,
    this.diets,
    this.occasions,
    this.winePairing,
    this.instructions,
    this.analyzedInstructions,
    this.originalId,
    this.spoonacularScore,
  });

  factory GetRecipeInformationResponseModel.fromJson(Map<String, dynamic> json) =>
      GetRecipeInformationResponseModel(
        vegetarian: json["vegetarian"],
        vegan: json["vegan"],
        glutenFree: json["glutenFree"],
        dairyFree: json["dairyFree"],
        veryHealthy: json["veryHealthy"],
        cheap: json["cheap"],
        veryPopular: json["veryPopular"],
        sustainable: json["sustainable"],
        lowFodmap: json["lowFodmap"],
        weightWatcherSmartPoints: json["weightWatcherSmartPoints"],
        gaps: json["gaps"],
        preparationMinutes: json["preparationMinutes"],
        cookingMinutes: json["cookingMinutes"],
        aggregateLikes: json["aggregateLikes"],
        healthScore: json["healthScore"],
        creditsText: json["creditsText"],
        sourceName: json["sourceName"],
        pricePerServing: json["pricePerServing"]?.toDouble(),
        extendedIngredients: json["extendedIngredients"] == null
            ? []
            : List<ExtendedIngredient>.from(json["extendedIngredients"]!
                .map((x) => ExtendedIngredient.fromJson(x))),
        id: json["id"],
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        servings: json["servings"],
        sourceUrl: json["sourceUrl"],
        image: json["image"],
        imageType: json["imageType"],
        taste: json["taste"] == null ? null : Taste.fromJson(json["taste"]),
        summary: json["summary"],
        cuisines: json["cuisines"] == null
            ? []
            : List<dynamic>.from(json["cuisines"]!.map((x) => x)),
        dishTypes: json["dishTypes"] == null
            ? []
            : List<String>.from(json["dishTypes"]!.map((x) => x)),
        diets: json["diets"] == null
            ? []
            : List<String>.from(json["diets"]!.map((x) => x)),
        occasions: json["occasions"] == null
            ? []
            : List<String>.from(json["occasions"]!.map((x) => x)),
        winePairing: json["winePairing"] == null
            ? null
            : WinePairing.fromJson(json["winePairing"]),
        instructions: json["instructions"],
        analyzedInstructions: json["analyzedInstructions"] == null
            ? []
            : List<AnalyzedInstruction>.from(json["analyzedInstructions"]!
                .map((x) => AnalyzedInstruction.fromJson(x))),
        originalId: json["originalId"],
        spoonacularScore: json["spoonacularScore"]?.toDouble(),
      );
}

class AnalyzedInstruction {
  final String? name;
  final List<Step>? steps;

  AnalyzedInstruction({
    this.name,
    this.steps,
  });

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) =>
      AnalyzedInstruction(
        name: json["name"],
        steps: json["steps"] == null
            ? []
            : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
      );
}

class Step {
  final int? number;
  final String? step;
  final List<IngrNEquip>? ingredients;
  final List<IngrNEquip>? equipment;

  Step({
    this.number,
    this.step,
    this.ingredients,
    this.equipment,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        number: json["number"],
        step: json["step"],
        ingredients: json["ingredients"] == null
            ? []
            : List<IngrNEquip>.from(
                json["ingredients"]!.map((x) => IngrNEquip.fromJson(x))),
        equipment: json["equipment"] == null
            ? []
            : List<IngrNEquip>.from(
                json["equipment"]!.map((x) => IngrNEquip.fromJson(x))),
      );
}

class IngrNEquip {
  final int? id;
  final String? name;
  final String? localizedName;
  final String? image;

  IngrNEquip({
    this.id,
    this.name,
    this.localizedName,
    this.image,
  });

  factory IngrNEquip.fromJson(Map<String, dynamic> json) => IngrNEquip(
        id: json["id"],
        name: json["name"],
        localizedName: json["localizedName"],
        image: json["image"],
      );
}

class ExtendedIngredient {
  final int? id;
  final String? aisle;
  final String? image;
  final String? consistency;
  final String? name;
  final String? nameClean;
  final String? original;
  final String? originalName;
  final double? amount;
  final String? unit;
  final List<dynamic>? meta;
  final Measures? measures;

  ExtendedIngredient({
    this.id,
    this.aisle,
    this.image,
    this.consistency,
    this.name,
    this.nameClean,
    this.original,
    this.originalName,
    this.amount,
    this.unit,
    this.meta,
    this.measures,
  });

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) =>
      ExtendedIngredient(
        id: json["id"],
        aisle: json["aisle"],
        image: json["image"],
        consistency: json["consistency"],
        name: json["name"],
        nameClean: json["nameClean"],
        original: json["original"],
        originalName: json["originalName"],
        amount: json["amount"]?.toDouble(),
        unit: json["unit"],
        meta: json["meta"] == null
            ? []
            : List<dynamic>.from(json["meta"]!.map((x) => x)),
        measures: json["measures"] == null
            ? null
            : Measures.fromJson(json["measures"]),
      );
}

class Measures {
  final Metric? us;
  final Metric? metric;

  Measures({
    this.us,
    this.metric,
  });

  factory Measures.fromJson(Map<String, dynamic> json) => Measures(
        us: json["us"] == null ? null : Metric.fromJson(json["us"]),
        metric: json["metric"] == null ? null : Metric.fromJson(json["metric"]),
      );
}

class Metric {
  final double? amount;
  final String? unitShort;
  final String? unitLong;

  Metric({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
        amount: json["amount"]?.toDouble(),
        unitShort: json["unitShort"],
        unitLong: json["unitLong"],
      );
}

class Taste {
  final double? sweetness;
  final double? saltiness;
  final double? sourness;
  final double? bitterness;
  final double? savoriness;
  final double? fattiness;
  final double? spiciness;

  Taste({
    this.sweetness,
    this.saltiness,
    this.sourness,
    this.bitterness,
    this.savoriness,
    this.fattiness,
    this.spiciness,
  });

  factory Taste.fromJson(Map<String, dynamic> json) => Taste(
        sweetness: json["sweetness"]?.toDouble(),
        saltiness: json["saltiness"]?.toDouble(),
        sourness: json["sourness"]?.toDouble(),
        bitterness: json["bitterness"]?.toDouble(),
        savoriness: json["savoriness"]?.toDouble(),
        fattiness: json["fattiness"]?.toDouble(),
        spiciness: json["spiciness"]?.toDouble(),
      );
}

class WinePairing {
  final List<String>? pairedWines;
  final String? pairingText;
  final List<ProductMatch>? productMatches;

  WinePairing({
    this.pairedWines,
    this.pairingText,
    this.productMatches,
  });

  factory WinePairing.fromJson(Map<String, dynamic> json) => WinePairing(
        pairedWines: json["pairedWines"] == null
            ? []
            : List<String>.from(json["pairedWines"]!.map((x) => x)),
        pairingText: json["pairingText"],
        productMatches: json["productMatches"] == null
            ? []
            : List<ProductMatch>.from(
                json["productMatches"]!.map((x) => ProductMatch.fromJson(x))),
      );
}

class ProductMatch {
  final int? id;
  final String? title;
  final String? description;
  final String? price;
  final String? imageUrl;
  final double? averageRating;
  final double? ratingCount;
  final double? score;
  final String? link;

  ProductMatch({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.averageRating,
    this.ratingCount,
    this.score,
    this.link,
  });

  factory ProductMatch.fromJson(Map<String, dynamic> json) => ProductMatch(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        imageUrl: json["imageUrl"],
        averageRating: json["averageRating"]?.toDouble(),
        ratingCount: json["ratingCount"]?.toDouble(),
        score: json["score"]?.toDouble(),
        link: json["link"],
      );
}

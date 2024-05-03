import '../../data/model/food_recipe_search_response.dart';

abstract class FoodRecipeSearchRepository {
  Future<FoodRecipeSearchResponseModel> repository(String query, int offset);
}



import '../../data/model/food_recipe_search_response.dart';
import '../repository/food_recipe_search_repository.dart';

class FoodRecipeSearchUsecase {
  final FoodRecipeSearchRepository _foodRecipeSearchRepository;

  FoodRecipeSearchUsecase(this._foodRecipeSearchRepository);

  Future<FoodRecipeSearchResponseModel> call(String query, int offset) =>
      _foodRecipeSearchRepository.repository(query, offset);
}

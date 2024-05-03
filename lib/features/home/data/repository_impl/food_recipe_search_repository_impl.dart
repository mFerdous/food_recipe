import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/repository/food_recipe_search_repository.dart';
import '../model/food_recipe_search_response.dart';
import '../remote/food_recipe_search_remote.dart';

class FoodRecipeSearchRepositoryImpl implements FoodRecipeSearchRepository {
  final ConnectionChecker connectionChecker;
  final FoodRecipeSearchRemote foodRecipeSearchRemote;

  FoodRecipeSearchRepositoryImpl(
    this.connectionChecker,
    this.foodRecipeSearchRemote,
  );

  @override
  Future<FoodRecipeSearchResponseModel> repository(String query, int offset) async {
    if (!await connectionChecker.isConnected()) throw NoInternetException();
    FoodRecipeSearchResponseModel foodRecipeSearchResponse =
        await foodRecipeSearchRemote.foodRecipeSearch(query, offset);
    return foodRecipeSearchResponse;
  }
}

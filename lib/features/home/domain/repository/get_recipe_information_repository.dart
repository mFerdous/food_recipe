import '../../data/model/get_recipe_information_response.dart';

abstract class GetRecipeInformationRepository {
  Future<GetRecipeInformationResponseModel> repository(
      int id);
}



import '../../data/model/get_recipe_information_response.dart';
import '../repository/get_recipe_information_repository.dart';

class GetRecipeInformationUsecase {
  final GetRecipeInformationRepository _getRecipeInformationRepository;

  GetRecipeInformationUsecase(this._getRecipeInformationRepository);

  Future<GetRecipeInformationResponseModel> call(int id) =>
      _getRecipeInformationRepository.repository(id);
}

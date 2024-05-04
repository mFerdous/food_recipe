import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/repository/get_recipe_information_repository.dart';
import '../model/get_recipe_information_response.dart';
import '../remote/get_recipe_information_remote.dart';

class GetRecipeInformationRepositoryImpl implements GetRecipeInformationRepository {
  final ConnectionChecker connectionChecker;
  final GetRecipeInformationRemote getRecipeInformationRemote;

  GetRecipeInformationRepositoryImpl(
    this.connectionChecker,
    this.getRecipeInformationRemote,
  );

  @override
  Future<GetRecipeInformationResponseModel> repository(int id) async {
    if (!await connectionChecker.isConnected()) throw NoInternetException();
    GetRecipeInformationResponseModel getRecipeInformationResponse =
        await getRecipeInformationRemote.getRecipeDetailInformation(id);
    return getRecipeInformationResponse;
  }
}

// ignore_for_file: empty_catches

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/get_recipe_information_response.dart';
import '../../domain/usecase/get_recipe_information_usecase.dart';

part 'get_recipe_information_state.dart';

class GetRecipeInformationCubit extends Cubit<GetRecipeInformationState> {
  final GetRecipeInformationUsecase getRecipeInformationUsecase;

  GetRecipeInformationCubit({
    required this.getRecipeInformationUsecase,
  }) : super(GetRecipeInformationInitial());

  Future<void> getGetRecipeInformation(int id) async {
    try {
      emit(GetRecipeInformationLoading());

      final responseModel = await getRecipeInformationUsecase(id);

      emit(GetRecipeInformationSucceed(model: responseModel));
    } catch (ex, strackTrace) {
      emit(GetRecipeInformationFailed(ex, strackTrace));
    }
  }
}

// ignore_for_file: empty_catches

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/food_recipe_search_response.dart';
import '../../domain/usecase/food_recipe_search_usecase.dart';

part 'food_recipe_search_state.dart';

class FoodRecipeSearchCubit extends Cubit<FoodRecipeSearchState> {
  final FoodRecipeSearchUsecase foodRecipeSearchUsecase;

  FoodRecipeSearchCubit({
    required this.foodRecipeSearchUsecase,
  }) : super(FoodRecipeSearchInitial());

  Future<void> getFoodRecipeSearch(String query, int offset) async {
    try {
      emit(FoodRecipeSearchLoading());

      final responseModel = await foodRecipeSearchUsecase(query, offset);

      emit(FoodRecipeSearchSucceed(model: responseModel));
    } catch (ex, strackTrace) {
      emit(FoodRecipeSearchFailed(ex, strackTrace));
    }
  }
}

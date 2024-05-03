import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/food_recipe_search_response.dart';
import '../cubit/food_recipe_search_cubit.dart';

part 'food_recipe_search_logic_state.dart';

class FoodRecipeSearchLogicCubit extends Cubit<FoodRecipeSearchLogicState> {
  FoodRecipeSearchLogicCubit() : super(const FoodRecipeSearchLogicInitial(results: []));

  void clearFoodRecipeSearchState() {
    emit(const FoodRecipeSearchLogicInitial(results: []));
  }

  void changeSelectedIndex(int selectedIndex) {
    emit(
      state.copyWith(selectedIndex: selectedIndex),
    );
  }

  void changeQuery(String value) {
    emit(
      state.copyWith(query: value),
    );
  }

  Future<void> getFoodRecipeSearch(context) async {
    await BlocProvider.of<FoodRecipeSearchCubit>(context)
        .getFoodRecipeSearch(state.query ?? '', state.offset ?? 0);
  }

  void updateFoodRecipeSearchResult(List<Result> results) {
    emit(state.copyWith(results: results));
  }
}

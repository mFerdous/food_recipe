import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/nums.dart';
import '../../data/model/food_recipe_search_response.dart';
import '../cubit/food_recipe_search_cubit.dart';

part 'food_recipe_search_logic_state.dart';

class FoodRecipeSearchLogicCubit extends Cubit<FoodRecipeSearchLogicState> {
  FoodRecipeSearchLogicCubit()
      : super(const FoodRecipeSearchLogicInitial(results: []));

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
        .getFoodRecipeSearch(state.query ?? '', offset);
  }

  void addFoodRecipeSearchResult(List<Result> newResults) {
    emit(state.copyWith(results: newResults));
  }

  void updateFoodRecipeSearchResult(List<Result> newResults) {
    final results = List<Result>.from(state.results);

    results.addAll(newResults);


    emit(state.copyWith(results: results));
  }

  void initialBookmark(List<String> bookmarkList) {
    emit(state.copyWith(bookmarkList: bookmarkList));
  }

  Future<void> changeBookmark(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final bookmarkList = List<String>.from(state.bookmarkList ?? []);

    if (bookmarkList.contains(val.toString())) {
      bookmarkList.remove(val.toString());
      prefs.setStringList('listKey', bookmarkList);
    } else {
      bookmarkList.add(val.toString());
      prefs.setStringList('listKey', bookmarkList);
    }

    emit(
      state.copyWith(bookmarkList: bookmarkList),
    );
  }
}

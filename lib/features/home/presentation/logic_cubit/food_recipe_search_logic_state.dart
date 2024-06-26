// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'food_recipe_search_logic_cubit.dart';

class FoodRecipeSearchLogicState extends Equatable {
  final String? query;
  final List<Result> results;
  final List<Result> offlineResults;
  final int selectedIndex;
  final List<String>? bookmarkList;
  final List<GetRecipeInformationResponseModel>? model;

  const FoodRecipeSearchLogicState({
    this.query,
    required this.results,
    required this.offlineResults,
    this.selectedIndex = 0,
    this.bookmarkList,
    this.model,
  });

  FoodRecipeSearchLogicState copyWith({
    final String? query,
    final List<Result>? results,
    final List<Result>? offlineResults,
    final int? selectedIndex,
    final List<String>? bookmarkList,
    final List<GetRecipeInformationResponseModel>? model,
  }) {
    return FoodRecipeSearchLogicState(
      query: query ?? this.query,
      results: results ?? this.results,
      offlineResults: offlineResults ?? this.offlineResults,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      bookmarkList: bookmarkList ?? this.bookmarkList,
      model: model ?? model,
    );
  }

  @override
  List<Object?> get props => [
        query,
        results,
        offlineResults,
        selectedIndex,
        bookmarkList,
        model,
      ];
}

class FoodRecipeSearchLogicInitial extends FoodRecipeSearchLogicState {
  const FoodRecipeSearchLogicInitial({required super.results, required super.offlineResults});
}

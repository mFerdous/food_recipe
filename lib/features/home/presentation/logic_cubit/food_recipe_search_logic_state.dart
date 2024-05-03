// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'food_recipe_search_logic_cubit.dart';

class FoodRecipeSearchLogicState extends Equatable {
  final String? query;
  final int? offset;
  final List<Result> results;
  final int selectedIndex;
  final List<String>? bookmarkList;

  const FoodRecipeSearchLogicState({
    this.query,
    this.offset,
    required this.results,
    this.selectedIndex = 0,
    this.bookmarkList,
  });

  FoodRecipeSearchLogicState copyWith({
    final String? query,
    final int? offset,
    final List<Result>? results,
    final int? selectedIndex,
    final List<String>? bookmarkList,
  }) {
    return FoodRecipeSearchLogicState(
      query: query ?? this.query,
      offset: offset ?? this.offset,
      results: results ?? this.results,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      bookmarkList: bookmarkList ?? this.bookmarkList,
    );
  }

  @override
  List<Object?> get props => [
        query,
        offset,
        results,
        selectedIndex,
        bookmarkList,
      ];
}

class FoodRecipeSearchLogicInitial extends FoodRecipeSearchLogicState {
  const FoodRecipeSearchLogicInitial({required super.results});
}

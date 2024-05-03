// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'food_recipe_search_logic_cubit.dart';

class FoodRecipeSearchLogicState extends Equatable {
  final String? query;
  final int? offset;
  final List<Result> results;
  final int selectedIndex;

  const FoodRecipeSearchLogicState({
    this.query,
    this.offset,
    required this.results,
    this.selectedIndex = 0,
  });

  FoodRecipeSearchLogicState copyWith({
    final String? query,
    final int? offset,
    final List<Result>? results,
    final int? selectedIndex,
  }) {
    return FoodRecipeSearchLogicState(
      query: query ?? this.query,
      offset: offset ?? this.offset,
      results: results ?? this.results,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [
        query,
        offset,
        results,
        selectedIndex,
      ];
}

class FoodRecipeSearchLogicInitial extends FoodRecipeSearchLogicState {
  const FoodRecipeSearchLogicInitial({required super.results});
}

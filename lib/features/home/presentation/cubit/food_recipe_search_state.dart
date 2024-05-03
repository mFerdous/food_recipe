part of 'food_recipe_search_cubit.dart';

abstract class FoodRecipeSearchState extends Equatable {
  const FoodRecipeSearchState();

  @override
  List<Object> get props => [];
}

class FoodRecipeSearchInitial extends FoodRecipeSearchState {}

class FoodRecipeSearchLoading extends FoodRecipeSearchState {}

class FoodRecipeSearchFailed extends FoodRecipeSearchState {
  final StackTrace stackTrace;
  final Object exception;

  const FoodRecipeSearchFailed(this.exception, this.stackTrace);
}

class FoodRecipeSearchSucceed extends FoodRecipeSearchState {
  final FoodRecipeSearchResponseModel model;

  const FoodRecipeSearchSucceed({
    required this.model,
  });
}


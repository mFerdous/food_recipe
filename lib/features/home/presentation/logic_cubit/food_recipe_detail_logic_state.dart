// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'food_recipe_detail_logic_cubit.dart';

class FoodRecipeDetailLogicState extends Equatable {
  final List<GetRecipeInformationResponseModel> modelList;
  final GetRecipeInformationResponseModel? model;

  const FoodRecipeDetailLogicState({
    required this.modelList,
    this.model,
  });

  FoodRecipeDetailLogicState copyWith({
    final List<GetRecipeInformationResponseModel>? modelList,
  final GetRecipeInformationResponseModel? model,

  }) {
    return FoodRecipeDetailLogicState(
      model: model ?? this.model,
      modelList: modelList ?? this.modelList,
    );
  }

  @override
  List<Object?> get props => [
        model,
        modelList,
      ];
}

class FoodRecipeDetailLogicInitial extends FoodRecipeDetailLogicState {
  const FoodRecipeDetailLogicInitial({required super.modelList});
}

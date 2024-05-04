import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/get_recipe_information_response.dart';
import '../cubit/get_recipe_information_cubit.dart';

part 'food_recipe_detail_logic_state.dart';

class FoodRecipeDetailLogicCubit extends Cubit<FoodRecipeDetailLogicState> {
  FoodRecipeDetailLogicCubit()
      : super(const FoodRecipeDetailLogicInitial(modelList: []));

  void clearFoodDetailSearchState() {
    emit(const FoodRecipeDetailLogicInitial(modelList: []));
  }

  Future<void> getRecipeInformation(context, int id) async {
    await BlocProvider.of<GetRecipeInformationCubit>(context)
        .getGetRecipeInformation(id);
  }

  void recipeDetailInformationResult(GetRecipeInformationResponseModel model) {
    final modelList =
        List<GetRecipeInformationResponseModel>.from(state.modelList);

    modelList.add(model);

    emit(state.copyWith(
      modelList: modelList,
      model: model,
      ));
  }
}

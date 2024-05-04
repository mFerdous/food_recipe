part of 'get_recipe_information_cubit.dart';

abstract class GetRecipeInformationState extends Equatable {
  const GetRecipeInformationState();

  @override
  List<Object> get props => [];
}

class GetRecipeInformationInitial extends GetRecipeInformationState {}

class GetRecipeInformationLoading extends GetRecipeInformationState {}

class GetRecipeInformationFailed extends GetRecipeInformationState {
  final StackTrace stackTrace;
  final Object exception;

  const GetRecipeInformationFailed(this.exception, this.stackTrace);
}

class GetRecipeInformationSucceed extends GetRecipeInformationState {
  final GetRecipeInformationResponseModel model;

  const GetRecipeInformationSucceed({
    required this.model,
  });
}


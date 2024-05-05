// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food_recipe/features/home/presentation/logic_cubit/food_recipe_detail_logic_cubit.dart';

import '../../data/model/get_recipe_information_response.dart';

class RecipeInformationWidget extends StatelessWidget {
  final GetRecipeInformationResponseModel detail;
  const RecipeInformationWidget({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.antiAlias,
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                detail.image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 15,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: _buildIconContainer('assets/vectors/vector_5_x2.svg'),
            ),
          ),
          Positioned(
            top: 30,
            right: 15,
            child: _buildIconContainer('assets/vectors/vector_2_x2.svg'),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 180,
            child: _buildContentContainer(detail),
          ),
        ],
      ),
    );
  }

  Widget _buildIconContainer(String iconPath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      width: 32,
      height: 32,
      padding: const EdgeInsets.all(8),
      child: SvgPicture.asset(iconPath),
    );
  }

  Widget _buildContentContainer(
    GetRecipeInformationResponseModel detail,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    child: Text(
                      detail.title!,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color(0xFF3A3A3B),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2, right: 4),
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          width: 16,
                          height: 16,
                          padding: const EdgeInsets.all(1.3),
                          child: SvgPicture.asset(
                            'assets/vectors/time.svg',
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '${detail.preparationMinutes} min',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0xFF3A3A3B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _buildIngredientList(detail.extendedIngredients),
            _buildStepList(detail),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientList(List<ExtendedIngredient>? ingredients) {
    return Container(
      height: 200,
      margin: const EdgeInsets.fromLTRB(0, 3.5, 6, 3.5),
      child: ListView.separated(
        itemCount: ingredients?.length ?? 0,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF2EACAA),
                ),
                child: const SizedBox(
                  width: 2,
                  height: 14,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(ingredients![index].name!),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStepList(GetRecipeInformationResponseModel detail) {
    return Container(
      height: 300,
      margin: const EdgeInsets.fromLTRB(0, 3.5, 6, 3.5),
      child: detail.analyzedInstructions != null &&
              detail.analyzedInstructions!.isNotEmpty
          ? ListView.separated(
              itemCount: detail.analyzedInstructions![0].steps!.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) {
                final step = detail.analyzedInstructions![0].steps![index];
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Step ${step.number}',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xFF2EACAA),
                        ),
                      ),
                    ),
                    Text(step.step!),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(step.ingredients![0].image!),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : SizedBox(
              height: 300,
              child: Text(detail.instructions ?? ''),
            ),
    );
  }
}

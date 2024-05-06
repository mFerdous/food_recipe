import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe/features/home/data/model/food_recipe_search_response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/navigation/route_name.dart';
import '../../../../core/resources/error_msg_res.dart';
import '../../../../core/utils/nums.dart';
import '../../../common/presentation/widgets/app_dialog.dart';
import '../../data/database/database_helper.dart';
import '../cubit/get_recipe_information_cubit.dart';
import '../logic_cubit/food_recipe_detail_logic_cubit.dart';
import '../logic_cubit/food_recipe_search_logic_cubit.dart';

class SavedPageWidget extends StatefulWidget {
  SavedPageWidget({super.key});

  @override
  State<SavedPageWidget> createState() => _SavedPageWidgetState();
}

class _SavedPageWidgetState extends State<SavedPageWidget> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  insertDB(id, title, image, imageType) async {
    final checkId = await databaseHelper.isIdAlreadyInserted(id);

    if (checkId == false) {
      final results =
          Result(id: id, title: title, image: image, imageType: imageType);

      await databaseHelper.insertResult(results);
    } else {
      await databaseHelper.deleteResultById(id);
    }
  }

  getList() async {
    List<Result> nItems = await databaseHelper.getResults();
    context.read<FoodRecipeSearchLogicCubit>().offlineResultList(nItems);
     SharedPreferences prefs = await SharedPreferences.getInstance();

              List<String>? listValue = prefs.getStringList('listKey');
              context
                  .read<FoodRecipeSearchLogicCubit>()
                  .initialBookmark(listValue ?? []);
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetRecipeInformationCubit, GetRecipeInformationState>(
          listener: (context, detailState) async {
            if (detailState is GetRecipeInformationLoading) {
              Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.black.withOpacity(0.25),
                  size: 50,
                ),
              );
            } else if (detailState is GetRecipeInformationSucceed) {
              final model = detailState.model;
              context
                  .read<FoodRecipeDetailLogicCubit>()
                  .recipeDetailInformationResult(model);
              Navigator.pushNamed(context, RouteName.recipeInformation);
            } else if (detailState is GetRecipeInformationFailed) {
              // Navigator.pop(context);
              final ex = detailState.exception;
              if (ex is ServerException) {
                AppDialog(
                  title: ex.message ?? '',
                  isNoInternet: false,
                );
                //  return showAppDialog(context, title: ex.message ?? '');
              } else if (ex is NoInternetException) {
                const AppDialog(
                  title: ErrorMsgRes.kNoInternet,
                  isNoInternet: true,
                );
              } else {
                const Text('No data found!');
              }
            }
          },
      child:
          BlocBuilder<FoodRecipeSearchLogicCubit, FoodRecipeSearchLogicState>(
        builder: (context, state) {
          final items = state.offlineResults;
          final bookmarkList = state.bookmarkList;
          if (items.isNotEmpty) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length + 1,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) {
                if (index < items.length) {
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<FoodRecipeSearchLogicCubit>()
                          .getRecipeInformation(context, items[index].id!);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            items[index].image!,
                          ),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x03000000),
                            offset: Offset(0, 4),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(12, 0, 12, 86),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<FoodRecipeSearchLogicCubit>()
                                      .changeBookmark(items[index].id!);

                                  insertDB(
                                      items[index].id,
                                      items[index].title,
                                      items[index].image,
                                      items[index].imageType);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xCCFFFFFF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    padding:
                                        const EdgeInsets.fromLTRB(9, 6, 9, 6),
                                    child: SizedBox(
                                      width: 14,
                                      height: 20,
                                      child: SvgPicture.asset(
                                        bookmarkList?.isEmpty ?? true
                                            ? 'assets/vectors/bookmark.svg'
                                            : bookmarkList?.contains(
                                                        items[index]
                                                            .id
                                                            .toString()) ??
                                                    true
                                                ? 'assets/vectors/bookmarked.svg'
                                                : 'assets/vectors/bookmark.svg',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(8)),
                                color: Color(
                                  0xFFFFFFFF,
                                ),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 12, 12.2, 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 12, 0),
                                              child: SizedBox(
                                                child: Text(
                                                  items[index].title!,
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color:
                                                        const Color(0xFF3A3A3B),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 2, 0, 1),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 3, 4, 2),
                                                  child: Opacity(
                                                    opacity: 0.5,
                                                    child: Container(
                                                      width: 16,
                                                      height: 16,
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          1.3, 1.3, 1.3, 1.3),
                                                      child: SizedBox(
                                                        width: 13.3,
                                                        height: 13.3,
                                                        child: SvgPicture.asset(
                                                          'assets/vectors/time.svg',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '15 min',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color:
                                                        const Color(0xFF3A3A3B),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 8.5, 0),
                                            child: Text(
                                              '1 egg',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14,
                                                color: const Color(0xFF3A3A3B),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 3.5, 6, 3.5),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF2EACAA),
                                              ),
                                              child: const SizedBox(
                                                width: 2,
                                                height: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 8.5, 0),
                                            child: Text(
                                              '1 avocado',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14,
                                                color: const Color(0xFF3A3A3B),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 3.5, 6, 3.5),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF2EACAA),
                                              ),
                                              child: const SizedBox(
                                                width: 2,
                                                height: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 8.5, 0),
                                            child: Text(
                                              '1 toast',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14,
                                                color: const Color(0xFF3A3A3B),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'etc.',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14,
                                              color: const Color(0xFF3A3A3B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return const SizedBox(
              child: Center(
                child: Text('No data found!'),
              ),
            );
          }
        },
      ),
    );
  }
}

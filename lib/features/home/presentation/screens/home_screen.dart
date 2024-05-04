import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/core/utils/nums.dart';

import '../logic_cubit/food_recipe_search_logic_cubit.dart';
import '../widgets/home_page_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodRecipeSearchLogicCubit, FoodRecipeSearchLogicState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: SizedBox(
                width: 81,
                child: Image.asset(
                  'assets/images/company_logo.png',
                )),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: const Color(0xff94959B).withOpacity(0.15),
            ),
            child: _buildPage(state.selectedIndex),
          ),
          bottomNavigationBar: _buildBottomAppBar(state),
        );
      },
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return RefreshIndicator(
            onRefresh: () {
              offset = 0;              
              return context
                .read<FoodRecipeSearchLogicCubit>()
                .getFoodRecipeSearch(context);
            },
            child: const HomePageWidget());
      case 1:
        return const Center(child: Text('Saved page'));
      default:
        return Container();
    }
  }

  Widget _buildBottomAppBar(state) {
    return BottomAppBar(
      height: 60,
      surfaceTintColor: const Color(0xFFFFFFFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: state.selectedIndex == 0
                    ? const Color(0xFFFFA500)
                    : const Color(0xFFFFFFFF)),
            child: IconButton(
              icon: Image.asset(
                'assets/images/home.png',
                height: 20,
                width: 18,
                color: state.selectedIndex == 0
                    ? const Color(0xFFFFFFFF)
                    : const Color(0xFF525C67),
              ),
              onPressed: () {
                context
                    .read<FoodRecipeSearchLogicCubit>()
                    .changeSelectedIndex(0);
              },
            ),
          ),
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: state.selectedIndex == 1
                    ? const Color(0xFFFFA500)
                    : const Color(0xFFFFFFFF)),
            child: IconButton(
              icon: Image.asset(
                'assets/images/book.png',
                fit: BoxFit.cover,
                // height: 20,
                // width: 18,
                color: state.selectedIndex == 1
                    ? const Color(0xFFFFFFFF)
                    : const Color(0xFF525C67),
              ),
              onPressed: () {
                context
                    .read<FoodRecipeSearchLogicCubit>()
                    .changeSelectedIndex(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

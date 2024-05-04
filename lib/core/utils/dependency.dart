import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/common/data/repository_impl/locale_repo_impl.dart';
import '../../features/common/domain/repository/locale_repository.dart';
import '../../features/common/domain/usecase/locale_usecase.dart';
import '../../features/common/presentation/cubit/locale/locale_cubit.dart';
import '../../features/common/data/data_source/local/locale_source.dart';
import '../../features/common/data/data_source/local/token_source.dart';
import '../../features/home/data/remote/food_recipe_search_remote.dart';
import '../../features/home/data/remote/get_recipe_information_remote.dart';
import '../../features/home/data/repository_impl/food_recipe_search_repository_impl.dart';
import '../../features/home/data/repository_impl/get_recipe_information_repository_impl.dart';
import '../../features/home/domain/repository/food_recipe_search_repository.dart';
import '../../features/home/domain/repository/get_recipe_information_repository.dart';
import '../../features/home/domain/usecase/food_recipe_search_usecase.dart';
import '../../features/home/domain/usecase/get_recipe_information_usecase.dart';
import '../../features/home/presentation/cubit/food_recipe_search_cubit.dart';
import '../../features/home/presentation/cubit/get_recipe_information_cubit.dart';
import '../../features/home/presentation/logic_cubit/food_recipe_detail_logic_cubit.dart';
import '../../features/home/presentation/logic_cubit/food_recipe_search_logic_cubit.dart';
import '../header_provider/header_provider.dart';

import '../network/connection_checker.dart';

class Dependency {
  static final sl = GetIt.instance;
  Dependency._init();

  static Future<void> init() async {
//-------------------------------------------------------//
    sl.registerLazySingleton<LocaleSource>(() => LocaleSourceImpl(sl()));

    sl.registerLazySingleton<LocaleRepository>(
        () => LocaleRepositoryImpl(sl()));
    sl.registerLazySingleton(() => ReadLocaleUsecase(sl()));
    sl.registerLazySingleton(() => SaveLocaleUsecase(sl()));
    sl.registerLazySingleton(() => LocaleCubit(
          readLocaleUsecase: sl(),
          saveLocaleUsecase: sl(),
        ));
    final sharedPref = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPref);
    sl.registerLazySingleton(() => Client());

    sl.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(),
    );
    sl.registerLazySingleton<TokenSource>(() => TokenSourceImpl(sl()));
    sl.registerLazySingleton<HeaderProvider>(() => HeaderProviderImpl());
    // sl.registerLazySingleton<HeaderProvider>(() => AuthKeyHeaderProviderImpl());
    sl.registerLazySingleton(() => AuthHeaderProvider(sl()));
    sl.registerLazySingleton(() => AuthKeyHeaderProviderImpl());



//---------------------------Find Recipe Start-------------------------------//

    sl.registerLazySingleton<FoodRecipeSearchRemote>(
      () => FoodRecipeSearchRemoteImpl(sl<AuthKeyHeaderProviderImpl>()),
    );

    sl.registerLazySingleton<FoodRecipeSearchRepository>(
      () => FoodRecipeSearchRepositoryImpl(
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => FoodRecipeSearchUsecase(sl()));
    sl.registerFactory(() => FoodRecipeSearchCubit(foodRecipeSearchUsecase: sl()));
    sl.registerFactory(() => FoodRecipeSearchLogicCubit());

//---------------------------Find Recipe End-------------------------------//

//---------------------------Get Recipe Information Start-------------------------------//

    sl.registerLazySingleton<GetRecipeInformationRemote>(
      () => GetRecipeInformationRemoteImpl(sl<AuthKeyHeaderProviderImpl>()),
    );

    sl.registerLazySingleton<GetRecipeInformationRepository>(
      () => GetRecipeInformationRepositoryImpl(
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => GetRecipeInformationUsecase(sl()));
    sl.registerFactory(() => GetRecipeInformationCubit(getRecipeInformationUsecase: sl()));
    sl.registerFactory(() => FoodRecipeDetailLogicCubit());


//---------------------------Get Recipe Information End-------------------------------//
  }

  static final providers = <BlocProvider>[
    BlocProvider<LocaleCubit>(
      create: (context) => Dependency.sl<LocaleCubit>(),
    ),
    BlocProvider<FoodRecipeSearchCubit>(
      create: (context) => Dependency.sl<FoodRecipeSearchCubit>(),
    ),
    BlocProvider<FoodRecipeSearchLogicCubit>(
      create: (context) => Dependency.sl<FoodRecipeSearchLogicCubit>(),
    ),
    BlocProvider<GetRecipeInformationCubit>(
      create: (context) => Dependency.sl<GetRecipeInformationCubit>(),
    ),
    BlocProvider<FoodRecipeDetailLogicCubit>(
      create: (context) => Dependency.sl<FoodRecipeDetailLogicCubit>(),
    ),
  ];
}

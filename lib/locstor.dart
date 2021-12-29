import 'package:get_it/get_it.dart';
import 'package:mybooks/core/services/phone_number_services.dart';
import 'package:mybooks/core/utils/routes/router.dart';

GetIt locator = GetIt.instance;

void regiderServices() async {
  locator.registerLazySingleton(() => PhoneNumberServices());
  locator.registerSingleton<AppRouter>(AppRouter());
}

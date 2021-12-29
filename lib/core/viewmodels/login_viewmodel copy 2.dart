import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mybooks/core/enums/toast_type.dart';
import 'package:mybooks/core/model/new_user.dart';
import 'package:mybooks/core/services/api.dart';
import 'package:mybooks/core/services/toast_services.dart';
import 'package:mybooks/core/utils/failure.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/locstor.dart';
import 'package:mybooks/ui/screens/home.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';

class LoginViewModel extends BaseViewModel {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _visibility = false;
  bool get visibility => _isLoading;
  _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Failure? _failure;
  Failure get failure => _failure!;

  _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  setVisibility(bool val) {
    _visibility = val;
    notifyListeners();
  }

  login(String phone, String password) async {
    _setLoading(true);
    var result = await Api.loign(phone, password);

    result.fold((l) {
      locator.get<AppRouter>().push(HomeRouter(), onFailure: (failure) {
        ToastServices.displayToast(failure.toString(), type: ToastType.Error);
      });
      _setLoading(false);
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
      _setFailure(error);
    });
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:mybooks/core/enums/toast_type.dart';
import 'package:mybooks/core/model/new_user.dart';
import 'package:mybooks/core/services/api.dart';
import 'package:mybooks/core/services/toast_services.dart';
import 'package:mybooks/core/utils/failure.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/main.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
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

  register(NewUser user) async {
    _setLoading(true);
    var result = await Api.SignUser(user);

    result.fold((l) {
      _setLoading(false);
      nav.push(LoginFormRouter());
      ToastServices.displayToast('تم التسجيل بنجاح', type: ToastType.Success);
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
      _setFailure(error);
    });
  }

  updatePassword(String uid, String pwd) async {
    _setLoading(true);
    var result = await Api.updatePassword(pwd, uid);

    result.fold((l) {
      _setLoading(false);
    
      ToastServices.displayToast('تم تحديث كلمة المرور بنجاح',
          type: ToastType.Success);
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
      _setFailure(error);
    });
  }
}

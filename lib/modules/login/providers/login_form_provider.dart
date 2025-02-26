import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/login/models/login_model.dart';
import 'package:geapp/modules/login/repositories/login_repository.dart';
import 'package:geapp/utils/utils.dart';

class LoginFormProvider extends FormProvider<LoginModel> {
  final LoginRepository repository;
  LoginFormProvider(this.repository);

  @override
  LoginModel item = LoginModel(user: "demo", password: "1234");

  @override
  String title = "Login";

  @override
  Future<bool?> save() async {
    changeIsLoading();

    try {
      return await repository.login(item.user, item.password);
    } catch (e) {
      Utils.showToast("Ocorreu um erro desconhecido.", ToastType.error);
      return false;
    } finally {
      changeIsLoading();
    }
  }

  @override
  void clearData() {
    item = LoginModel(user: "demo", password: "1234");
  }

  @override
  Future<bool?> delete() {
    throw UnimplementedError();
  }

  @override
  void setEdit(LoginModel object) {}
}

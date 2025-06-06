import 'dart:developer';

import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/login/models/login_model.dart';
import 'package:geapp/modules/login/repositories/login_repository.dart';
import 'package:geapp/utils/utils.dart';

class LoginFormProvider extends FormProvider<LoginModel> {
  LoginRepository repository;
  LoginFormProvider(this.repository);

  updateDependencies(LoginRepository repo) {
    repository = repo;
    notifyListeners();
  }

  @override
  LoginModel item = LoginModel(user: "demo", password: "1234");

  @override
  String title = "Login";

  @override
  Future<void> setCreate() async {
    try {
      changeIsLoading();

      isEditing = false;
      item = LoginModel(user: "demo", password: "1234");

      await Future.delayed(Duration(milliseconds: 50));
    } catch (e) {
      log("LoginFormProvider::setCreate - $e");
    } finally {
      changeIsLoading();
    }
  }

  @override
  Future<bool?> save() async {
    changeIsSaving();

    try {
      return await repository.login(item.user, item.password);
    } catch (e) {
      Utils.showToast("Ocorreu um erro desconhecido.", ToastType.error);
      return false;
    } finally {
      changeIsSaving();
    }
  }

  @override
  Future<bool?> delete() {
    throw UnimplementedError();
  }

  @override
  Future<void> setEdit(LoginModel object) async {}
}

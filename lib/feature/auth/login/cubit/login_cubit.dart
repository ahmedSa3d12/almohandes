import 'package:engwheels/core/utils/toast_message_method.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/feature/chat/cubit/chat_cubit.dart';
import 'package:engwheels/feature/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/remote/service.dart';
import '../../../../core/utils/appwidget.dart';
import '../../../main/cubit/mainscreens_cubit.dart';
import '../model/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as googlelogin;

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool? _checking = true;
  bool isLoginValid = false;
  googlelogin.User? user;
  LoginModel loginModel = LoginModel();

  bool ishidden = true;
  final ServiceApi api;

  LoginCubit(this.api) : super(LoginInitial());

  hide() {
    print("sss${ishidden}");
    ishidden = !ishidden;
    print("seess${ishidden}");
    emit(PasswordHidden(ishidden));
  }

  void checkValidLoginData() {
    if (loginModel.isDataValid()) {
      isLoginValid = true;
      emit(OnLoginVaild());
    } else {
      isLoginValid = false;

      emit(OnLoginVaildFaild());
    }
  }

  void login(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.postLogin(loginModel);
    response.fold(
      (failure) => {Navigator.pop(context), emit(OnError(failure.toString()))},
      (loginModel) {
        Navigator.pop(context);

        if (loginModel.code == 409) {
          toastMessage(loginModel.message, context);
          // emit(LoginLoaded());
        } else if (loginModel.code == 200) {
          Preferences.instance.setUser(loginModel).then((value) {
            emit(OnLoginSuccess(loginModel));
            context.read<ProfileCubit>().getuserData();
            context.read<MainscreensCubit>().getuserData();
            context.read<ChatCubit>().getuserData();
            context.read<ProfileCubit>().getDeviceToken();

            Navigator.pop(context);

          });
        }
      },
    );
  }

  signInWithGoogle( BuildContext context) async {
    googlelogin.FirebaseAuth auth = googlelogin.FirebaseAuth.instance;


    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final googlelogin.AuthCredential credential = googlelogin.GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final googlelogin.UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
        print(user!.displayName);

        registerwithGoogle(context);
      } on googlelogin.FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }

    }
  }
  facebooklogin(BuildContext context) async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      _accessToken = loginResult.accessToken;
      final userInfo = await FacebookAuth.instance.getUserData();
      print('ResultStatus:');

      //print('ResultStatus: ${loginResult.status}');

      _userData = userInfo;
      print(_userData.toString());
      registerwithFacebook(context);
    } else {
      print('ResultStatus: ${loginResult.status}');
      print('Message: ${loginResult.message}');
    }
  }
  void registerwithGoogle(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.registerUserWithGoogle(user);
    response.fold(
          (failure) => {Navigator.pop(context),
            },
          (loginModel) {
        if (loginModel.code == 409) {
          Navigator.pop(context);
          toastMessage("exists_email".tr(), context);
          // errorGetBar(translateText(AppStrings.noEmailError, context));

        } else if (loginModel.code == 200) {
          Navigator.pop(context);
          Preferences.instance.setUser(loginModel).then((value) {
            emit(OnLoginSuccess(loginModel));
            context.read<ProfileCubit>().getuserData();
            context.read<MainscreensCubit>().getuserData();
            context.read<ChatCubit>().getuserData();
            context.read<ProfileCubit>().getDeviceToken();

            Navigator.pop(context);

          });
        }
      },
    );
  }
  void registerwithFacebook(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.registerUserWithFacebook(_userData);
    response.fold(
          (failure) => {Navigator.pop(context),
            },
          (loginModel) {
        if (loginModel.code == 409) {
          Navigator.pop(context);
          toastMessage("exists_email".tr(), context);
          // errorGetBar(translateText(AppStrings.noEmailError, context));

        } else if (loginModel.code == 200) {
          Navigator.pop(context);
          Preferences.instance.setUser(loginModel).then((value) {
            emit(OnLoginSuccess(loginModel));
            context.read<ProfileCubit>().getuserData();
            context.read<MainscreensCubit>().getuserData();
            context.read<ChatCubit>().getuserData();
            context.read<ProfileCubit>().getDeviceToken();

            Navigator.pop(context);

          });
        }
      },
    );
  }

}

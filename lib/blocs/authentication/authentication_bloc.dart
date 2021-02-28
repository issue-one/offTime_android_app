import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:offTime/repository/repository.dart';
import 'package:offTime/blocs/authentication/authentication.dart';



class UserAuthenticationBloc extends Bloc<UserAuthenticationEvent, UserAuthenticationState> {
  final UserRepository userRepository ;

  UserAuthenticationBloc({@required this.userRepository}) : assert(userRepository !=null),super(UserAuthenticating());


  Stream<UserAuthenticationState> mapEventToState(UserAuthenticationEvent event) async* {
    if (event is SignUpRequested ) {
      yield* _mapSignUpRequestedToState(event);
    } else if (event is LoginRequested) {
      yield* _mapLoginRequestedToState(event);
    } else if (event is LogoutRequested) {
      yield* _mapLogoutRequestedToState(event);
    }else if (event is IsLoggedIn) {
      yield* _mapIsLoggedInToState(event);
    }
  }


  Stream<UserAuthenticationState> _mapIsLoggedInToState(IsLoggedIn event) async* {
    yield UserAuthenticating();
    try {
      final sharedData= await userRepository.getPreferences();
    //  final refreshedToken=await userRepository.refreshToken(sharedData[1]);
      final user= await userRepository.getUser(sharedData[0],sharedData[1]);


      yield UserAuthenticationSuccess(user: user);
    } catch (_) {
      yield UserAuthenticationFailure();
    }
  }



  Stream<UserAuthenticationState> _mapSignUpRequestedToState(SignUpRequested event) async* {
    yield UserAuthenticating();
    try {
      final user=await userRepository.createUser(event.userInput);

      yield UserAuthenticationSuccess(user: user);
    } catch (_) {
      yield UserAuthenticationFailure();
    }
  }
  Stream<UserAuthenticationState> _mapLoginRequestedToState(LoginRequested event) async* {
   
    try {
      print(event.userInput);
      final user=await userRepository.loginUser(event.userInput);
       print(event.userInput.password);
      yield UserAuthenticationSuccess(user: user);

    } catch (e) {
      print(e);
      yield UserAuthenticationFailure();
    }}
    Stream<UserAuthenticationState> _mapLogoutRequestedToState(LogoutRequested event) async* {
      yield UserAuthenticating();
      try {
        final user=await userRepository.logoutUser(event.user);
        yield UserAuthenticationSuccess(user: user);
      } catch (_) {
        yield UserAuthenticationFailure();
      }
  }


}

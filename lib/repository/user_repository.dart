import 'dart:io';
import 'package:meta/meta.dart';
import 'package:offTime/data_provider/data_provider.dart';
import 'package:offTime/models/models.dart';
import 'package:offTime/models/user_update_input.dart';

class UserRepository{
  final UserDataProvider userDataProvider;
  UserRepository({
    @required this.userDataProvider
  }) : assert(userDataProvider !=null);

  Future<User> createUser(UserInput userInput) async{
    await userDataProvider.createUser(userInput);
    String token =await userDataProvider.postToken(userInput);
    return await userDataProvider.getUser(userInput.username, token);
  }
  Future<User> loginUser(UserInput userInput) async{
    String token =await userDataProvider.postToken(userInput);
    return await userDataProvider.getUser(userInput.username, token);
  }
  Future<User> getUser(String username, String token) async{
    return await userDataProvider.getUser(username, token);
  }
  Future<User> updateUser(User user, UserUpdateInput userUpdateInput) async{
    return await userDataProvider.updateUser(user, userUpdateInput);
  }
  Future<void> deleteUser(User user) async {
    return await userDataProvider.deleteUser(user);
  }
  Future<String>putPicture(User user, File file) async{
    return await userDataProvider.putPicture(user, file);
  }
  Future<String>refreshToken(User user) async{
    return await userDataProvider.refreshToken(user);
  }

  logoutUser(User user) {
    return User(token: "");
  }

}
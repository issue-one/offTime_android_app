import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

enum ThemeEvent { lightTheme, darkTheme}

class AppThemeBloc extends Bloc<ThemeEvent,ThemeData>{
  AppThemeBloc() : super(MyTheme.lightAppTheme);
  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    switch(event){
      case ThemeEvent.lightTheme:
        yield MyTheme.lightAppTheme;
        break;
      case ThemeEvent.darkTheme:
        yield MyTheme.darkAppTheme;
        break;
    }
    
  }
  @override
  void onChange(Change<ThemeData> change) {
  
    super.onChange(change);
  }

}

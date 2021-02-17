import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/widgets/widgets.dart';

class IntroPage extends StatelessWidget{
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      
      home: Scaffold(
        appBar: AppBar(backgroundColor: Theme.of(context).focusColor, title: Text("This"),),
        body: Center(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                
                ElevatedButton(onPressed: () { 
                  context.read<AppThemeBloc>().add(ThemeEvent.darkTheme);
                 },
                child: Container(
                  color: Theme.of(context).focusColor,
                  child: Text("This")),
                
                ),
                ElevatedButton(onPressed: () { 
                  context.read<AppThemeBloc>().add(ThemeEvent.lightTheme);
                 },
                child: Container(
                  color: Theme.of(context).focusColor,
                  child: Text("This")),
                
                ),
              ],
            ),
          ),
        ),
      ),

      
    );
  }
}
class MyElevatedButton extends StatelessWidget{
  final String title;
  MyElevatedButton(this.title);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () { 
      context.read<AppThemeBloc>().add(ThemeEvent.darkTheme);
               
     },
                  
                  child: 
                  Text(title, style: Theme.of(context).textTheme.headline1
                  ), 
                  
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    
                  ),
                primary: Theme.of(context).primaryColor,)
                
          );
  }


}
class FullscreenSliderDemo extends StatelessWidget {
  final List<String> imgList =['assets/images/t.png', 'assets/images/t.png','assets/images/t.png'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          
          final double height = MediaQuery.of(context).size.height;
          
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeIn,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: imgList.map((item) => Container(
              child: Center(
                child: Image.asset(item, fit: BoxFit.cover, height: height,)
              ),
            )).toList(),
          );
        },
      ),
    );
  }
}
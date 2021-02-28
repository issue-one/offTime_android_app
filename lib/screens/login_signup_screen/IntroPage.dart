import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';



class IntroPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

        body: Stack(
          children: [
            FullscreenSliderDemo(),
            Positioned(
                bottom: 0.0,
                left: 10.0,
                right: 10.0,
                height: 150,
                child: Card(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Text("Welcome"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         MyElevatedButton(title: "Login", navigation: true),
                         MyElevatedButton(title: "Sign Up", navigation: true)
                       ],

                      ),
                    ],
                  ),
                  

            ))
          ]

        ),


      
    );
  }
}
class MyElevatedButton extends StatelessWidget{
  final String title;
  final Function myOnPressed;
  final bool navigation;

  
  MyElevatedButton({@required this.title, this.myOnPressed, @required this.navigation});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 60,
      child: ElevatedButton(

          child: Text(title, style: Theme.of(context).textTheme.button),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).accentColor,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),),
           ),
          onPressed: navigation ? ()=> Navigator.pushNamed(context, title) : myOnPressed,

      ),
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
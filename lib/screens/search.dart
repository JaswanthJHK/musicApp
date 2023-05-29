import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 107, 107, 107),
            Color.fromARGB(255, 46, 46, 46)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 94, 94, 94),
                    Color.fromARGB(255, 46, 46, 46)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: const Padding(
                padding: EdgeInsets.only(top: 10, left: 140),
                child: Text(
                  'Search',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                style: TextStyle(
                  fontSize: 10.0,
                  color: Color.fromARGB(255, 125, 120, 119),
                ),
                decoration: InputDecoration(
                  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none
                  ),

                  fillColor: Colors.white.withOpacity(.3),
                  filled: true,
                  prefixIcon: Icon(Icons.search,size: 30,color: Colors.black,),
                  suffixIcon: Icon(Icons.clear,size: 30,color: Color.fromARGB(255, 201, 201, 201),),
                  labelText: 'Search songs . . .',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 211, 211, 211),
                    fontSize: 18.0,
                    fontFamily:'OpenSans'
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

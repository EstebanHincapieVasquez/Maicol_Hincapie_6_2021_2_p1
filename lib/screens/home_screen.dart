import 'package:flutter/material.dart';
import 'package:noticias_examen_app/components/loader_component.dart';

import 'package:noticias_examen_app/screens/categorys_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 200,),
                _showLogo(),
                SizedBox(height: 100,),
                _showNoticesButton(),
              ],
            ),
          ),
        _showLoader ? LoaderComponent(text: 'Por favor espere...') : Container(),
        ],
      ),
    );
  }

  Widget _showLogo() {
    return Image(
      image: AssetImage('assets/logo.png'),
      fit: BoxFit.fill,
      );
  }

  Widget _showNoticesButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 300,
        height: 50,
        color: Colors.orange,
        child: Text('Ver Noticias',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
         )
        ),
        onPressed: () => _notices(),
      ),
    );
    /*return Container(
      
      child: ElevatedButton(
        child: Text('Ver Noticias'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Colors.orange;
            }
          ),
        ),
        onPressed: () => _notices(),
      ),
    );*/
  }
  
  void _notices() async {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => CategorysScreen(),
      )
    );
  }
}
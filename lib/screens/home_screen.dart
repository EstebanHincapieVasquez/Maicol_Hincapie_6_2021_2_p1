import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noticias_examen_app/components/loader_component.dart';

import 'package:noticias_examen_app/helpers/constants.dart';
import 'package:noticias_examen_app/models/category.dart';
import 'package:noticias_examen_app/models/response.dart';
import 'package:noticias_examen_app/screens/notices_screen.dart';

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
                SizedBox(height: 40,),
                _showLogo(),
                SizedBox(height: 30,),
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
      width: 500,
      );
  }

  Widget _showNoticesButton() {
    return Expanded(
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
    );
  }
  
  void _notices() async {
    setState(() {
    });

    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
        context: context,
        title: 'Error', 
        message: 'Verifica que estes conectado a internet.',
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );
      return;
    }

    var url = Uri.parse('${Constants.apiUrl}');
    var response = await http.get(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
      },
    );
    
    setState(() {
      _showLoader = false;
    });
    
    var body = response.body;

    if(response.statusCode >= 400) {
      //return Response(isSuccess: false, message: body);
    }

    var decodedJson = jsonDecode(body);
    var category = Category.fromJson(decodedJson);
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => NoticesScreen(category: category,)
      )
    );

  }

}
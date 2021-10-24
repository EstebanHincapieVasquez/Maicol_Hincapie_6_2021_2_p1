import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:noticias_examen_app/helpers/constants.dart';
import 'package:noticias_examen_app/models/category.dart';
import 'package:noticias_examen_app/screens/notices_screen.dart';

class CategorysScreen extends StatefulWidget {
  const CategorysScreen({ Key? key }) : super(key: key);

  @override
  _CategorysScreenState createState() => _CategorysScreenState();
}

class _CategorysScreenState extends State<CategorysScreen> {

  List<Category> _categorys = [];
  bool _showLoader = false;
  bool _isFiltered = false;
  String _search = '';
  static String categoriaSeleccionada = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Categorias de Noticias'),
          backgroundColor: Colors.orange,
        ),
        body: _showButtons(), 
      ),
    );
  }

  Widget _showButtons() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _showAllButton(),
          SizedBox(height: 2,),
          _showNationalButton(),
          SizedBox(height: 2,),
          _showBusinessButton(),
          SizedBox(height: 2,),
          _showSportsButton(),
          SizedBox(height: 2,),
          _showWorldButton(),
          SizedBox(height: 2,),
          _showPoliticsButton(),
          SizedBox(height: 2,),
          _showTechnologyButton(),
          SizedBox(height: 2,),
          _showStartupButton(),
          SizedBox(height: 2,),
          _showEntertainmentButton(),
          SizedBox(height: 2,),
          _showMiscellaneousButton(),
          SizedBox(height: 2,),
          _showHatkeButton(),
          SizedBox(height: 2,),
          _showScienceButton(),
          SizedBox(height: 2,),
          _showAutomobileButton(),
        ],
      ),
    );
  }

  Widget _showAllButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Todas las noticias', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('all'),
      ),
    );
  }

  Widget _showNationalButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias nacionales', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('national'),
      ),
    );
  }

  Widget _showBusinessButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias de negocios', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('business'),
      ),
    );
  }

  Widget _showSportsButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias de deportes', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('sports'),
      ),
    );
  }

  Widget _showWorldButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias del mundo', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('world'),
      ),
    );
  }

  Widget _showPoliticsButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias de política', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('politics'),
      ),
    );
  }

  Widget _showTechnologyButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias de tecnología', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('technology'),
      ),
    );
  }

  Widget _showStartupButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias de inauguraciones', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('startup'),
      ),
    );
  }

  Widget _showEntertainmentButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias de entretenimiento', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('entertainment'),
      ),
    );
  }

  Widget _showMiscellaneousButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias diversas', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('miscellaneous'),
      ),
    );
  }

  Widget _showHatkeButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias de hatke', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('hatke'),
      ),
    );
  }

  Widget _showScienceButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias de ciencia', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('science'),
      ),
    );
  }

  Widget _showAutomobileButton() {
    return Expanded(
      flex: -1,
      child: MaterialButton(
        minWidth: 400,
        height: 40,
        color: Colors.orange,
        child: Text('Noticias de automóviles', style: TextStyle(color: Colors.black, fontSize: 20)),
        onPressed: () => _category('automobile'),
      ),
    );
  }

  Future<void> _category(String categoriaSeleccionada) async {

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

    var url = Uri.parse('${Constants.apiUrl}'+categoriaSeleccionada);
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

    if(response.statusCode == 200) {
      var decodedJson = jsonDecode(body);
      var category = Category.fromJson(decodedJson);
      String? result = await Navigator.push(
      context, 
        MaterialPageRoute(
          builder: (context) => NoticesScreen(category: category, categoriaSeleccionada: categoriaSeleccionada,)
        )
      );
    }
  }
}
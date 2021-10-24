import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:noticias_examen_app/components/loader_component.dart';
import 'package:noticias_examen_app/helpers/api_helper.dart';
import 'package:noticias_examen_app/models/category.dart';
import 'package:noticias_examen_app/models/data.dart';
import 'package:noticias_examen_app/models/response.dart';
import 'package:noticias_examen_app/screens/notice_screen.dart';

class NoticesScreen extends StatefulWidget {
  final Category category;
  String categoriaSeleccionada;

  NoticesScreen({required this.category, required this.categoriaSeleccionada});

  @override
  _NoticesScreenState createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  
  List<Data> _data = [];
  bool _showLoader = false;
  bool _isFiltered = false;
  String _search = '';


   @override
  void initState() {
    super.initState();
    _getNotices(widget.categoriaSeleccionada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          _isFiltered
          ? IconButton(
              onPressed: _removeFilter,
              icon: Icon(Icons.filter_none)
            )
          : IconButton(
              onPressed: _showFilter,
              icon: Icon(Icons.filter_alt)
              )  
        ],
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : _getContent(),
      ),
    );
  }

  Future<void> _getNotices(String categoriaSeleccionada) async {
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

    Response response = await ApiHelper.getNotices(categoriaSeleccionada);

    setState(() {
      _showLoader = false;
    });
    
    if (!response.isSuccess) {
      await showAlertDialog(
        context: context,
        title: 'Error', 
        message: response.message,
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );    
      return;
    }

    setState(() {
      _data = response.result;
    });
  }

  Widget _getContent() {
    return _data.length == 0 
      ? _noContent()
      : _getListView();
  }

  Widget _noContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          _isFiltered
          ? 'No hay noticias con ese criterio de búsqueda.'
          : 'No hay noticias registradas.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: () => _getNotices(widget.categoriaSeleccionada),
      child: ListView(
        children: _data.map((e) {
          return Card(
            child: InkWell(
              onTap: () => _goNotice(e),
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 350.0,
                        child: Text(
                          e.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showFilter() {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Filtrar Noticia'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Escriba las primeras letras de la noticia'),
              SizedBox(height: 10,),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Criterio de búsqueda...',
                  labelText: 'Buscar',
                  suffixIcon: Icon(Icons.search)
                ),
                onChanged: (value) {
                  _search = value;
                },
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('Cancelar')
            ),
            TextButton(
              onPressed: () => _filter(), 
              child: Text('Filtrar')
            ),
         ],
        );
      }
    );
  }

  void _removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _getNotices(widget.categoriaSeleccionada);
  }

  void _filter() {
    if (_search.isEmpty) {
      return;
    }

    List<Data> filteredList = [];
    for (var data in _data) {
      if (data.title.toLowerCase().contains(_search.toLowerCase())) {
        filteredList.add(data);
      }
    }

    setState(() {
      _data = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }

  void _goNotice(Data data) async {
    String? result = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => NoticeScreen(
          data: data,
        )
      )
    );
    if (result == 'yes') {
      _getNotices(widget.categoriaSeleccionada);
    }
  }
}
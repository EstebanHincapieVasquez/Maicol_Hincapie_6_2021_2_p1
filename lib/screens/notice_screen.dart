import 'package:flutter/material.dart';
import 'package:noticias_examen_app/components/loader_component.dart';
import 'package:noticias_examen_app/models/data.dart';

class NoticeScreen extends StatefulWidget {
  final Data data;

  NoticeScreen({required this.data});

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  bool _showLoader = false;
  late Data _data;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
    _showNoticeInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_data.author),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: _showLoader 
          ? LoaderComponent(text: 'Por favor espere...',) 
          : _getContent(),
      ),
    );
  }

  Widget _getContent() {
    return Expanded(
      child: _showNoticeInfo(),
    );
  }

  Widget _showNoticeInfo() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/logo.png'), 
                  image: NetworkImage(_data.imageUrl),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover
                  
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Titulo: ', 
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Text(
                              _data.title,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Contenido: ', 
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Center(
                              child: Text(
                                _data.content, 
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Fecha: ', 
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Text(
                              _data.date, 
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Hora: ', 
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Text(
                              _data.time, 
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Url: ', 
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Text(
                              _data.url, 
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Ver más: ', 
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Text(
                              _data.readMoreUrl.toString(), 
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
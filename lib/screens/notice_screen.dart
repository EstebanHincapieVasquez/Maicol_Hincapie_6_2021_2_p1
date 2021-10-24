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
          SizedBox(height: 15,),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Titulo: ', 
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 33),
                              constraints: BoxConstraints(maxWidth: 320),
                              child: Text(
                                (_data.title == null) ? " ": _data.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 16
                                ),
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Contenido: ', 
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(maxWidth: 280),
                              child: Text(
                                (_data.content == null) ? " ": _data.content,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 16
                                ),
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Fecha: ', 
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 30),
                              constraints: BoxConstraints(maxWidth: 250),
                              child: Text(
                                (_data.date == null) ? " ": _data.date,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 16
                                ),
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Hora: ', 
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 40),
                              constraints: BoxConstraints(maxWidth: 250),
                              child: Text(
                                (_data.time == null) ? " ": _data.time,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 16
                                ),
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Url: ', 
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 50),
                              constraints: BoxConstraints(maxWidth: 350),
                              child: Text(
                                (_data.url == null) ? " ": _data.url,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 16
                                ),
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Ver más: ', 
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              constraints: BoxConstraints(maxWidth: 300),
                              child: Text(
                                (_data.readMoreUrl.toString() == null) ? " ": _data.readMoreUrl.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 16
                                ),
                              )
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
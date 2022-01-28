import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'Post.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _urlBase = "https://jsonplaceholder.typicode.com/posts";
  
 
  Future<List<Post>> _recuperarPost() async {
    
    http.Response response = await http.get(_urlBase);
    var dadosJson = jsonDecode(response.body);

    List<Post> postagens = List();
    for(var post in dadosJson){
      print("post: " + post["title"]);
        Post p = Post(post["title"], post["body"]);
        postagens.add(p);
}
    return postagens;
  }

  _post(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de Serviço avançado"),
      ),
      body: FutureBuilder<List<Post>>(
        future: _recuperarPost(),
        builder: (context, snapshot){

          String resultado;
          switch(snapshot.connectionState){
            case ConnectionState.none :
            case ConnectionState.waiting ;
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
            case ConnectionState.active ;
            break;
            case ConnectionState.done ;
            print("Conexao done");
            if(snapshot.hasError) {
              print("lista: Erro ao carregar");

            } else{
              print("lista: carregou!! ");
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {

                    List<Post> lista = snapshot.data;
                    Post post = lista[index];


                    return ListTile(
                      title: Text(post._title),
                      subtitle: Text(post._body),
                    );
                  }
              );
            }
            break;
          }
        },
      ),
    );
  }
}

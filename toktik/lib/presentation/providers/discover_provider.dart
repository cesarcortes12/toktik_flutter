

import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infraestructure/models/local_video_model.dart';
import 'package:toktik/share/local_video_post.dart';

class DiscoverProvider extends ChangeNotifier {
  //TODO: repository: sera quin va a permitir lanzar las peticiones respectivas
  //datasource: es la fuente de la data en la cual vamos a tener varias fuentes como local , internet, jsonlocal etc

  bool initialLoading = true;
  //esto con la finalidad de iniciar la cara de videos ya que la primera vez que se inicie el provider no va a tener videos

  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    // todo : cargar videos

    //vamos a simular una comunicacion http asincrona
    /*este metodo espera 2 segudos carga los videosy los añade a la lista  */
    await Future.delayed(const Duration(seconds: 2));

/*para entender esta linea lo que hacemos es en la variable newvideos se va a crear un nuevo listado de videos los cuales los tomamos 
de un archivo muestra de json ,y lo converitmos a formato entidad para luego en una lista */
    final List<VideoPost> newvideos = videoPosts
        .map((video) => LocalVideoModel.fromJson(video).toVideoPostEntity())
        .toList(); //es el listado que tenemos en shared localvideospost

    videos.addAll(newvideos);
    initialLoading = false;
    notifyListeners();
  }
}

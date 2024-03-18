// sinippet mate app
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/infraestructure/datasources/local_video_datasource_impl.dart';
import 'package:toktik/infraestructure/repositories/video_post_repository_impl.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //vamos a crear la instancia del repository y del data source
    final videoPostRepository =
        VideoPostsRepositoryImpl(videosDatasource: LocalVideoDatasource());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //ojo los change notifier solo se ejecuutan hasta que sea necesartia la instancia
          lazy: false, //ESTO ES PARA QUE SE LANCE EL CONSTRUCTOR DE INMEDIATO
          //ESTO ES UTIL PARA IR ADELANTANDO TAREAS ANTES DE QUE EL USUARIO LLEGUE A ELLAS
          create: (_) => DiscoverProvider(videosRepository: videoPostRepository)
            ..loadNextPage(), // operador de cascada
        )
      ],
      child: MaterialApp(
        title: 'TOKTIK',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().gettheme(),
        home: const DiscoverScreen(),
      ),
    );
  }
}



/*TEORIA
ARQUITECTURA: 

asssets:son los recursos que se utilizan en la app (llamarlos tambien en yaml)

lib: es la libreria principal del proyecto
    config:
      theme: definicion del tema
        app_theme : definicion del tema global
      helpers: son los que dan ayuda al manejo de datos
    domain:
      datasources: son las fuentes de datos
      entities: aqui tenemos el modelo de datos que tenenemos mas cercano a la regla de negocio
      repositories: son los repositorios
    share: es todo lo que va a ir compartido en la app
      data: toda la informacion que va a compartir la app
    presentation: es todo lo visual de la app
      screens: cada una de las vistas
        discover(nombre x): es el home screen
      providers: todos los providers
      widgets: todos los widgets reutilizables
        shared: es todo lo que va a compartir a lo  largo de varios screens
    infraestructure: Esta capa se encarga de la comunicación con las capas externas como la base de datos,servicios externos
      models: es todo lo relacionado con la base de datos
      datasources: son las implementaciones de los datasources
      repositories: basicamente es quien va a llamar al datasource
 


FLUJO EN UNA ARQUITECTURA LIMPIA
1. UI
2. PRESENTACION
3. CASOS DE USO
4. REPOSITORIO
5. INFOMACION REGRESA AL UI

ENTONCES: 
la ui tiene la comunicacion con la presentacion la cual tiene los providers y gestores de estado 
 estos terminan llamando los casos de uso que son las reglas de negocio  los cuales llaman repostitorios los cuales comunican con el data source 
 y regresa al ui






 CAPAS DE LA ARQUITECTURA
 DOMAIN O DOMINIO
        Esta capa es en la que definimmos las reglas que gobiernan toda la aplicacion

  INFRESTUCTURE O DATA :

 */
import 'package:choco_countries/screens/countries_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:choco_countries/models/countries_model.dart';
import 'package:flutter_svg/svg.dart';

  // Nuestro nuevo jugador hereda los poderes de SearchDelegate
class CountrySearchDelegate extends SearchDelegate {

  //Creamos la variable y el constructor para recibir la lista de paises

  final List<Country> countries;
  CountrySearchDelegate(this.countries);


  //Es el icono que aparece en la parte derecha
  //Normalmente es el icono de la X que sirve para borrar
  @override
  List<Widget>? buildActions(BuildContext context) {
   
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // "query" es la variable mágica que guarda lo que el usuario escribe. Aquí la vaciamos.
        },
      )
    ];
  }

  //El icono del buscador que aparece a la izquierda
  @override
  Widget? buildLeading(BuildContext context) {
    
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // "close" es el superpoder para cerrar el buscador y regresar a tu app
      },
    );

  }

  //Es lo que dibuja el widget cuando ya terminé de escribir

  @override
  Widget buildResults(BuildContext context) {
    
    return buildSuggestions(context);
  }

  //Es lo que va sugiriendo el widget cada vez que escribo una palabra
  @override
  Widget buildSuggestions(BuildContext context) {
    //Esta linea nos ayuda a validar que cuando el usuario oprima clic en el buscador
    //No salga la lista de los 250 paises de inmediato

    if (query.isEmpty) {
      return const Center(
        child: Text(
          'Escribe el nombre de un país... 🌎',
          style: TextStyle(fontSize: 18),
        ),
      );
    }
    
    final sugerencias = countries.where((pais) { //El .where es como un cadenero de discoteca que solo deja pasar a los países que coinciden con lo que el usuario va escribiendo
    // 1. Filtramos la lista. Pasamos todo a minúsculas para que no haya problemas si el usuario escribe "CoLomBia"
    final busqueda      = query.toLowerCase();  
    final nombreIngles  = pais.name.common.toLowerCase();
    final nombreEspanol = pais.nombreEspanol.toLowerCase();
      
    // 2. ¡LA MAGIA! Retornamos TRUE si la búsqueda coincide con el inglés O (||) con el español
      return nombreIngles.contains(busqueda) || nombreEspanol.contains(busqueda);
      //return pais.name.common.toLowerCase().contains(query.toLowerCase());
    }).toList();

    // 2. Si no hay resultados, mostramos un mensaje amigable
    if (sugerencias.isEmpty) {
      return const Center(
        child: Text('No se encontró ningún país con ese nombre 🕵️‍♂️', style: TextStyle(fontSize: 18)),
      );
    }

    // 3. Pintamos los resultados en una lista sencilla
    return ListView.builder(
      itemCount: sugerencias.length,
      itemBuilder: (context, index) {
        final pais = sugerencias[index];
        
        return ListTile(
          title: Text(pais.name.common),
          leading: SizedBox(
            width: 50,
            height: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: SvgPicture.network(
                pais.flags.svg,
                fit: BoxFit.cover,
              ),
            ),
          ), // Un iconito temporal de un planeta
          onTap: () {
            // Cuando toquemos un país en la búsqueda, ¡pasará algo increíble! (Lo haremos luego)
            Navigator.push(
              context,
              MaterialPageRoute(
                // Aquí llamamos a nuestra "Sala VIP" y le pasamos el país exacto que el usuario tocó
                builder: (context) => CountryDetailsScreen(country: pais),
              ),
            );
            query = pais.name.common; // Autocompleta la barra de búsqueda
          },
        );
      },
    );
  }
  
  // Aquí la clase te va a marcar una línea roja de error. ¡Es normal!
  
}
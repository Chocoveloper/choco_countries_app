import 'package:choco_countries/models/countries_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

//Esta función la hice como ejemplo, para verifcar que podia
//obtener los datos

Future<void> getCountry() async {
  final url = Uri.parse('https://restcountries.com/v3.1/name/colombia');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = countryFromJson(response.body);
      for (var country in body) {
        debugPrint('${country.name.common} '); // Country's name
        debugPrint('Capital: ${country.capital} ');
        debugPrint('Población: ${country.population} ');
        debugPrint('Region: ${country.region} ');
        debugPrint('Sub Region: ${country.subregion} ');
        debugPrint('Bandera: ${country.flags.svg} ');
      }
    } else {
      debugPrint('No fue posible obtener el pais ${response.statusCode}');
    }
  } catch (error) {
    debugPrint('Ocurrió un error $error');
  }
}

//La siguiente función es para obtener los datos de la API
//Y además mostrar la información en los widgets, por eso
//Retornaremos una lista de la clase Country.

Future<List<Country>> getCountryTwo() async {
  //Aqui cambiamos la url al final.
  //Para traer a todos los paises.

  final url = Uri.parse(
    'https://restcountries.com/v3.1/all?fields=name,capital,region,subregion,population,flags,translations',
  );

  try {
    //La petición se debe hacer dentro del Try

    final response = await http.get(url);

    //Se valida que la petición sea exitosa

    if (response.statusCode == 200) {
      
      //Como la petición fue exitosa, ahora si convertimos la información
      final body = countryFromJson(response.body);

      //Me di cuenta que los pasise no vienen en orden alfabetico
      //Para ordenarlos hacemos lo siguiente:
      body.sort((a, b) => a.name.common.compareTo(b.name.common));
      return body;

    } else {
      debugPrint('Eroor en el servidor: ${response.statusCode}');
      return [];
    }
  } catch (error) {
    debugPrint('Se cayó el internet: $error');
    return [];
  }
}

import 'package:choco_countries/models/countries_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//Awuí estamos usando el paquete Dio, un paquete muy amado.
//Diferencias de Dio con respecto a http
/*1) Con Dio no necesito usar esto: Uri.parse() ya que Dio acepta el texto de la URL directamente
*2) Con Dio no necesito usar esto: json.decode() ya que Dio detecta que la API envia un JSON y lo desempaqueta automaticamente en una lista de Dart.

 */

Future<List<Country>> getCountryDio() async{

  //1) Creamos una instancia de Dio

  final dio = Dio();

  try{
    //2) Siempre dentro del try hacemos la peticion get

    final response = await dio.get('https://restcountries.com/v3.1/all?fields=name,capital,region,subregion,population,flags,translations');
  
  //3) Dio hace su magia: 'response.data' ya viene convertido en lista.
  //como ya es una lista, pasamos cada elemento directamente por (Country.fromJson)

  final List<Country> paises = (response.data as List).map((paisJson) => Country.fromJson(paisJson)).toList();
  
  //4) Ordenamos los países alfabeticamente
  paises.sort((a, b) => a.name.common.compareTo(b.name.common));
  
  return paises;
  }catch(error){
    // Si algo sale mal, se imprime el error que arroja Dio y se devuelve una lista vacia
    debugPrint('Error, algo salió mal: $error');
  return [];
  }
  
}
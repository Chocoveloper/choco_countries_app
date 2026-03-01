import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:choco_countries/models/countries_model.dart';

class CountryDetailsScreen extends StatelessWidget {
  
  // 1. La variable mágica: Esta pantalla NECESITA un país para funcionar
  final Country country;

  // 2. Se lo pedimos de forma obligatoria (required) en el constructor
  const CountryDetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF283750),
        // Ponemos el nombre del país como título en la barra superior
        title: Text(
          country.name.common, 
          style: const TextStyle(color: Colors.white),
        ),
        // Esto pone la flecha blanca de regreso automáticamente
        iconTheme: const IconThemeData(color: Colors.white), 
      ),
      body: Center(
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            elevation: 5, // Le damos un poquito de sombra para que se vea más 3D
            child: Padding( // En lugar de ListTile, usamos Padding
              padding: const EdgeInsets.all(10.0),
              child: Row( // Una fila: [ Bandera , Textos ]
                crossAxisAlignment: CrossAxisAlignment.start, // Alineamos todo bien arriba
                children: [
                  
                  // 1. LA BANDERA (Lado Izquierdo)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: SizedBox(
                      width: 80.0, // La hicimos un poquito más grande para la Sala VIP
                      height: 70.0,
                      child: SvgPicture.network(
                        country.flags.svg,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Espacio separador entre la bandera y el texto
                  const SizedBox(width: 20.0),

                  // 2. LOS TEXTOS (Lado Derecho)
                  // El Expanded obliga a la Columna a usar solo el espacio que sobra, evitando errores
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Textos alineados a la izquierda
                      mainAxisSize: MainAxisSize.min, // La columna ocupará solo el alto necesario
                      children: [
                        Text(
                          country.name.common, 
                          style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold), 
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5), // Espaciador chiquito
                        Text(
                          'Capital: ${country.capital.isNotEmpty ? country.capital[0] : 'N/A'}', 
                          style: const TextStyle(fontSize: 18.0), 
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Población: ${country.population}', 
                          style: const TextStyle(fontSize: 18.0), 
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Región: ${country.region}', 
                          style: const TextStyle(fontSize: 18.0), 
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Subregión: ${country.subregion}', 
                          style: const TextStyle(fontSize: 18.0), 
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
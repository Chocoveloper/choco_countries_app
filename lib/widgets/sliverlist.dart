
import 'package:choco_countries/screens/countries_details_screen.dart';
import 'package:choco_countries/search/country_search_delegate.dart';
import 'package:choco_countries/models/countries_model.dart';
import 'package:choco_countries/services/countries_http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SliverCountriesList extends StatelessWidget {
  const SliverCountriesList({super.key});

 @override
  Widget build(BuildContext context) {
    // 1. Subimos el FutureBuilder para que abrace toda la pantalla
    return FutureBuilder<List<Country>>(
      future: getCountryTwo(),
      builder: (context, snapshot) {
        
        // Sacamos la lista de países (si está cargando, le damos una lista vacía por ahora)
        final countries = snapshot.data ?? [];

        return CustomScrollView(
          slivers: [
            // 2. Nuestro AppBar ahora está DENTRO y conoce a los "paises"
            SliverAppBar(
              backgroundColor: const Color(0XFF283750),
              centerTitle: true,
              title: const Text(
                'Países Del Mundo',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              floating: true, // Choco-Truco: Hace que el AppBar baje suavemente al hacer scroll
              actions: [
                // 3. ¡EL BOTÓN DE BÚSQUEDA!
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    // Si ya cargaron los países, abrimos el buscador
                    if (countries.isNotEmpty) {
                      showSearch(
                        context: context,
                        delegate: CountrySearchDelegate(countries), // ¡Le pasamos el balón (los países)!
                      );
                    }
                  },
                )
              ],
            ),
            
            // 4. Controlamos los 3 tiempos del partido:
            // ESTADO 1: Cargando (La ruedita)
            if (snapshot.connectionState == ConnectionState.waiting)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              )
            
            // ESTADO 2: Error o lista vacía
            else if (countries.isEmpty)
              const SliverToBoxAdapter(
                child: Center(child: Text('No hay países para mostrar 😔')),
              )
            
            // ESTADO 3: ¡Éxito! Pintamos la lista de tarjetas
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final country = countries[index];
                    
                    // 👉 ¡PEGA TU WIDGET 'Card' EXACTAMENTE COMO LO TENÍAS AQUÍ DEBAJO! 👈
                    // return Card( ... );
                    return Card(
                    //Este es el margen de las tarjetas en la pantalla
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: ListTile(
                      //Bandera del país
                      leading: SizedBox(
                        width: 70.0,
                        height: 75.0,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(5.0),
                          child: SvgPicture.network(
                            country.flags.svg,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, size: 40.0,);
                            },
                            ),
                          ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Nombre del país
                          Text(country.name.common, style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                          //Capital del país
                          Text('Capital: ${country.capital.isNotEmpty ? country.capital[0] : 'N/A'}', style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis,),
                          //Población
                          Text('Población: ${country.population}', style: TextStyle(fontSize: 18.0,), overflow: TextOverflow.ellipsis,),
                          //Región
                          Text(country.region, style: TextStyle(fontSize: 18.0,), overflow: TextOverflow.ellipsis,),
                        //Subregión
                          Text(country.subregion, style: TextStyle(fontSize: 18.0,), overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                      onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // Ojo aquí: tu pantalla pide "country", y tu variable del ciclo se llama "pais"
                        builder: (context) => CountryDetailsScreen(country: country), 
                      ),
                    );
                  },
                    ),
                    
                  );
                  },
                  childCount: countries.length,
                ),
              ),
          ],
        );
      },
    );
  }
}
/*

return Card(
                    //Este es el margen de las tarjetas en la pantalla
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: ListTile(
                      //Bandera del país
                      leading: SizedBox(
                        width: 70.0,
                        height: 75.0,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(5.0),
                          child: SvgPicture.network(
                            country.flags.svg,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, size: 40.0,);
                            },
                            ),
                          ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Nombre del país
                          Text(country.name.common, style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                          //Capital del país
                          Text(country.capital.isNotEmpty ? country.capital[0] : 'N/A', style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis,),
                          //Población
                          Text('${country.population}', style: TextStyle(fontSize: 18.0,), overflow: TextOverflow.ellipsis,),
                          //Región
                          Text(country.region, style: TextStyle(fontSize: 18.0,), overflow: TextOverflow.ellipsis,),
                        //Subregión
                          Text(country.subregion, style: TextStyle(fontSize: 18.0,), overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    ),
                  );

*/
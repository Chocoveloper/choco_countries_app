import 'package:choco_countries/widgets/sliverlist.dart';
import 'package:flutter/material.dart';

class CountriesHome extends StatefulWidget {

 
  const CountriesHome({super.key});

  @override
  State<CountriesHome> createState() => _CountriesHomeState();
}

class _CountriesHomeState extends State<CountriesHome> {


  
  
  @override
  Widget build(BuildContext context) {
    return SliverCountriesList();
  }
}
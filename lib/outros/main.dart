import 'package:agenda_flutter/outros/RepositorioContato.dart';
import 'package:flutter/material.dart';

import '../entidades/Contato.dart';
import '../telas/Principal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Principal(),
    );
  }
}



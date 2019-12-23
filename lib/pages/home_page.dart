import 'package:datospordniruc/provider/dni_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // Proveedor
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Provider
  final dniProvider = new DniProvider();

  // Variables globales
  String _nombrePersonaTexto;
  String _apellidoPersonaTexto;

  // Controladores de texto
  TextEditingController _controllerNombrePersona = new TextEditingController();
  TextEditingController _controllerApellidoPersona =
      new TextEditingController();

  dynamic _datosPersona;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inicio'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            _separacion(20),
            _titulo('Ingrese el Dni'),
            _separacion(20),
            _crearDni(),
            _titulo('Los datos son:'),
            _separacion(20),
            _datosNombre(),
            _datosApellido()
          ],
        ));
  }

  Widget _datosNombre() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextField(
          controller: _controllerNombrePersona,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Nombres',
              labelText: 'Nombres',
              icon: Icon(Icons.people)),
        ));
  }

  Widget _datosApellido() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextField(
          controller: _controllerApellidoPersona,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Apellidos',
              labelText: 'Apellidos',
              icon: Icon(Icons.people)),
        ));
  }

  Widget _separacion(double tamano) {
    return SizedBox(
      height: tamano,
    );
  }

  Widget _titulo(String titulo) {
    return Container(
      child: Center(
        child: Text(titulo),
      ),
    );
  }

  Widget _crearDni() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: TextFormField(
          onChanged: (value) {
            _obtenerDni(value);
          },
          maxLength: 8,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.select_all,
              color: Color.fromRGBO(18, 83, 134, 1),
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Dni',
          ),
          keyboardType: TextInputType.number,
        ));
  }

  _obtenerDni(String value) async {
    if (value.length == 8) {
      _datosPersona = await dniProvider.datosDni(value);
      if (_datosPersona['ok']) {
        setState(() {
          // Colocando Nombre
          _nombrePersonaTexto = _datosPersona['nombres'];
          _controllerNombrePersona.text = _nombrePersonaTexto;
          // Colocando Apellido
          _apellidoPersonaTexto =
              '${_datosPersona['apellidoPaterno']} ${_datosPersona['apellidoMaterno']}';
          _controllerApellidoPersona.text = _apellidoPersonaTexto;
        });
      } else {
        print('error');
      }
    }
  }
}

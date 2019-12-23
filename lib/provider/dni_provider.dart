import 'dart:convert';
import 'package:http/http.dart' as http;

class DniProvider {
  final String _tokenApisPeru = 'TU-APIKEY';

  // Obtener datos personales mediante Dni
  Future<dynamic> datosDni(String dniPaciente) async {
    final _url =
        'http://dniruc.apisperu.com/api/v1/dni/$dniPaciente?token=$_tokenApisPeru';
    final resp = await http.get(
      _url,
      headers: {"Content-Type": "application/json"},
    );
    final decoded = json.decode(resp.body);
    if (decoded != 1) {
      return {
        'ok': true,
        'nombres': decoded['nombres'],
        'apellidoPaterno': decoded['apellidoPaterno'],
        'apellidoMaterno': decoded['apellidoMaterno']
      };
    } else {
      return {'ok': false};
    }
  }
}

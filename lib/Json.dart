import 'dart:convert';

class Json {

  List parse(String response) {
    if (response == null) {
      return [];
    }
    final List parsed = json.decode(response);
    if (parsed == null)
      return [];
    else
      return parsed;
  }
}
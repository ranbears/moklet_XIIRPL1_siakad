import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;
import '../../data/models/model_mapel.dart';
import '../../data/services/constant.dart';

class RepositoryMapel {
  RepositoryMapel();

  Future<ModelMapel> loadMapel() async {
	addCookies();
	String url = CORS_ANYWHERE + DOMAIN;
	var res = http.Request(
  	'GET',
  	Uri.parse('$url/send_request?model=moklet.mapel'),
	);
	res.headers.addAll(defaultHeader);
	http.StreamedResponse response = await res.send();
	try {
  	if (response.statusCode == 200) {
    	var jsonString = await response.stream.bytesToString();
      print(ModelMapel.fromJson(jsonDecode(jsonString)));
    	return ModelMapel.fromJson(jsonDecode(jsonString));
  	} else {
    	return ModelMapel(
        	isError: true, data: [], message: 'Gagal Bad Request');
  	}
	} catch (e) {
  	print(e);
  	return ModelMapel(isError: true, data: [], message: 'Gagal Catch');
	}
  }
  Future<http.StreamedResponse?> postMapel({required Map<String, dynamic> body}) async {
  String url = CORS_ANYWHERE + DOMAIN;
  var res = http.Request(
	'POST',
	Uri.parse('$url/send_request?model=moklet.mapel'),
  );
  res.headers.addAll(defaultHeader);
  res.body = jsonEncode(body);
  http.StreamedResponse response = await res.send();

  if (response.statusCode == 200) {
	return response;
  } else {
	print(response.reasonPhrase);
	return null;
  }
}
  Future<http.StreamedResponse?> updateMapel({required int id, required Map<String, dynamic> body}) async {
    String url = CORS_ANYWHERE + DOMAIN;
    var res = http.Request(
      'PUT',
      Uri.parse('$url/send_request?model=moklet.mapel&Id=$id'),
    );
    res.headers.addAll(defaultHeader);
    res.body = jsonEncode(body);
    http.StreamedResponse response = await res.send();

    if (response.statusCode == 200) {
      return response;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  Future<http.StreamedResponse?> deleteMapel(int id) async {
    String url = CORS_ANYWHERE + DOMAIN;
    var res = http.Request(
      'DELETE',
      Uri.parse('$url/send_request?model=moklet.mapel&id=$id'),
    );
    res.headers.addAll(defaultHeader);
    http.StreamedResponse response = await res.send();

    print('Status Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Error Reason: ${response.reasonPhrase}');
      return null;
    }
  }

}

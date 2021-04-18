import 'Model/photos.dart';
import 'package:http/http.dart' as http;

Future <List<Photos>> fetchPhotos() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/photos');
  if(response.statusCode == 200){
    var listResBody = photosFromJson(response.body);
    return listResBody;
  }
  else{
    throw Exception('Cannot get Photos');
  }
}
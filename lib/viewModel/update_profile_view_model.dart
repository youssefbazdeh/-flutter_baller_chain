
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../model/user.dart';
import '../utils/const.dart';

class UpdateProfileViewModel {
  Future<User> updateProfile(String id, User user) async {
    final url = '$base_url/user/$id';

    //final imageFile = File(user.image!);

    var request = http.MultipartRequest('PUT', Uri.parse(url));
  /*  if (user.image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        user.image!,
        contentType: MediaType('image', 'jpg'),
      ));
    }*/
    request.fields['firstname'] = user.firstname!;
    request.fields['lastname'] = user.lastname!;
    request.fields['email'] = user.email!;
    request.fields['phonenumber'] = user.phonenumber!;
    request.fields['birthday'] = user.birthday!;
    request.fields['steps'] = user.steps!.toString();
    //request.fields['password'] = user.password!;

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('mise à jour avec succès');
      return user;
    } else {
      print(response.body);
      throw Exception("Failed to update profile");
    }
  }





  Future<int> updateSteps(String id, int? steps) async {
    final url = '$base_url/user/$id';

    //final imageFile = File(user.image!);

    var request = http.MultipartRequest('PUT', Uri.parse(url));
    /*  if (user.image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        user.image!,
        contentType: MediaType('image', 'jpg'),
      ));
    }*/

    request.fields['steps'] = steps!.toString();
    //request.fields['password'] = user.password!;

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('mise à jour avec succès');
      return steps;
    } else {
      print(response.body);
      throw Exception("Failed to update profile");
    }
  }

}

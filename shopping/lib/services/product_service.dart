import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shopping/common/constants.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/models/server_response.dart';

class ProductService {
  static const String PATH = '/product';
  static const String UPLOAD_IMAGE = PATH + '/upload_image';

  Future<ServerResponse> createProduct(Product product) async {
    String url = Constants.SERVER + PATH + '/create';

    var productJson = product.toJson();
    var body = json.encode(productJson);

    try {
      http.Response response =
          await http.post(url, body: body, headers: Constants.HEADER);

      var responseJson = json.decode(response.body);
      ServerResponse serverResponse = ServerResponse.fromJson(responseJson);
      serverResponse.data = Product.fromJson(serverResponse.data);
      return serverResponse;
    } catch (error) {
      return ServerResponse(
          status: FAILED, data: null, message: error.toString());
    }
  }

  Future<ServerResponse> editProduct(Product product) async {
    String url = Constants.SERVER + PATH + '/edit';

    var productJson = product.toJson();
    var body = json.encode(productJson);

    try {
      http.Response response =
          await http.put(url, body: body, headers: Constants.HEADER);

      var responseJson = json.decode(response.body);
      ServerResponse serverResponse = ServerResponse.fromJson(responseJson);
      serverResponse.data = Product.fromJson(serverResponse.data);
      return serverResponse;
    } catch (error) {
      return ServerResponse(
          status: FAILED, data: null, message: error.toString());
    }
  }

  Future<ServerResponse> getAllProducts() async {
    String url = Constants.SERVER + PATH + '/getAll';

    try {
      http.Response response = await http.get(url, headers: Constants.HEADER);

      var responseJson = json.decode(response.body);
      ServerResponse serverResponse = ServerResponse.fromJson(responseJson);
      List<Product> products = [];
      for (var data in serverResponse.data) {
        products.add(Product.fromJson(data));
      }
      serverResponse.data = products;
      return serverResponse;
    } catch (error) {
      return ServerResponse(status: FAILED, message: error, data: null);
    }
  }

  uploadImage(File file) async {
    String fileUrl;
    ServerResponse serverResponse;
//    String url = Constants.SERVER + UPLOAD_IMAGE;
    String url = Constants.SERVER + '/upload';
    String identifier = DateTime.now().millisecondsSinceEpoch.toString();
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;
    var body = {
      'image': base64Image,
      'fileName': fileName,
      'identifier': identifier,
    };

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      serverResponse = ServerResponse.fromJson(json.decode(response.body));
      if (serverResponse.status == SUCCESS) {
        fileUrl = serverResponse.data;
      }
      serverResponse.data = fileUrl;
    } else {
      serverResponse =
          ServerResponse(status: FAILED, message: 'could not upload...');
    }
    return serverResponse;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../common/constants.dart';
import '../models/product.dart';
import '../models/server_response.dart';
import 'package:multipart_request/multipart_request.dart';

class ProductService {
  static const String PATH = '/product';
  static const String UPLOAD_IMAGE = '/upload_image';

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

  // uploadImage(File file) async {
  //   String fileUrl;
  //   ServerResponse serverResponse;
  //   String url = Constants.SERVER + '/product/upload_image';
  //   // String url = Constants.SERVER + '/upload';
  //   String identifier = DateTime.now().millisecondsSinceEpoch.toString();
  //   String base64Image = base64Encode(file.readAsBytesSync());
  //   String fileName = file.path.split("/").last;
  //   var bodyJson = {
  //     'image': base64Image,
  //     'fileName': fileName,
  //     'identifier': identifier,
  //   };
  //   var body = json.encode(bodyJson);
  //
  //   try {
  //     http.Response response = await http.post(url, body: body, headers: Constants.HEADER);
  //     // http.Response response = await http.post(url, body: body, headers: Constants.HEADER);
  //     if (response.statusCode == 200) {
  //       serverResponse = ServerResponse.fromJson(json.decode(response.body));
  //       if (serverResponse.status == SUCCESS) {
  //         fileUrl = serverResponse.data;
  //       }
  //       serverResponse.data = fileUrl;
  //     } else {
  //       serverResponse =
  //           ServerResponse(status: FAILED, message: 'could not upload...');
  //     }
  //     return serverResponse;
  //   } catch (error) {
  //     return ServerResponse(status: FAILED, message: error, data: null);
  //   }
  // }

  // Future<ServerResponse> uploadImage(Product product) async {
  //   String url = Constants.SERVER + UPLOAD_IMAGE;
  //   String fileUrl;
  //   ServerResponse serverResponse;
  //   String identifier = DateTime.now().millisecondsSinceEpoch.toString();
  //
  //   try {
  //     String fileName = product.image.path.split("/").last;
  //     String base64Image = base64Encode(product.image.readAsBytesSync());
  //
  //     var bodyJson = {
  //       'image': base64Image,
  //       'fileName': fileName,
  //       'identifier': identifier,
  //     };
  //     var body = json.encode(bodyJson);
  //     http.Response response =
  //         await http.post(url, body: body, headers: Constants.HEADER_FORM_DATA);
  //
  //     var responseJson = json.decode(response.body);
  //     ServerResponse serverResponse = ServerResponse.fromJson(responseJson);
  //     // serverResponse.data = Product.fromJson(serverResponse.data);
  //     return serverResponse;
  //   } catch (error) {
  //     return ServerResponse(
  //         status: FAILED, data: null, message: error.toString());
  //   }
  // }

  Future<ServerResponse> uploadImageMultiPart(
      Product product, String imagePath) async {
    ServerResponse serverResponse;
    String url = Constants.SERVER + UPLOAD_IMAGE;

    try {
      // String filename = product.image.path.split("/").last;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      request.fields.addAll({'productId': '${product.id.toString()}'});
      // var res = await request.send();
      // print(res);
      http.StreamedResponse response = await request.send();
      // logger.d(response.stream.bytesToString());
      serverResponse =
          ServerResponse(status: SUCCESS, message: '...', data: null);
      return serverResponse;
    } catch (error) {
      serverResponse =
          ServerResponse(status: FAILED, message: error.toString(), data: null);
      logger.d(error.toString());
      return serverResponse;
    }
  }
}

// try {
//   var request = MultipartRequest();
//
//   request.setUrl(url);
//   request.addFile("image", imagePath);
//
//   Response response = request.send();
//
//   response.onError = () {
//     print("Error");
//   };
//
//   response.onComplete = (response) {
//     print(response);
//   };
//
//   response.progress.listen((int progress) {
//     print("progress from response object " + progress.toString());
//   });
// } catch (error) {
//   print(error);
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:free_image_search_app/utils/constants.dart';

class PixabayPage extends StatefulWidget {
  const PixabayPage({Key? key}) : super(key: key);

  @override
  State<PixabayPage> createState() => _PixabayPageState();
}

class _PixabayPageState extends State<PixabayPage> {
  // 取得した画像データを入れる
  List imageList = [];

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: '入力してみよう',
          ),
          onFieldSubmitted: (text) {
            print(text);
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> image = imageList[index];
          return Image.network(image['previewURL']);
        },
      ),
    );
  }

  Future<void> fetchImage() async {
    final response = await Dio().get(Constants.baseAPI);

    imageList = response.data['hits'];
    // 画像を更新
    setState(() {});
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:free_image_search_app/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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
    fetchImage('');
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
            fetchImage(text);
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
          return InkWell(
            onTap: () async {
              // 一時保存に使えるフォルダ情報を取得する
              Directory dir = await getTemporaryDirectory();

              Response response = await Dio().get(
                image[('webformatURL')],
                options: Options(
                  // 画像をダウンロードするときは ResponseType.bytes を指定します。
                  responseType: ResponseType.bytes,
                ),
              );
              // フォルダの中に image.png という名前でファイルを作り、そこに画像データを書き込む。
              File imageFile = await File('${dir.path}/image.png').writeAsBytes(response.data);

              // path指定してシェアする
              await Share.shareFiles([imageFile.path]);
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  image['previewURL'],
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.thumb_up_alt_outlined,
                          size: 14,
                        ),
                        Text('${image['likes']}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> fetchImage(String text) async {
    final response = await Dio().get(Constants().baseAPI(text));

    imageList = response.data['hits'];
    // 画像を更新
    setState(() {});
  }
}

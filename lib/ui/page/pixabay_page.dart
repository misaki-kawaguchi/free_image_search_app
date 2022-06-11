import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:free_image_search_app/utils/constants.dart';

class PixabayPage extends StatefulWidget {
  const PixabayPage({Key? key}) : super(key: key);

  @override
  State<PixabayPage> createState() => _PixabayPageState();
}

class _PixabayPageState extends State<PixabayPage> {
  @override
  void initState() {
    super.initState();
    fetchImage();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
  
  Future<void> fetchImage() async{
    final response = await Dio().get(Constants.baseAPI);

    print(response.data);
  }
}

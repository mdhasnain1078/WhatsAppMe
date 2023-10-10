import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';
import 'package:whatsappme/common/widget/custom_icon_button.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  List<Widget> imageList = [];
  int currentPage = 0;
  int? lastPage;
  handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent <= 0.33) return;
    if (currentPage == lastPage) return;
    fetchAllImage();
  }

  fetchAllImage() async {
    lastPage = currentPage;
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();

    List<AssetPathEntity> album = await PhotoManager.getAssetPathList(
        type: RequestType.image, onlyAll: true);

    List<AssetEntity> photos = await album[0].getAssetListPaged(
      page: currentPage,
      size: 24,
    );
    List<Widget> temp = [];

    for (var asset in photos) {
      temp.add(FutureBuilder(
          future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.done
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(snapshot.data),
                    borderRadius: BorderRadius.circular(5),
                    splashFactory: NoSplash.splashFactory,
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: context.theme.greyColor!.withOpacity(0.4),
                              width: 1),
                          image: DecorationImage(
                              image: MemoryImage(snapshot.data as Uint8List),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                )
              : const SizedBox()));
    }
    setState(() {
      imageList.addAll(temp);
      currentPage++;
    });
  }

  @override
  void initState() {
    fetchAllImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WhatsApp",
          style: TextStyle(color: context.theme.authAppBarTextColor),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        leading: CustomIconButton(
            onTap: () => Navigator.of(context).pop(), icon: Icons.arrow_back),
        actions: [CustomIconButton(onTap: () {}, icon: Icons.more_vert)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroll){
            handleScrollEvent(scroll);
            return true;
          },
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: imageList.length,
                itemBuilder: (context, i) => imageList[i])),
      ),
    );
  }
}

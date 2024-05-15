import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SAUUploadImageView extends StatefulWidget {
  ///外部传入：图片urls
  final List<String> urls;

  ///外部传入：是否处于编辑状态
  final bool isEdit;

  ///外部传入：最大可上传的图片数
  final int maxCount;

  ///外部传入：最大可上传的图片大小
  final int? maxSize;

  ///可选的外部传入：iOS原生界面路径
  final String iOSNativePath;

  ///可选的外部传入：添加图片回调
  final ValueChanged<List<String>>? changeBack;

  final EdgeInsetsGeometry? padding;

  SAUUploadImageView(
      this.urls,
      this.isEdit,
      this.maxCount, {
        this.iOSNativePath = 'OPMContext/UploadImage',
        this.changeBack,
        this.padding,
        this.maxSize,
      });

  @override
  State<StatefulWidget> createState() => _SAUUploadImageViewState(urls, isEdit);
}

class _SAUUploadImageViewState extends State<SAUUploadImageView> {
  ///所有图片的url
  List<String> imageUrls;

  ///是否可以编辑
  final bool isEdit;

  ///当前图片index
  int? currentIndex;

  _SAUUploadImageViewState(this.imageUrls, this.isEdit);

  // Future<ZCUploadImageResponseModel?> _getImageUrlFromNative(int index) async {
  //   final dataRequest = <String, dynamic>{
  //     'MaxCount': widget.maxCount,
  //     'CurrentIndex': index,
  //     'IsEdit': widget.isEdit,
  //     'Images': imageUrls,
  //     'iOSPath': widget.iOSNativePath,
  //     'MaxSize': widget.maxSize ?? 0,
  //   };
  //
  //   final parameters = ZCUploadImageRequestModel(data: dataRequest);
  //   final request = ZCBridgeRequestModel("uploadimage", parameters.toJson());
  //   final model = await ZCFlutterBridge().flutterCallNative(request);
  //   if (model.code == ZCBridgeResponseCode.success) {
  //     return ZCUploadImageResponseModel(
  //         ZCUploadImageResponseModel.fromJson(model.data!).urls);
  //   } else {
  //     return null;
  //   }
  // }

  void deleteImage(int index) {
    if (imageUrls.isNotEmpty) {
      setState(() {
        imageUrls.removeAt(index);
        if (null != widget.changeBack) {
          widget.changeBack!(imageUrls);
        }
      });
    }
    // zucheLogger('deleteImage');
  }

  Future<void> updateImage(int index) async {
    // final model = await _getImageUrlFromNative(index);
    // setState(() {
    //   if (null != model) {
    //     imageUrls = model.urls;
    //   } else {}
    //   if (null != widget.changeBack) {
    //     widget.changeBack!(imageUrls);
    //   }
    // });
    // zucheLogger('addurl ${imageUrls.length}');
  }

  Widget _buildAddNewPhotoView(int index) {
    return Container(
        child: Material(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
            child: InkWell(
              onTap: () => updateImage(index),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFDDDDDD)),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Image(
                  image: AssetImage('assets/transfer/image/imagepicker_add.png'),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildImagePhotoView(int index) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
            child: InkWell(
              onTap: () => updateImage(index),
              child: CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    var imageSize = Size(90, 70);
                    final renderObject = context.findRenderObject();
                    if (null != renderObject) {
                      imageSize = renderObject.semanticBounds.size;
                    }
                    return Image.asset(
                      'assets/common/image/photo_load_error.png',
                      fit: BoxFit.fill,
                      height: imageSize.height,
                      width: imageSize.width,
                    );
                  }),
            ),
          ),
          Offstage(
            offstage: !widget.isEdit,
            child: Container(
              child: Material(
                color: Color(0x00000000),
                child: InkWell(
                  onTap: () => isEdit ? deleteImage(index) : null,
                  child: Container(
                    alignment: Alignment.center,
                    width: 15,
                    height: 15,
                    decoration: ShapeDecoration(
                        color: Color(0xFF333333), shape: CircleBorder()),
                    child: Text(
                      'X',
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final curLength = imageUrls.length;
    var childCount = 0;
    if (curLength < widget.maxCount) {
      childCount = isEdit ? curLength + 1 : curLength;
    } else {
      childCount = curLength;
    }
    return GridView.custom(
      padding:
      widget.padding ?? EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 15,
        crossAxisSpacing: 6,
        childAspectRatio: 95 / 70,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (content, index) {
          if (index >= curLength && isEdit) {
            return _buildAddNewPhotoView(index);
          } else {
            return _buildImagePhotoView(index);
          }
        },
        childCount: childCount,
      ),
    );
  }
}

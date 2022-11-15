// @dart=2.9
import 'dart:io';
import 'package:feelathomeproject/util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/loading_widget.dart';

Directory _appDocsDir;

class PreviewScreen extends StatefulWidget {
  // just for E2E test. if true we create our images names from datetime.
  // Else it's just a name to assert image exists
  final int sellerId;
  final String imgPath;
  final int photoOrderDetailsId;
  final String fromPage;
  PreviewScreen(
      {this.sellerId, this.imgPath, this.photoOrderDetailsId, this.fromPage});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen>
    with TickerProviderStateMixin {
  init() async {
    _appDocsDir = await getApplicationDocumentsDirectory();
  }

  @override
  void initState() {
    super.initState();
    print('SELLER ID: -------------------');
    print(widget.sellerId);
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: GreenBottom,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text('Preview Image',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Consumer<UserViewModel>(builder: (context, model, child) {
          return model.response == Response.Success
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Image.file(
                          File(widget.imgPath),
                          fit: BoxFit.cover,
                        ),
                        // Image(
                        //   image: NetworkToFileImage(
                        //     url: '${widget.imgPath}',
                        //     file: fileFromDocsDir("${widget.imgPath.split('/').last}"),
                        //     debug: true,
                        //   ),
                        //   errorBuilder: (context, error, stackTrace) {
                        //     return Text('Download image failed.');
                        //   },
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 60.0,
                          color: Colors.black,
                          child: Center(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(GreenBottom),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 25))),
                                onPressed: () async {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  //  await Provider.of<UserViewModel>(context,
                                    //        listen: false)
                                      //  .sendOrderChatFile(
                                        //    widget.photoOrderDetailsId,
                                          //  file: widget.imgPath.toString(),
                                            //flag: '0');
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Ok   ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18)),
                                  ],
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Loading();
        }));
  }
}

// @dart=2.9
import 'package:feelathomeproject/model/support_model.dart';
import 'package:feelathomeproject/screens/search_popup.dart';
import 'package:feelathomeproject/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../model/countries_model.dart';
import '../network/shared_preference_helper.dart';
import '../util/light_color.dart';
import '../util/styles.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/loading_widget.dart';
import 'map_view.dart';

class ChatRoom extends StatefulWidget {
  int index = 0;

  ChatRoom({this.index});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  UserViewModel _userViewModel;
  String name = "---";
  @override
  void initState() {
    super.initState();
    _LoadData();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
  }

  Future<void> _LoadData() async {
    SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
    var userModel = await sharedPreferenceHelper.getUser();
    String name = userModel.customer.name;
    setState(() {
      this.name = name;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "COMPLAINTS",
          style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 20.5,
              fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer<UserViewModel>(builder: (contextModel, model, child) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: _conversation(model.supportList[widget.index]),
                  ),
                ),
              ),
              buildChatComposer(widget.index, model.supportList[widget.index])
            ],
          );
        }),
      ),
    );
  }

  Widget buildChatComposer(int index, SupportTicketData supportList) {
    final ReplayController = TextEditingController();
    TextEditingController myController = TextEditingController()
      ..text = supportList.comments != null ? supportList.comments : " ";
    bool isClosed = false;
    double rate = 1;
    if (supportList.status.isNotEmpty || supportList.status != null) {
      if (supportList.status == "closed") {
        isClosed = true;
      }
    }
    return isClosed
        ? Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                    "Support Ticket closed. If you have any queries, please raise a new ticket",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 13.0)),
                SizedBox(height: 10),
                TextField(
                  controller: myController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "Enter Comments here",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                        color: GreenBottom,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: GreenBottom))),
                ),
                const SizedBox(height: 15),
                new RatingBar.builder(
                  initialRating: supportList.rating != null
                      ? num.tryParse(supportList.rating)?.toDouble()
                      : 0.0,
                  minRating: 1,
                  tapOnlyMode: false,
                  updateOnDrag: false,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 28.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: GreenBottom,
                  ),
                  onRatingUpdate: (rating) {
                    rate = rating;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 40.0, left: 40.0, top: 10.0, bottom: 10),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0))),
                              overlayColor: MaterialStateProperty.all(GreenHi),
                              backgroundColor:
                                  MaterialStateProperty.all(GreenBottom),
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  child: Text("SUBMIT",
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.white,
                                          fontSize: 15)),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              if (myController.text.toString() != null) {
                                var res = false;
                                res = await _userViewModel.PostRating(
                                    supportList.id,
                                    rate,
                                    myController.text.toString());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: ReplayController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your comments ...',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: () async {
                    if (ReplayController.text.toString().isNotEmpty) {
                      var res = false;
                      res = await _userViewModel.PostReply(name,ReplayController.text.toString(), supportList.id);
                    }else{
                      showToast("Please enter your comments",color: Colors.red);
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: GreenBottom,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget _conversation(SupportTicketData supportList) {
    bool isMe = false;
    return Consumer<UserViewModel>(builder: (contextModel, model, child) {
      return model.response == Response.Success &&
          supportList.history  != null &&
          supportList.history.isNotEmpty
          ?ListView.builder(
        reverse: false,
        itemCount: supportList.history.length,
        itemBuilder: (context, int index) {
          if (supportList.history[index].is_customer == "1") {
            isMe = true;
          }
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isMe)
                      const CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            AssetImage("assets/images/logo_text.png"),
                        backgroundColor: Colors.white,
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(isMe ? 12 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 12),
                          )),
                      child: Text(supportList.history[index].content != null
                          ? supportList.history[index].content
                          : ""),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe)
                        SizedBox(
                          width: 40,
                        ),
                      Icon(
                        Icons.done_all,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(supportList.history[index].replied_on != null
                          ? supportList.history[index].replied_on
                          : "")
                    ],
                  ),
                )
              ],
            ),
          );
        }):Container(
        margin: EdgeInsets.only(top: 20),
        child: Center(
          child: Text("No Data"),
        ),
      );
    });
  }
}

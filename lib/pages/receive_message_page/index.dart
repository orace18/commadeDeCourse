import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:web_socket_channel/io.dart';
import '../start_course_process_page/move_to_startplace_page/index.dart';

class ReceiveMessagePage extends StatefulWidget{
  String receiverid;

  ReceiveMessagePage({required this.receiverid});

  @override
  State<StatefulWidget> createState() {
    return ReceiveMessagePageState();
  }
}

class ReceiveMessagePageState extends State<ReceiveMessagePage>{

  late IOWebSocketChannel channel;
  late bool connected;

  String myid = GetStorage().read('id').toString();
  late String recieverid;

  String auth = "chatapphdfgjd34534hjdfk"; //auth key

  List<MessageData> msglist = [];

  TextEditingController msgtext = TextEditingController();

  @override
  void initState() {
    recieverid = widget.receiverid;
    connected = false;
    msgtext.text = "";
    channelconnect();
    super.initState();
  }

  channelconnect(){
    try{
      channel = IOWebSocketChannel.connect("ws://$chatSocketUrl/$myid");
      channel.stream.listen((message) {
        print(message);
        setState(() {
          if(message == "connected"){
            connected = true;
            setState(() { });
            print("Connection establised.");
          }else if(message == "send:success"){
            print("Message send success");
            setState(() {
              msgtext.text = "";
            });
          }else if(message == "send:error"){
            print("Message send error");
          }else if (message.substring(0, 6) == "{'cmd'") {
            print("Message data");
            message = message.replaceAll(RegExp("'"), '"');
            var jsondata = json.decode(message);

            msglist.add(MessageData(
              msgtext: jsondata["msgtext"],
              userid: jsondata["userid"],
              isme: false,
            )
            );
            setState(() {

            });
          }
        });
      },
        onDone: () {

          print("Web socket is closed");
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          print(error.toString());
        },);
    }catch (_){
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendmsg(String sendmsg, String id) async {
    if(connected == true){
      String msg = "{'auth':'$auth','cmd':'send','userid':'$id', 'msgtext':'$sendmsg'}";
      setState(() {
        msgtext.text = "";
        msglist.add(MessageData(msgtext: sendmsg, userid: myid, isme: true));
      });
      channel.sink.add(msg);
    }else{
      channelconnect();
      print("Websocket is not connected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Message"),
          leading: Icon(Icons.circle, color: connected?Colors.greenAccent:Colors.redAccent),

          titleSpacing: 0,
        ),
        body: Container(
            child: Stack(children: [
              Positioned(
                  top:0,bottom:70,left:0, right:0,
                  child:Container(
                      padding: EdgeInsets.all(15),
                      child: SingleChildScrollView(
                          child:Column(children: [

                            Container(
                              child:Text("Your Messages", style: TextStyle(fontSize: 20)),
                            ),

                            Container(
                                child: Column(
                                  children: msglist.map((onemsg){
                                    return Container(
                                        margin: EdgeInsets.only( //if is my message, then it has margin 40 at left
                                          left: onemsg.isme?40:0,
                                          right: onemsg.isme?0:40, //else margin at right
                                        ),
                                        child: Card(
                                            color: onemsg.isme?Colors.blue[100]:Colors.red[100],
                                            //if its my message then, blue background else red background
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(15),

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Container(
                                                      child:Text(onemsg.isme?"ID: ME":"ID: " + onemsg.userid)
                                                  ),

                                                  Container(
                                                    margin: EdgeInsets.only(top:10,bottom:10),
                                                    child: Text("Message: " + onemsg.msgtext, style: TextStyle(fontSize: 17)),
                                                  ),

                                                ],),
                                            )
                                        )
                                    );
                                  }).toList(),
                                )
                            )
                          ],)
                      )
                  )
              ),

              Positioned(  //position text field at bottom of screen

                bottom: 0, left:0, right:0,
                child: Container(
                    color: Colors.black12,
                    height: 70,
                    child: Row(children: [

                      Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: TextField(
                              controller: msgtext,
                              decoration: InputDecoration(
                                  hintText: "Enter your Message"
                              ),
                            ),
                          )
                      ),

                      Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            child:Icon(Icons.send),
                            onPressed: (){
                              if(msgtext.text != ""){
                                sendmsg(msgtext.text, recieverid);
                              }else{
                                print("Enter message");
                              }
                            },
                          )
                      )
                    ],)
                ),
              )
            ],)
        )
    );
  }
}
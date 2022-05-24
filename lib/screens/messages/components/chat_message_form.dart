import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/models/ChatMessage.dart';
import 'package:shop_app/models/Person.dart';
import 'package:web_socket_channel/io.dart';

import '../../../constants.dart';

class ChatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage>{

  late IOWebSocketChannel channel; //channel varaible for websocket
  late bool connected; // boolean value to track connection status

  String myid = ''; //my id
  String recieverid = ''; //reciever id
  late int chatRoom;
  // swap myid and recieverid value on another mobile to test send and recieve
  String auth = "chatapphdfgjd34534hjdfk"; //auth key

  //List<MessageData> msglist = [];
  List<ChatMessage> chatMessage = [];

  TextEditingController msgtext = TextEditingController();

  @override
  void initState() {
    connected = false;
    msgtext.text = "";
    channelconnect();
    super.initState();
  }
  Future<void> sendmsg(String sendmsg, String id) async {
    if(connected == true){
      String msg = "{'auth':'$auth','cmd':'send','userid':'$id', 'msgtext':'$sendmsg'}";
      setState(() {
        msgtext.text = "";
        chatMessage.add(ChatMessage(text: sendmsg, userId: int.parse(myid), isSender: true));
      });
      channel.sink.add(msg); //send message to reciever channel
    }else{
      channelconnect();
      print("Websocket is not connected.");
    }
  }
  channelconnect(){ //function to connect
    try{
      channel = IOWebSocketChannel.connect("ws://ec2-13-209-40-159.ap-northeast-2.compute.amazonaws.com:6060/$myid"); //channel IP : Port
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

            chatMessage.add(ChatMessage( //on message recieve, add data to model
              text: jsondata["msgtext"],
              userId: jsondata["userid"],
              isSender: false,
              chatRoom: chatRoom,
            )
            );
            setState(() { //update UI after adding data to message model

            });
          }
        });
      },
        onDone: () {
          //if WebSocket is disconnected
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



  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    // for(int i=0; i<loginPerson.Message.length; i++) {
    //   if(loginPerson.Message[i].chatRoom == loginPerson.chatclick) {
    //     chatMessage.add(loginPerson.Message[i]);
    //   }
    // }
    myid = 111.toString();
        // loginPerson.userid;
    recieverid = 222.toString();
        // loginPerson.chatUserClick;
    chatRoom = loginPerson.chatclick;

    return Scaffold(
        body: Container(
            child: Stack(children: [
              Positioned(
                  top:0,bottom:70,left:0, right:0,
                  child:Container(
                      padding: EdgeInsets.all(15),
                      child: SingleChildScrollView(
                          child:Column(children: [
                            Container(
                                child: Column(
                                  children: chatMessage.map((onemsg){
                                    return Container(
                                        margin: EdgeInsets.only( //if is my message, then it has margin 40 at left
                                          left: onemsg.isSender?40:0,
                                          right: onemsg.isSender?0:40, //else margin at right
                                        ),
                                        child: Card(
                                            color: onemsg.isSender?kPrimaryColor:Colors.white,
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(top:10,bottom:10),
                                                    child: Text(onemsg.text,
                                                        style:
                                                        TextStyle(fontSize: 17,
                                                            color: onemsg.isSender?Colors.white:Colors.black)),
                                                  ),
                                                ],
                                              ),
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
                    color: Colors.white,
                    height: 70,
                    child: Row(children: [

                      Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: TextField(
                              controller: msgtext,
                              decoration: InputDecoration(
                                  hintText: "메시지를 입력하세요",
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
                                sendmsg(msgtext.text, recieverid); //send message with webspcket
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

// class MessageData{ //message data model
//   String msgtext, userid;
//   bool isme;
//   MessageData({required this.msgtext, required this.userid, required this.isme});
//
// }
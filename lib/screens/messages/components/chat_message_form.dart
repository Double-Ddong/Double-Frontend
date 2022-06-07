import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/ChatMessage.dart';
import 'package:shop_app/models/Person.dart';
import 'package:web_socket_channel/io.dart';
import '../../../constants.dart';

late Response response;
var dio = Dio();

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
  String auth = "chatapphdfgjd34534hjdfk"; //auth key

  List<ChatMessage> chatMessage = [];

  TextEditingController msgtext = TextEditingController();

  @override
  void initState() {
    connected = false;
    msgtext.text = "";
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Person p = ModalRoute.of(context)?.settings.arguments as Person;
    channelconnect(p.userid);
    for(int i=0; i<p.Message.length; i++) {
      if(p.Message[i].chatRoom == p.chatclick) {
        chatMessage.add(p.Message[i]);
      }
    }
  }

  Future<void> sendmsg(String sendmsg, String id, int chatRoom) async {
    if(connected == true){
      String msg = "{'auth':'$auth','cmd':'send','userid':'$id', 'msgtext':'$sendmsg'}";
      setState(() {
        msgtext.text = "";
        chatMessage.add(ChatMessage(text: sendmsg, userId: myid, isSender: true, chatRoom: 1));
      });
      channel.sink.add(msg); //send message to reciever channel
    }else{
      channelconnect(myid);
      print("Websocket is not connected.");
    }
  }

  channelconnect(String myid){ //function to connect
    try{
      channel = IOWebSocketChannel.connect("ws://$chatServer:6060/$myid"); //channel IP : Port
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
                            onPressed: () async {
                              if(msgtext.text != ""){
                                myid = loginPerson.userid.toString();
                                recieverid = loginPerson.chatUserClick.toString();
                                chatRoom = loginPerson.chatclick;
                                String text = msgtext.text;
                                sendmsg(msgtext.text, recieverid, chatRoom);//send message with webspcket
                                //해당 메세지를 채팅db에 저장한다.
                                response = await dio.post('http://$apiServer:3000/chat/putChatMessage', data: {'SendID' : myid, 'ReceiveID' : recieverid, 'Message' : text, 'ChatRoom' : chatRoom});
                                Map responseBody1 = response.data;
                                bool success = responseBody1['success'];
                                if(success){
                                  loginPerson.Message.add(ChatMessage(text: text, userId: myid, chatRoom: chatRoom, isSender: true));
                                }
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
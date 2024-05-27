import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/messages/pages/singlechat.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class MessageScreen extends StatefulWidget {
  final WebSocketChannel channel;
  
  const MessageScreen({super.key,required this.channel});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late bool _isConnected;
  late WebSocketChannel _channel;
  @override
  void initState() {
        super.initState();

    _isConnected=false;
    _channel=widget.channel;
    _connectWebSocket();
  }


void _connectWebSocket(){
  _channel.stream.listen((message) {
    setState(() {
          _isConnected=true;

    });
   },
   onDone: () {
     setState(() {
       _isConnected=false;
     });
   },
   onError: (error){
    setState(() {
      _isConnected=false;
    });
   },
   cancelOnError: true
   
   );
   Future.delayed(Duration(seconds: 1),(){
    setState(() {
      _isConnected=_channel.closeCode==null;
    });
   }); 
}


 
 
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        
        automaticallyImplyLeading: false,
        title: Text(_isConnected?'connected':'notconnected',style:style,),
        backgroundColor: black,
        
        ),
      body: Center(
        child: ListView.separated(
          
          separatorBuilder: (context, index) {
            return const SizedBox(height: 
            1 ,);
          },
          itemCount: 10,
          itemBuilder:(context, index) {
          
          return GestureDetector(
            onTap: () {
              navigate(context, SingleChat());
            },
      child: Padding(
        padding: const EdgeInsets.only(top:10.0,left:10,right: 8),
        child: Row(children: [
        
        Container(
            width: 80,
            height: 70 ,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kgrey,
              
            ),
          ),
          kwidth,
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Text('Name',style: nostyle,),
           Text('good morning',style: nostyle,),
        
            ],
          )),
            Text('12.00pm',style: nostyle,)
        
        
        ],),
      )
          ,
       
          );
        },),
      ),
    );
  }
}






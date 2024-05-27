import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
 late final IOWebSocketChannel channel;
  MessageBloc(String webSocketUrl) : super(MessageInitial()) {
    channel=IOWebSocketChannel.connect(webSocketUrl);

    
    on<ConnectWebSocket>((event, emit)async {
      channel.stream.listen((message) {
        emit(WebSocketConnected());
       },
       onDone: () {
         emit(WebSocketDisconnected());
       },
       onError: (error){
        emit(WebSocketDisconnected());
       },
       cancelOnError: true
       
       );
       Future.delayed(const Duration(seconds: 1),(){
        if(channel.closeCode==null){
          emit(WebSocketConnected());
        }else{
          emit(WebSocketDisconnected());
        }
       });

    });

    on<DisconnectWebSocket>((event, emit)async{
      await channel.sink.close();
      emit(WebSocketDisconnected());
    });
  }
}

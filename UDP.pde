
/*
  create 
 */

boolean sendMsg = false;

int portListen  = 13999;
int portSend    = 15999;

String ip = "127.0.0.1";

//network comunication
void setupNetwork() {
  udp = new UDP( this, portListen );
  udp.listen( true );
}

/*
 send and indivisual msg 
 tag -> "/s"
 float number
 msg -> "/s 2.12"
*/
void sendMsgFloat(String tag, float number) {
  String message = tag+" "+number;
  udp.send( message, ip, portSend );
}
////----
void sendMsgDensity(String tag, float number) {
  String message = tag+" "+number;
  udp.send( message, ip, portSend );
}
//////////

void getMsg(){
  
}

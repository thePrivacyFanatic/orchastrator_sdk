abstract interface class Channel {
  void init(String state, Function(String transaction) send);
  void receive(String transaction);
  String dump();
}
abstract interface class Channel {
  void init(String state, Function(String transaction) send);
  void receive(String transaction);
  void sync(List<String> transactions);
  String dump();
}
class MetaData {
  final int sid;
  final int uid;
  final int timestamp;

  MetaData({required this.sid, required this.uid, required this.timestamp});
}

class Signal {
  final String content;
  final MetaData? meta;

  Signal({required this.content, this.meta});
}

abstract interface class Channel {
  void init(
    String state,
    Function(String content) send,
    Stream<Signal> missedTransactions,
  );
  void receive(Signal transaction);
  String dump();
}

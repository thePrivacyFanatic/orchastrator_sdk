import 'dart:convert';

import 'package:flutter/material.dart';

class MetaData {
  final int sid;
  final int uid;
  final int timestamp;

  MetaData({required this.sid, required this.uid, required this.timestamp});

  MetaData.fromJson(Map<String, dynamic> json)
    : sid = json["sid"] as int,
      uid = json["uid"] as int,
      timestamp = json["timestamp"] as int;

  Map<String, dynamic> toJson() => {'sid': sid, 'uid': uid, "timestamp": timestamp};
}

class Signal {
  final String content;
  final MetaData? meta;

  Signal({required this.content, this.meta});

  Signal.fromJson(Map<String, dynamic> json)
    : content = json["content"] as String,
      meta = MetaData.fromJson(json["meta"]);

  Map<String, dynamic> toJson() => {'content': content, 'meta': jsonEncode(meta)};
}

abstract class ObjectiveWidget extends StatelessWidget {
  final Stream<Signal> transactions;
  final Function(String transaction) send;

  const ObjectiveWidget({super.key, required this.transactions, required this.send});
}

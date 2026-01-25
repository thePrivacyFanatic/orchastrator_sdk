import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';



class Signal {
  final String content;
  final int sid;
  final int uid;
  final int timestamp;

  Signal({required this.content, required this.sid, required this.uid, required this.timestamp});

  Signal.fromJson(Map<String, dynamic> json)
    : content = json["content"] as String,
      sid = json["sid"] as int,
      uid = json["uid"] as int,
      timestamp = json["timestamp"] as int;

  Map<String, dynamic> toJson() => {'content': content, "sid": sid, "uid": uid, "timestamp": timestamp};
}

abstract class ObjectiveWidget extends StatelessWidget {
  final Stream<Signal> input;
  final StreamController<Stream> send;
  final File state;

  const ObjectiveWidget({super.key, required this.input, required this.send, required this.state});

}

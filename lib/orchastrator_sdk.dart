import 'package:flutter/material.dart';

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

abstract class ObjectiveWidget extends StatelessWidget {
  final Stream<Signal> transactions;

  const ObjectiveWidget({super.key, required this.transactions});
}


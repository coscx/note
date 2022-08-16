import 'package:flutter/material.dart';
import 'package:flutter_note/pages/hand/widget/note_board.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HandPage extends StatelessWidget {
  final logic = Get.find<HandLogic>();
  final state = Get.find<HandLogic>().state;

  @override
  Widget build(BuildContext context) {
    return NoteBoard();
  }
}

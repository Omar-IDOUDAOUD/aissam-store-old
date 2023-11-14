import 'package:aissam_store/view/conversation/message_modal.dart';
import 'package:aissam_store/view/conversation/widgets/messages/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class MessagesSectionByDate extends StatelessWidget {
  const MessagesSectionByDate(
      {super.key, required this.messages, required this.date});

  final List<Message> messages;
  final DateTime date;

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MultiSliver(
//       pushPinnedChildren: true,
//       children: [
//         SliverPinnedHeader(
//           child: Container(
//             color: Colors.red,
//             padding: EdgeInsets.all(15),
//             child: Text('Date time'),
//           ),
//         ),
//         SliverList.builder(
//           itemCount: 3,
//           itemBuilder: (_, i) => buildMessageWidget(
//             MessageWidgetParameters(
//               data: Message(
//                 dateTime: DateTime.now(),
//                 content: 'Hello!! ifiosdfio isjdfj sdf i siofsidjr',
//                 type: MessageType.audio,
//                 isClientMessage: i == 0,
//               ),
//               isTheFirstMessage: i == 1,
//             ),
//           ),
//         )
//       ],
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader.builder(
      builder: (_, SliverStickyHeaderState state) {
        print('build sticky header');
        return Container(
          padding: EdgeInsets.all(15),
          color: Colors.green.withOpacity(state.isPinned ? 1 : 0.5),
          child: Text('DateTime'),
        );
      },
      sliver: SliverList.builder(
        itemCount: 4,
        itemBuilder: (_, i) {
          // print('Build Message');
          return buildMessageWidget(
            MessageWidgetParameters(
              data: Message(
                dateTime: DateTime.now(),
                content: 'Hello!! ifiosdfio isjdfj sdf i siofsidjr',
                type: MessageType.audio,
                isClientMessage: i == 0,
              ),
              isTheFirstMessage: i == 1,
            ),
          );
        },
      ),
    );
  }
}

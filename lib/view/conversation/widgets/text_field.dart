// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/utils/icon_loader.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MessageTextField extends StatefulWidget {
  const MessageTextField({super.key});

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController()
      ..addListener(_sendButtonAppearencHandler);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    _controller.dispose();
  }

  final _anDurSeperator = 50.milliseconds.delay;
  Future<void> _sendButtonAppearencHandler() async {
    if (_controller.text.isNotEmpty && _showAddPhotoIcon) {
      _showAttachmentIcon = false;
      setState(() {});
      await _anDurSeperator();
      _showLocationIcon = false;
      setState(() {});
      await _anDurSeperator();
      _showAddPhotoIcon = false;
      _addPhotoIconKeyValue = !_addPhotoIconKeyValue;
      setState(() {});
      await _anDurSeperator();
      _showSendButton = true;
      setState(() {});
    } else if (_controller.text.isEmpty && !_showAddPhotoIcon) {
      _showSendButton = false;
      setState(() {});
      await _anDurSeperator();
      _showAddPhotoIcon = true;
      _addPhotoIconKeyValue = !_addPhotoIconKeyValue;
      setState(() {});
      await _anDurSeperator();
      _showLocationIcon = true;
      setState(() {});
      await _anDurSeperator();
      _showAttachmentIcon = true;
      setState(() {});
    }
  }

  void _showActions() async {
    _showAddPhotoIcon = true;
    _addPhotoIconKeyValue = !_addPhotoIconKeyValue;
    setState(() {});
    await _anDurSeperator();
    _showLocationIcon = true;
    setState(() {});
    await _anDurSeperator();
    _showAttachmentIcon = true;
    setState(() {});
  }

  bool _showSendButton = false;
  bool _showAddPhotoIcon = true;
  bool _addPhotoIconKeyValue = true;
  bool _showLocationIcon = true;
  bool _showAttachmentIcon = true;
  bool _isRecordingMode = false;
  bool _showRecordElements = false;

  void _switchMode(bool isRecording) async {
    _showSendButton = isRecording;
    setState(() {});
    await _anDurSeperator();
    _isRecordingMode = isRecording;
    _showAddPhotoIcon = !isRecording;
    _addPhotoIconKeyValue = !_addPhotoIconKeyValue;
    setState(() {});
    await _anDurSeperator();
    _showLocationIcon = !isRecording;
    setState(() {});
    await _anDurSeperator();
    _showAttachmentIcon = !isRecording;
    setState(() {});
    await _anDurSeperator();
    _showRecordElements = isRecording;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        height: kToolbarHeight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kToolbarHeight / 2),
            color: Colors.grey.shade300,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: _animatedSwitcher(
                    _showRecordElements
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconLoader(FluentIcons.delete_24_regular,
                                  color: Colors.redAccent.shade400),
                              SizedBox(width: 10),
                              SizedBox(
                                height: 20,
                                width: 1,
                                child: ColoredBox(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '2:05',
                                style: Get.textTheme.bodyLarge!.copyWith(
                                  color: Colors.deepPurple.shade600,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              // Expanded(
                              //   child: ColoredBox(color: Colors.green),
                              // )
                            ],
                          )
                        : TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            style: Get.textTheme.bodyLarge!.copyWith(
                              color: CstColors.a,
                            ),
                            decoration: InputDecoration.collapsed(
                              hintStyle: Get.textTheme.bodyLarge!.copyWith(
                                color: Colors.grey,
                              ),
                              hintText: 'type here...',
                            ),
                          ),
                    useSlideAnimation: false,
                  ),
                ),
                //

                _animatedSwitcher(
                  _showAttachmentIcon
                      ? _padded(
                          IconLoader(FluentIcons.attach_24_regular,
                              color: Colors.indigoAccent.shade700,
                              width: 30,
                              key: ValueKey(_showAttachmentIcon)),
                        )
                      : SizedBox.shrink(),
                ),

                _animatedSwitcher(
                  _showLocationIcon
                      ? _padded(
                          IconLoader(FluentIcons.location_24_regular,
                              color: Colors.indigoAccent.shade700,
                              width: 30,
                              key: ValueKey(_showLocationIcon)),
                        )
                      : SizedBox.shrink(key: ValueKey(_showLocationIcon)),
                ),

                _animatedSwitcher(
                  GestureDetector(
                    key: ValueKey(_addPhotoIconKeyValue),
                    onTap: !_showAddPhotoIcon
                        ? !_isRecordingMode
                            ? _showActions
                            : null
                        : null,
                    child: _padded(
                      IconLoader(
                        _isRecordingMode
                            ? FluentIcons.pause_24_regular
                            : _showAddPhotoIcon
                                ? FluentIcons.camera_add_24_regular
                                : FluentIcons.chevron_left_24_filled,
                        color: Colors.indigoAccent.shade700,
                        width: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 7),
                SizedBox(
                  height: 20,
                  width: 1,
                  child: ColoredBox(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 10),
                _animatedSwitcher(
                  GestureDetector(
                    onTap: () => _switchMode(!_isRecordingMode),
                    key: ValueKey(_showSendButton),
                    child: IconLoader(
                      _showSendButton
                          ? FluentIcons.send_24_filled
                          : FluentIcons.mic_24_filled,
                      color: Colors.greenAccent.shade700,
                      width: 30,
                    ),
                  ),
                  useSlideAnimation: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _padded(Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5),
      child: child,
    );
  }

  Widget _animatedSwitcher(Widget child, {bool useSlideAnimation = false}) {
    return AnimatedSwitcher(
      duration: 300.milliseconds,
      child: child,
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeInBack,
      transitionBuilder: (c, a) {
        final slideAnimation = (a.isDismissed
                ? Tween<Offset>(
                    begin: Offset(-0.6, 0), //0.8
                    end: Offset.zero, //1
                  )
                : Tween<Offset>(
                    begin: Offset(0.6, 0), //1.2
                    end: Offset.zero, //1
                  ))
            .animate(a);
        final scaleAnimation = Tween<double>(
          begin: 0.6, //0.8
          end: 1, //1
        ).animate(a);
        return useSlideAnimation
            ? SlideTransition(
                position: slideAnimation,
                child: FadeTransition(
                  opacity: a,
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: c,
                  ),
                ),
              )
            : FadeTransition(
                opacity: a,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: c,
                ),
              );
      },
    );
  }
}

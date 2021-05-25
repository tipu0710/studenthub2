import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AnimState { init, loadingStart, loadingEnd }

enum _ChildAnim { mainChild, secondaryChild }

class LoadingButton extends StatelessWidget {
  final Widget mainChild, secondaryChild;
  final ValueNotifier<AnimState> valueNotifier;
  final int animTimeInMillisecond;
  final double? width;

  LoadingButton({
    required Key key,
    required this.mainChild,
    required this.secondaryChild,
    required this.valueNotifier,
    this.animTimeInMillisecond = 500,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AnimState>(
      valueListenable: valueNotifier,
      builder: (_, value, ___) {
        var _tween = MultiTween<_ChildAnim>()
          ..add(_ChildAnim.mainChild, width?.tweenTo(0.0) ?? 100.0.tweenTo(0.0),
              animTimeInMillisecond.milliseconds)
          ..add(_ChildAnim.secondaryChild, 0.0.tweenTo(1.0),
              (animTimeInMillisecond + 1000).milliseconds);


        switch (value) {
          case AnimState.loadingStart:
            return PlayAnimation<MultiTweenValues<_ChildAnim>>(
              key: UniqueKey(),
              duration: _tween.duration,
              builder: (context, child, value) {
                return Stack(
                  children: [
                    Center(
                      child: Opacity(
                          opacity: value.get(_ChildAnim.secondaryChild),
                          child: secondaryChild),
                    ),
                    Center(
                      child: Container(
                        width: value.get(_ChildAnim.mainChild),
                        child: mainChild,
                      ),
                    )
                  ],
                );
              },
              tween: _tween,
            );
          case AnimState.loadingEnd:
            return PlayAnimation(
                builder: (context, child, dynamic value) {
                  return Center(
                    child: Container(
                      child: mainChild,
                    ),
                  );
                },
                tween: 0.0.tweenTo(width ?? 100.0));
          default:
            return Center(
              child: mainChild,
            );
        }
      },
    );
  }
}

changeAnim(ValueNotifier<AnimState> valueNotifier) {
  switch (valueNotifier.value) {
    case AnimState.loadingStart:
      valueNotifier.value = AnimState.loadingEnd;
      break;
    case AnimState.loadingEnd:
      valueNotifier.value = AnimState.loadingStart;
      break;
    default:
      valueNotifier.value = AnimState.loadingStart;
      break;
  }
}
// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

// Internal Modules
import 'package:challenge_for_robinhood/base/base_extension.dart';
import 'package:challenge_for_robinhood/base/base_widget.dart';
import 'package:challenge_for_robinhood/navigator_route.dart';
import 'package:challenge_for_robinhood/src/features/lock_screen/viewmodel.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: BaseWidget<LockScreenViewmodel>(
          model: LockScreenViewmodel(context: context),
          builder: (_, model, __) {
            var padding = 24.0;
            var width = context.media.size.width - (padding * 4);
            var widthWithoutPadding = width / 3;
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      6,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          index >= model.passcodeLength ? FontAwesomeIcons.circle : FontAwesomeIcons.circleDot,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: padding),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Wrap(
                      runSpacing: padding,
                      spacing: padding,
                      children: List.generate(9, (index) {
                        String value = (index + 1).toString();
                        return _button(
                          context,
                          value: value,
                          model: model,
                          widthWithoutPadding: widthWithoutPadding,
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: padding),
                  _button(
                    context,
                    value: '0',
                    model: model,
                    widthWithoutPadding: widthWithoutPadding,
                  ),
                ],
              ),
              floatingActionButton: model.showRemoveButton
                  ? FloatingActionButton(
                      onPressed: () => model.removePasscode(),
                      child: const Icon(FontAwesomeIcons.deleteLeft),
                    )
                  : null,
            );
          },
        ),
      );

  Widget _button(
    BuildContext context, {
    required String value,
    required LockScreenViewmodel model,
    required double widthWithoutPadding,
  }) =>
      GestureDetector(
        onTap: () async {
          bool? match = await model.updatePasscode(value: value);
          if (match != null && context.mounted) {
            if (match) {
              model.updateLastUnlock();
              if (model.firstTime) {
                model.updateFirstTime();
                context.pushReplacement(NavigatorRoutePath.task.goPath);
              } else {
                context.pop();
              }
            } else {
              context.showToast(msg: 'auth.password_not_match'.tr());
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple, width: 2),
            borderRadius: const BorderRadius.all(
              Radius.circular(128),
            ),
          ),
          width: widthWithoutPadding,
          height: widthWithoutPadding,
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 64,
                color: Colors.purple,
              ),
            ),
          ),
        ),
      );
}

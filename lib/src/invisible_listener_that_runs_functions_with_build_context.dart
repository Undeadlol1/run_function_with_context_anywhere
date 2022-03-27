import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

import 'function_runner_change_notifier.dart';

class ListenerThatRunsFunctionsWithBuildContext extends StatefulWidget {
  const ListenerThatRunsFunctionsWithBuildContext({Key? key}) : super(key: key);

  @override
  State<ListenerThatRunsFunctionsWithBuildContext> createState() =>
      _ListenerThatRunsFunctionsWithBuildContextState();
}

class _ListenerThatRunsFunctionsWithBuildContextState
    extends State<ListenerThatRunsFunctionsWithBuildContext> {
  bool _wasListenerAddedToChangeNotifier = false;

  @override
  void dispose() {
    functionRunnerChangeNotifier.removeListener(_runFunctionsWhenAdded);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doesNotHaveExtraListeners =
        functionRunnerChangeNotifier.hasListeners != true;
    if (_wasListenerAddedToChangeNotifier == false &&
        doesNotHaveExtraListeners) {
      functionRunnerChangeNotifier.addListener(_runFunctionsWhenAdded);
      setState(() => _wasListenerAddedToChangeNotifier = true);
    }

    return AnimatedBuilder(
      animation: functionRunnerChangeNotifier,
      child: Visibility(
        visible: false,
        child: Container(),
      ),
      builder: (_, child) => child!,
    );
  }

  void _runFunctionsWhenAdded() {
    Future.microtask(() {
      if (functionRunnerChangeNotifier.functionToRun == null) {
        return;
      }

      functionRunnerChangeNotifier.functionToRun!(context);
    });
  }
}

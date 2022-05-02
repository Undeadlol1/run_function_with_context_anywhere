import 'package:flutter/widgets.dart';
import 'function_runner_change_notifier.dart';

class BuildContextProvider {
  static void provideBuildContext(
    void Function(BuildContext) functionToRun,
  ) {
    FunctionRunnerChangeNotifier().runFunction(functionToRun);
  }
}

const provideBuildContext = BuildContextProvider.provideBuildContext;

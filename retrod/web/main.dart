import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'retro.dart';

import 'dart:html';

// Everything in the 'todo' library should be preserved by MirrorsUsed.
@MirrorsUsed(
    targets: const ['retro'],
    override: '*')
import 'dart:mirrors';

main() {
  print(window.location.search);
  var module = new Module()
      ..type(RetroController);
}

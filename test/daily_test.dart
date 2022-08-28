
import 'package:redstonex/state-core/ctrls/models/ctrl_status.dart';

void main() {
  testFactoryKeyword();
}

void testFactoryKeyword() {
  CtrlStatus status = CtrlStatus.empty();
  print('${status.hashCode}');
  status = CtrlStatus.loading();
  print('${status.hashCode}');
  status = CtrlStatus.empty();
  print('${status.hashCode}');
  status = CtrlStatus.loading();
  print('${status.hashCode}');
}
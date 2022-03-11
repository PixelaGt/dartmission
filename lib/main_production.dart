import 'package:dartmission/bootstrap.dart';
import 'package:dartmission/dartmission_app.dart';
import 'package:dartmission/strategy/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  bootstrap(() => const DartmissionApp());
}

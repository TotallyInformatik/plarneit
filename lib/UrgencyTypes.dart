import 'dart:ui';
import 'utils/constants.dart';

enum UrgencyTypes {
  VERY_URGENT,
  URGENT,
  MODERATE,
  NOT_URGENT,
  NOT_URGENT_AT_ALL
}

const Map<UrgencyTypes, Color> URGENCY_TO_COLOR = {
  UrgencyTypes.VERY_URGENT: VERY_URGENT_COLOR,
  UrgencyTypes.URGENT: URGENT_COLOR,
  UrgencyTypes.MODERATE: MODERATE_COLOR,
  UrgencyTypes.NOT_URGENT: NOT_URGENT_COLOR,
  UrgencyTypes.NOT_URGENT_AT_ALL: NOT_URGENT_AT_ALL_COLOR,
};
import 'package:plarneit/utils/conversion.dart';

import 'DataClass.dart';

enum SynchronizationMode {
  MERGE,
  OVERWRITE
}

class CloudSettingsData extends DataClass {

  static final String autoSynchronizationTag = "auto-sync";
  static final String standardSynchronizationModeTag = "standard-sync-mode";

  static final Map standardMap = {
    CloudSettingsData.autoSynchronizationTag: false,
    CloudSettingsData.standardSynchronizationModeTag: Conversion.enumToString(SynchronizationMode.MERGE)
  };

  bool autoSynchronization;
  SynchronizationMode standardSynchronizationMode;

  CloudSettingsData(this.autoSynchronization, this.standardSynchronizationMode);

  @override
  Map toMap() {

    return {
      autoSynchronizationTag: this.autoSynchronization,
      standardSynchronizationModeTag: Conversion.enumToString(this.standardSynchronizationMode)
    };

  }

  static CloudSettingsData fromJsonData(Map information) {

    bool autoSynchronization = information[autoSynchronizationTag];
    SynchronizationMode synchronizationMode = Conversion.enumFromString(information[standardSynchronizationModeTag], SynchronizationMode.values);

    return CloudSettingsData(autoSynchronization, synchronizationMode);

  }

}


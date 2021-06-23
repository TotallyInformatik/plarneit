import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:plarneit/Data/SettingsData.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/main.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// SettingsPage
/// Not much to say here either...
///


class SettingsPage extends StatefulWidget {

  final Future<Map> settingsInformation;

  const SettingsPage(this.settingsInformation, {Key key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _SettingsPageState();


}

class _SettingsPageState extends State<SettingsPage> {

  static final _expansionTilePadding = EdgeInsets.symmetric(vertical: 20);

  final ScrollController scrollController = ScrollController();
  SettingsData _settingsData = SettingsData(3, true);


  ListTile listTile(String title, {String subtitle}) {
    return ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }

  void setSettings() async {
    Map information = await this.widget.settingsInformation;
    this.setState(() {
      this._settingsData = SettingsData.fromJsonData(information);
    });
  }

  void updateSettings() async {
    JsonHandlerWidget.of(context).settingsHandler.writeToJson(
      this._settingsData.toMap()
    );
  }

  @override
  void initState() {
    super.initState();
    this.setSettings();
  }


  String determineAutoDeletionDisplay(double autoDeletionPeriod) {
    int value = autoDeletionPeriod.round();
    return value < SettingsData.autoDeletionPeriodMaximumValue ? "$value days" : "never";
  }

  Widget appInformationSection() {

    const websiteUrl = "https://totallyinformatik.github.io/PlanifySite/";

    return ExpansionTile(
      initiallyExpanded: true,
      title: Text("App Information", style: Theme.of(context).primaryTextTheme.headline3),
      childrenPadding: _expansionTilePadding,
      children: [
        listTile("App Name: Plarneit", subtitle: "Mobile Version of Planify"),
        listTile("Version 1.0.0"),
        ListTile(
          title: Text("Website"),
          subtitle: Text(websiteUrl),
          onTap: () async {
            launch(websiteUrl);
          },
        ),
        listTile("Made by Rui Zhang in 2021", subtitle: "(TotallyInformatik)"),
        ExpansionTile(
          title: Text("Used Libraries", style: Theme.of(context).primaryTextTheme.headline4),
          childrenPadding: _expansionTilePadding,
          children: [
            listTile("cupertino_icons", subtitle: "1.0.2"),
            listTile("path_provider", subtitle: "2.0.1"),
            listTile("url_launcher", subtitle: "6.0.6"),
            listTile("open_file", subtitle: "3.2.1"),
            listTile("flutter_launcher_icons", subtitle: "0.9.0")
          ],
        )
      ],
    );
  }
  Widget appSettingsSection(String autoDeletionDisplay, double autoDeletionPeriod) {
    return ExpansionTile(
        initiallyExpanded: true,
        title: Text("Settings", style: Theme.of(context).primaryTextTheme.headline3),
        childrenPadding: _expansionTilePadding,
        children: [
          ExpansionTile(
            title: Text("Auto Deletion Period: $autoDeletionDisplay", style: Theme.of(context).primaryTextTheme.headline4),
            children: [
              listTile("All widgets that are assigned to a date earlier than the deletion period will be deleted automatically when staring the app"),
              SliderTheme(
                  data: SliderThemeData(
                      thumbColor: PlarneitApp.DARK_GRAY,
                      activeTrackColor: PlarneitApp.DARK_GRAY.withOpacity(0.7),
                      inactiveTrackColor: PlarneitApp.DARK_GRAY.withOpacity(0.3),
                      activeTickMarkColor: PlarneitApp.COLOR_WHITE,
                      inactiveTickMarkColor: PlarneitApp.DARK_GRAY.withOpacity(0.2)
                  ),
                  child: Slider(
                      min: 1,
                      max: 7,
                      value: autoDeletionPeriod,
                      onChanged: (double value) {
                        setState(() {
                          this._settingsData.autoDeletionPeriod = value.roundToDouble();
                          this.updateSettings();
                        });
                      },
                      divisions: 5,
                      label: autoDeletionDisplay
                  )
              )
            ],
          ),
          ExpansionTile(
            title: Text("Deletion Notification", style: Theme.of(context).primaryTextTheme.headline4),
            children: [
              listTile("", subtitle: "determines whether a  confirmation notification will popup when deleting widgets."),
              ListTile(
                  title: Text("activate notifications"),
                  leading: Radio(
                    value: true,
                    groupValue: this._settingsData.deletionPopup,
                    onChanged: (bool value) {
                      this.setState(() {
                        this._settingsData.deletionPopup = value;
                        this.updateSettings();
                      });
                    },
                  )
              ),
              ListTile(
                  title: Text("deactivate notifications"),
                  leading: Radio(
                    value: false,
                    groupValue: this._settingsData.deletionPopup,
                    onChanged: (bool value) {
                      this.setState(() {
                        this._settingsData.deletionPopup = value;
                        this.updateSettings();
                      });
                    },
                  )
              )
            ],
          )
        ]
    );
  }

  ListTile fileListTile(JsonHandler handler) {
    return ListTile(
        title: Text(handler.fileName),
        onTap: () async {
          OpenFile.open("${await handler.localPath}/${handler.fileName}");
        }
    );
  }
  Widget appFileOpeningSection(JsonHandlerCollection jsonhandlers) {
    return ExpansionTile(
      title: Text("Files", style: Theme.of(context).primaryTextTheme.headline3),
      subtitle: Text("DO NOT TOUCH THIS SECTION IF YOU DON'T KNOW WHAT YOU ARE DOING!!!"),
      children: [
        fileListTile(jsonhandlers.taskHandler),
        fileListTile(jsonhandlers.noteHandler),
        fileListTile(jsonhandlers.longtermGoalsHandler),
      ]
    );
  }


  @override
  Widget build(BuildContext context) {

    double autoDeletionPeriod = this._settingsData.autoDeletionPeriod != null ? this._settingsData.autoDeletionPeriod : 3.0;
    String autoDeletionDisplay = this.determineAutoDeletionDisplay(autoDeletionPeriod);

    return Scaffold(
      appBar: AppBar(
          title: Text("Settings", style: Theme.of(context).primaryTextTheme.headline1)
      ),
      body: Scrollbar(
        controller: scrollController,
        child: ListView(
          controller: scrollController,
            children: [Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appInformationSection(),
                    appSettingsSection(autoDeletionDisplay, autoDeletionPeriod),
                    appFileOpeningSection(JsonHandlerWidget.of(context))
                  ],
                )
            )]
        )
      )
    );

  }

}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:open_file/open_file.dart';
import 'package:plarneit/Data/SettingsData.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/ColorPicker.dart';
import 'package:plarneit/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaml/yaml.dart';
import 'package:plarneit/UserInput/Dialogs.dart';

///
/// @author: Rui Zhang (TotallyInformatik)
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
  SettingsData _settingsData = SettingsData.fromJsonData(SettingsData.standardMap);


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

  Future<Widget> appInformationSection() async {

    const String websiteUrl = "https://totallyinformatik.github.io/PlanifySite/";

    return FutureBuilder(
      future: rootBundle.loadString("pubspec.yaml"),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        if (snapshot.hasData) {
          var yaml = loadYaml(snapshot.data);

          Map dependencies = yaml["dependencies"];
          List<ListTile> dependencyTiles = [];
          for (MapEntry dependency in dependencies.entries) {
            try {
              dependencyTiles.add(listTile(dependency.key, subtitle: dependency.value));
            } catch (Exception) {}
          }

          return ExpansionTile(
            title: Text("App Information", style: Theme.of(context).primaryTextTheme.headline3),
            childrenPadding: _expansionTilePadding,
            children: [
              listTile("App Name: ${yaml["name"]}", subtitle: "Mobile Version of Planify"),
              listTile("Version ${yaml["version"]}"),
              ListTile(
                title: Text("Website"),
                subtitle: Text(websiteUrl),
                onTap: () async {
                  launch(websiteUrl);
                },
              ),
              listTile("Made by ${yaml["authors"][0]} in 2021", subtitle: "(TotallyInformatik)"),
              ExpansionTile(
                  title: Text("Development Packages", style: Theme.of(context).primaryTextTheme.headline4),
                  childrenPadding: _expansionTilePadding,
                  children: dependencyTiles
              ),
              /*
              ExpansionTile(
                  title: Text("Dev Dependencies", style: Theme.of(context).primaryTextTheme.headline4),
                  childrenPadding: _expansionTilePadding,
                  children: devdependencyTiles
              ),
              */
              ListTile(
                title: Text("Dependencies and Licenses", style: Theme.of(context).primaryTextTheme.headline4),
                onTap: () {
                  showLicensePage(context: context);
                }
              )
            ],
          );

        }
        return ExpansionTile(
          initiallyExpanded: true,
          title: Text("App Information", style: Theme.of(context).primaryTextTheme.headline3)
        );


      },
    );
  }

  ExpansionTile autoDeletionPeriodSection() {

    double autoDeletionPeriod = this._settingsData.autoDeletionPeriod;
    String autoDeletionDisplay = this.determineAutoDeletionDisplay(autoDeletionPeriod);

    return ExpansionTile(
      initiallyExpanded: true,
      title: Text("Auto Deletion Period: $autoDeletionDisplay", style: Theme.of(context).primaryTextTheme.headline4),
      children: [
        listTile("", subtitle: "All widgets that are assigned to a date earlier than the deletion period will be deleted automatically when staring the app"),
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
    );
  }

  ExpansionTile deletionNotificationSection() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text("Deletion Notification", style: Theme.of(context).primaryTextTheme.headline4),
      children: [
        listTile("", subtitle: "determines whether a confirmation notification will popup when deleting widgets."),
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
    );
  }

  ExpansionTile noteColorSelectionSection() {

    double noteColorWidgetHeight = 60;

    return ExpansionTile(
      initiallyExpanded: true,
      title: Text("Note Colors", style: Theme.of(context).primaryTextTheme.headline4),
      children: [
        listTile("", subtitle: "Choose up to 4 colors that you can choose when creating notes. The first color represents the standard note color that is chosen."),
        Container(
            constraints: BoxConstraints.expand(
              width: MediaQuery.of(context).size.width,
              height: noteColorWidgetHeight,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView.builder(
              itemCount: this._settingsData.noteColors.length,
              itemBuilder: (BuildContext context, int index) {
                Color color = this._settingsData.noteColors[index];
                return ColorWidget(noteColorWidgetHeight, color, () {
                  CustomDialogs.showCustomDialog(
                      context,
                      "Change color",
                      [
                        SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: color,
                              onColorChanged: (Color newColor) {
                                this.setState(() {
                                  this._settingsData.noteColors[index] = newColor;
                                  this.updateSettings();
                                });
                              },
                              showLabel: true,
                              pickerAreaHeightPercent: 0.8,
                            )
                        )
                      ],
                      [
                        IconButton(
                          icon: Icon(Icons.done_rounded),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]
                  );
                });
              },
              scrollDirection: Axis.horizontal,

            )
        )
      ]
    );
  }


  Widget appSettingsSection() {
    return ExpansionTile(
        initiallyExpanded: true,
        title: Text("Preferences", style: Theme.of(context).primaryTextTheme.headline3),
        childrenPadding: _expansionTilePadding,
        children: [
          autoDeletionPeriodSection(),
          deletionNotificationSection(),
          noteColorSelectionSection()
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

    return Scaffold(
      appBar: AppBar(
          title: Text("Settings", style: Theme.of(context).primaryTextTheme.headline1)
      ),
      body: Scrollbar(
          controller: scrollController,
          child: ListView(
              controller: scrollController,
              children: [Container(
                  child: FutureBuilder(
                    future: appInformationSection(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                      if (snapshot.hasData) {
                        Widget appInformationSection = snapshot.data;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appSettingsSection(),
                            appInformationSection,
                            appFileOpeningSection(JsonHandlerWidget.of(context)),
                          ],
                        );
                      }
                      return Column();
                    }
                  )
              )]
          )
      )
    );

  }

}
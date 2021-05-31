import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/conversion.dart';
import '../Dialogs.dart';
import '../utils/constants.dart';

class NoteWidget extends UserMadeWidgetBase {

  const NoteWidget(WidgetInformation widgetInformation, WidgetContainerStatusController statusController, int id, Function widgetDeletionFunction, {Key key})
      : super(widgetInformation, statusController, id, widgetDeletionFunction, key: key);

  @override
  State<StatefulWidget> createState() =>
      _NoteWidgetState();

}

class _NoteWidgetState extends UserMadeWidgetBaseState<NotesInformation> {

  String _title;
  String _description;
  Color _color;

  void updateAttributes(NotesInformation widgetInformation) {
    this.setState(() {
      this._title = widgetInformation.title;
      this._description = widgetInformation.description;
      this._color = widgetInformation.color;
    });
  }

  @override
  void initState() {
    super.initState();
    this.updateAttributes(this.widget.widgetInformation);
  }

  @override
  Widget build(BuildContext context) {

    return this.returnStandardBuild(context, [
          Text(this._title, style: Theme.of(context).accentTextTheme.headline5),
          Text(this._description, style: Theme.of(context).accentTextTheme.bodyText1)
        ], () async {
            NotesInformation newWidgetInformation = await showNoteEditDialog(context, title: this._title, description: this._description, color: this._color);
            if (newWidgetInformation != null) {
              this.updateAttributes(newWidgetInformation);
            }
          },
        noteColor: this._color
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/conversion.dart';
import '../Dialogs.dart';
import '../utils/constants.dart';

class NoteWidget extends UserMadeWidgetBase {

  const NoteWidget(WidgetInformation widgetInformation, EditingController eController, int id, {Key key})
      : super(widgetInformation, eController, id, key: key);

  @override
  State<StatefulWidget> createState() =>
      _NoteWidgetState();

}

class _NoteWidgetState extends State<NoteWidget> {

  String _title;
  String _description;
  Color _color;
  bool _animationStarted = false;

  void _updateAttributes(NotesInformation widgetInformation) {
    this.setState(() {
      this._title = widgetInformation.title;
      this._description = widgetInformation.description;
      this._color = widgetInformation.color;
    });
  }

  @override
  void initState() {
    super.initState();
    this._updateAttributes(this.widget.widgetInformation);
    this.initAnimation();
  }

  void initAnimation() async {
    await Future.delayed(Duration(milliseconds: 100));
    this.setState(() {
      this._animationStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedOpacity(
        duration: Duration(milliseconds: 1000),
        opacity: !_animationStarted ? 0 : 1,
        child: this.widget.returnStandardBuild(context, [
          Text(this._title, style: Theme.of(context).accentTextTheme.headline5),
          Text(this._description, style: Theme.of(context).accentTextTheme.bodyText1)
        ], () async {
          if (this.widget.eController.value) {

            NotesInformation newWidgetInformation = await showNoteEditDialog(context, title: this._title, description: this._description, color: this._color);
            if (newWidgetInformation != null) {
              this._updateAttributes(newWidgetInformation);
            }
          }

        },
        noteColor: this._color)
    );
  }

}
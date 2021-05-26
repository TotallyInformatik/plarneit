class EditingController {

  bool _isEditing = false;
  get isEditing { return this._isEditing; }
  reverseIsEditing() { this._isEditing = !this._isEditing; }

}
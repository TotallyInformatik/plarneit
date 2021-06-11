class LongtermNotesIdManager {

  int _nextId;
  int get nextId { return _nextId; }

  void incrementId() { this._nextId++; }

  LongtermNotesIdManager({int initialId=1}) {
    this._nextId = initialId;
  }

}
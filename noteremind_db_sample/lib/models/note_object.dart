class Notes {
  int _id;
  String _title;
  String _des;
  String _date;
  int _priority;

  Notes(this._title, this._date, this._priority, [this._des]);
  Notes.withID(this._id, this._title, this._date, this._priority, [this._des]);

  int get id => _id;
  String get title => _title;
  String get des => _des;
  String get date => _date;
  int get priority => _priority;

  set title(String newValue) {
    if (newValue.length <= 255) {
      this._title = newValue;
    }
  }

  set des(String newValue) {
    if (newValue.length <= 255) {
      this._des = newValue;
    }
  }

  set date(String newValue) {
    if (newValue.length <= 255) {
      this._date = newValue;
    }
  }

  set priority(int newValue) {
    if (newValue <= 2 && newValue >= 1) {
      this._priority = newValue;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (_id != null) {
      map['id'] = _id;
    }

    map['title'] = _title;
    map['des'] = _des;
    map['date'] = _date;
    map['priority'] = _priority;

    return map;
  }

  Notes.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._date = map['date'];
    this._des = map['des'];
    this._priority = int.tryParse(map['priority']);
  }
}

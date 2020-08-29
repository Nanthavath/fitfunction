class WorkoutItem{
  String _days;

  String get days => _days;

  set days(String value) {
    _days = value;
  }

  List _selectedExercises;

  List get selectedExercises => _selectedExercises;

  set selectedExercises(List<Object> value) {
    _selectedExercises = value;
  }

  WorkoutItem(this._days, this._selectedExercises);
}
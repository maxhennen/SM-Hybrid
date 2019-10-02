class Event {
  double distanceFromUserInMeters;
  String name;
  String id;
  bool withinRange;

  Event(double distance, String eventName, String eventId) {
    this.distanceFromUserInMeters = distance;
    this.name = eventName;
    this.id = eventId;
    if (this.distanceFromUserInMeters > 500) {
      this.withinRange = false;
    } else {
      this.withinRange = true;
    }
  }

  Event.empty();
}

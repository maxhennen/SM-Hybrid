class Event{
  double distanceFromUserInMeters;
  String eventName;
  bool withinRange;

  Event(this.distanceFromUserInMeters, this.eventName, this.withinRange);

  @override
  onCreate(){
    if(this.distanceFromUserInMeters > 500){
      this.withinRange = false;
    }else{
      this.withinRange = true;
    }
  }
}
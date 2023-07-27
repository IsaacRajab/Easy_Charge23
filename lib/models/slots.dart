class Slots {
  late String? slotsId, stationId, voltage, price, status, date;
  late String? timeIn, timeOut, typeOfCharger;

  Slots({
    this.slotsId,
    this.stationId,
    this.voltage,
    this.price,
    this.status,
    this.date,
    this.timeIn,
    this.timeOut,
    this.typeOfCharger,
  });

  factory Slots.fromJson(Map<String, dynamic> json) {
    return Slots(
      slotsId: json["slotId"],
      stationId: json["stationId"],
      voltage: json["voltage"],
      price: json["price"],
      status: json["status"],
      date: json["Date"],
      timeIn: json["TimeIn"],
      timeOut: json["TimeOut"],
      typeOfCharger: json["typeOfCharger"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (slotsId != null) {
      data["Slotid"] = slotsId;
    }
    if (stationId != null) {
      data["Stationid"] = stationId;
    }
    if (voltage != null) {
      data["Voltage"] = voltage;
    }
    if (price != null) {
      data["Price"] = price;
    }
    if (status != null) {
      data["Status"] = status;
    }
    if (date != null) {
      data["Date"] = date;
    }
    if (timeIn != null) {
      data["TimeIn"] = timeIn;
    }
    if (timeOut != null) {
      data["TimeOut"] = timeOut;
    }
    if (typeOfCharger != null) {
      data["TypeOfCharger"] = typeOfCharger;
    }
    return data;
  }
}

class AdminBookings {
  late String? bookingId, stationId, slotId, userId, vehicleId;
  late String? bookingStatus, bookingDate, timeIn, timeOut;
  late String? amount, dateTime, stationName, userName;
  late String? vehicleName, vehicleNumber;
  late String? stationRevenue;
  late String? fromDate, toDate;

  AdminBookings({
    this.bookingId,
    this.stationId,
    this.slotId,
    this.userId,
    this.vehicleId,
    this.bookingStatus,
    this.bookingDate,
    this.timeIn,
    this.timeOut,
    this.amount,
    this.dateTime,
    this.stationName,
    this.userName,
    this.vehicleName,
    this.vehicleNumber,
    this.stationRevenue,
    this.fromDate,
    this.toDate,
  });

  factory AdminBookings.fromJson(Map<String, dynamic> json) {
    return AdminBookings(
      bookingId: json["bookingId"],
      stationId: json["stationId"],
      slotId: json["slotId"],
      userId: json["userId"],
      vehicleId: json["vehicleId"],
      bookingStatus: json["bookingStatus"],
      bookingDate: json["bookingDate"],
      timeIn: json["timeIn"],
      timeOut: json["timeOut"],
      amount: json["Amount"],
      dateTime: json["dateTime"],
      stationName: json["stationName"],
      userName: json["userName"],
      vehicleName: json["vehicleName"],
      vehicleNumber: json["vehicleNumber"],
      stationRevenue: json["stationRevenue"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookingId != null) {
      data["Bookingid"] = bookingId;
    }
    if (stationId != null) {
      data["stationId"] = stationId;
    }
    if (slotId != null) {
      data["slotId"] = slotId;
    }
    if (userId != null) {
      data["userId"] = userId;
    }
    if (vehicleId != null) {
      data["vehicleId"] = vehicleId;
    }
    if (bookingStatus != null) {
      data["bookingStatus"] = bookingStatus;
    }
    if (bookingDate != null) {
      data["Date"] = bookingDate;
    }
    if (timeIn != null) {
      data["timeIn"] = timeIn;
    }
    if (timeOut != null) {
      data["timeOut"] = timeOut;
    }
    if (amount != null) {
      data["amount"] = amount;
    }
    if (dateTime != null) {
      data["dateTime"] = dateTime;
    }
    if (stationName != null) {
      data["stationName"] = stationName;
    }
    if (userName != null) {
      data["userName"] = userName;
    }
    if (vehicleName != null) {
      data["vehicleName"] = vehicleName;
    }
    if (vehicleNumber != null) {
      data["vehicleNumber"] = vehicleNumber;
    }
    if (fromDate != null) {
      data["FromDate"] = fromDate;
    }
    if (toDate != null) {
      data["ToDate"] = toDate;
    }
    return data;
  }
}

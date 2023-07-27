class ApiConstants {
  static const String _baseUrlUser = "http://aevstations.hostoise.com/api/User";
  static const String _baseUrlAdmin = "http://aevstations.hostoise.com/api/Admin";

  static const String post = "Post";

  static const String userLogin = "$_baseUrlUser/Login";
  static const String userRegistration = "$_baseUrlUser/Register";
  static const String viewUserProfile = "$_baseUrlUser/ViewProfile";
  static const String updateUserProfile = "$_baseUrlUser/UpdateProfile";
  static const String changePassword = "$_baseUrlUser/ChangePassword";
  static const String viewEVVehicles = "$_baseUrlUser/ViewVehicle";
  static const String addEVVehicles = "$_baseUrlUser/AddVehicle";
  static const String updateEVVehicles = "$_baseUrlUser/UpdateVehicle";
  static const String deleteEVVehicles = "$_baseUrlUser/DeleteVehicle";
  static const String viewStationUser = "$_baseUrlUser/ViewStation";
  static const String viewSlotUser = "$_baseUrlUser/ViewSlotsNew";
  static const String bookSlot = "$_baseUrlUser/BookSlot";
  static const String viewBookingsUser = "$_baseUrlUser/ViewBookings";
  static const String cancelBookings = "$_baseUrlUser/CancelBooking";
  static const String roadMap = "$_baseUrlUser/getRoadmap";

  static const String adminLogin = "$_baseUrlAdmin/Login";
  static const String viewStationAdmin = "$_baseUrlAdmin/ViewStation";
  static const String addStation = "$_baseUrlAdmin/AddStation";
  static const String updateStation = "$_baseUrlAdmin/UpdateStation";
  static const String viewSlotAdmin = "$_baseUrlAdmin/ViewSlots";
  static const String addSlot = "$_baseUrlAdmin/AddSlot";
  static const String updateSlot = "$_baseUrlAdmin/UpdateSlot";
  static const String viewBookingsAdmin = "$_baseUrlAdmin/ViewBookingsNew";
  static const String cancelBooking = "$_baseUrlAdmin/CancelBooking";
  static const String viewAllUser = "$_baseUrlAdmin/ViewUsers";
}

import 'package:get/get.dart';

import '../../screens/bookings/admin/admin_view_booking_details_screen.dart';
import '../../screens/bookings/admin/admin_view_bookings_screen.dart';
import '../../screens/bookings/admin/view_all_users_screen.dart';
import '../../screens/bookings/user/google_map_view_road_map.dart';
import '../../screens/bookings/user/view_booking_details_screen.dart';
import '../../screens/bookings/user/view_bookings_screen.dart';
import '../../screens/ev_vehicles/add_update_ev_vehicles_screen.dart';
import '../../screens/ev_vehicles/manage_ev_vehicles_screen.dart';
import '../../screens/general/dashboard_screen.dart';
import '../../screens/general/profile_screen.dart';
import '../../screens/general/splash_screen.dart';
import '../../screens/general/user_type_selection_screen.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/login/registration_screen.dart';
import '../../screens/manage_stations/add_update_slot_screen.dart';
import '../../screens/manage_stations/add_update_station_screen.dart';
import '../../screens/manage_stations/admin_manage_slots_screen.dart';
import '../../screens/manage_stations/google_map_view_screen.dart';
import '../../screens/manage_stations/manage_stations_screen.dart';
import '../../screens/user_find_stations/find_stations_screen.dart';
import '../../screens/user_find_stations/manage_slots_screen.dart';
import '../../screens/user_find_stations/payment_page_screen.dart';
import '../../screens/user_find_stations/payment_success_screen.dart';
import '../constants/route_constants.dart';

class RouteScreen {
  static final routes = [
    GetPage(
      name: RouteConstants.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteConstants.userTypeScreen,
      page: () => UserTypeSelectionScreen(),
    ),
    GetPage(
      name: RouteConstants.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: RouteConstants.registrationScreen,
      page: () => RegistrationScreen(),
    ),
    GetPage(
      name: RouteConstants.profileScreen,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: RouteConstants.dashboardScreen,
      page: () => DashBoardScreen(),
    ),
    GetPage(
      name: RouteConstants.manageEVVehicles,
      page: () => ManageEVVehicles(),
    ),
    GetPage(
      name: RouteConstants.addUpdateEVVehicles,
      page: () => AddUpdateEVVehicles(),
    ),
    GetPage(
      name: RouteConstants.findStations,
      page: () => FindStationsScreen(),
    ),
    GetPage(
      name: RouteConstants.manageStationsScreen,
      page: () => ManageStationsScreen(),
    ),
    GetPage(
      name: RouteConstants.addUpdateStationScreen,
      page: () => AddUpdateStationScreen(),
    ),
    GetPage(
      name: RouteConstants.manageSlotsAdmin,
      page: () => AdminManageSlotsScreen(),
    ),
    GetPage(
      name: RouteConstants.manageSlots,
      page: () => ManageSlotsScreen(),
    ),
    GetPage(
      name: RouteConstants.addUpdateSlotsScreen,
      page: () => AddUpdateSlotsScreen(),
    ),
    GetPage(
      name: RouteConstants.viewBookingsAdmin,
      page: () => AdminViewBookingsScreen(),
    ),
    GetPage(
      name: RouteConstants.viewBookings,
      page: () => ViewBookingsScreen(),
    ),
    GetPage(
      name: RouteConstants.viewBookingDetailsAdmin,
      page: () => AdminViewBookingDetails(),
    ),
    GetPage(
      name: RouteConstants.viewBookingDetails,
      page: () => ViewBookingDetailsScreen(),
    ),
    GetPage(
      name: RouteConstants.viewAllUserScreen,
      page: () => ViewAllUsers(),
    ),
    GetPage(
      name: RouteConstants.googleMapViewScreen,
      page: () => GoogleMapViewScreen(),
    ),
    GetPage(
      name: RouteConstants.googleMapViewRoadMap,
      page: () => GoogleMapViewGoogleMap(),
    ),
    GetPage(
      name: RouteConstants.paymentPageScreen,
      page: () => PaymentPageScreen(),
    ),
    GetPage(
      name: RouteConstants.paymentSuccessPageScreen,
      page: () => const PaymentSuccessPageScreen(),
    ),
  ];
}

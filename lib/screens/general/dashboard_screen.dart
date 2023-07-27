import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';
import '../../utils/constants/dimens_constants.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/custom_widgets/common_scaffold.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key}) : super(key: key);

  final DashboardController _controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return CommonScaffold(
          appBar: AppBar(
            title: const Text("DASHBOARD"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => _controller.onPressLogout(),
                icon: const Icon(Icons.logout_outlined),
              )
            ],
          ),
          body: _controller.userType.value == StringConstants.USER
              ? _userCards()
              : _controller.userType.value == StringConstants.ADMIN
                  ? _adminCard()
                  : Container(),
        );
      },
    );
  }

  Widget _adminCard() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(DimenConstants.contentPadding),
        padding: const EdgeInsets.all(DimenConstants.contentPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: _cardView(
                stringText: "Manage Station",
                stringImagePath: StringConstants.manageStations,
                onTap: () => _controller.onTapManageStation(),
              ),
            ),
            Expanded(
              flex: 1,
              child: _cardView(
                stringText: "View Booking",
                stringImagePath: StringConstants.bookings,
                onTap: () => _controller.onTapViewBooking(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userCards() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(DimenConstants.contentPadding),
          padding: const EdgeInsets.all(DimenConstants.contentPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(DimenConstants.contentPadding),
                children: <Widget>[
                  _cardView(
                    stringText: "Manage EV Vehicles",
                    stringImagePath: StringConstants.manage,
                    onTap: () => _controller.onTapManageEVVehicles(),
                  ),
                  _cardView(
                    stringText: "Find Stations",
                    stringImagePath: StringConstants.findStation,
                    onTap: () => _controller.onTapFindStations(),
                  ),
                  _cardView(
                    stringText: "View Bookings",
                    stringImagePath: StringConstants.bookings,
                    onTap: () => _controller.onTapViewBooking(),
                  ),
                  _cardView(
                    stringText: "Profile",
                    stringImagePath: StringConstants.profile,
                    onTap: () => _controller.onTapProfile(),
                  ),

                ],
              ),
              _cardView(
                stringText: "Station Roadmap",
                stringImagePath: StringConstants.roadMap,
                onTap: () => _controller.onPressViewRoadMap(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardView({stringText, stringImagePath, onTap, bool? isLastOdd}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:  Get.width,
        height: Get.height / 4,
        margin: const EdgeInsets.all(DimenConstants.contentPadding),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(DimenConstants.buttonCornerRadius),
          ),
          elevation: DimenConstants.cardElevation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(DimenConstants.contentPadding),
                child: Image.asset(
                  stringImagePath,
                  fit: BoxFit.contain,
                  width: Get.width * 0.15,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(DimenConstants.contentPadding),
                child: Text(
                  stringText.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.035,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/admin_view_booking_controller.dart';
import '../../../models/stations.dart';
import '../../../models/admin_bookings.dart';
import '../../../utils/constants/dimens_constants.dart';
import '../../../utils/custom_widgets/card_rich_text.dart';
import '../../../utils/custom_widgets/common_data_holder.dart';
import '../../../utils/custom_widgets/common_scaffold.dart';
import '../../../utils/custom_widgets/custom_object_drop_down.dart';
import '../../../utils/custom_widgets/custom_text_field.dart';

class AdminViewBookingsScreen extends StatelessWidget {
  AdminViewBookingsScreen({Key? key}) : super(key: key);

  final AdminViewBookingController _controller =
      Get.put(AdminViewBookingController());

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: AppBar(
        title: const Text("Bookings"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _controller.viewAllUsers(),
        backgroundColor: Theme.of(context).primaryColor,
        label: const Text("View All Users"),
        icon: const Icon(Icons.supervised_user_circle_outlined),
        foregroundColor: Colors.white,
      ),
      body: Obx(() => Center(child: _body())),
    );
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _filterWidget(),
        CardRichText(
          boldText: "Total Revenue : ",
          normalText: _controller.totalRevenue.value.toString(),
        ),
        Expanded(
          child: CommonDataHolder(
            controller: _controller,
            widget: _dataHolderWidget,
            dataList: _controller.dataList,
            isRefreshEnabled: true,
            onRefresh: () async {
              _controller.fetchAdminBookingsByParams();
            },
          ),
        ),
      ],
    );
  }

  Widget _dataHolderWidget(List<AdminBookings>? bookingList) {
    try {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: bookingList?.length ?? 0,
        itemBuilder: (context, index) {
          return _bookingCards(bookingList![index]);
        },
      );
    } catch (e) {
      return const CustomNoResultScreen();
    }
  }

  Widget _bookingCards(AdminBookings booking) {
    return InkWell(
      onTap: () {
        _controller.onTapBookingCard(booking: booking); //addUpdateStation
      },
      child: Container(
        margin: const EdgeInsets.all(DimenConstants.contentPadding),
        child: Card(
          elevation: DimenConstants.cardElevation,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(DimenConstants.buttonCornerRadius),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(DimenConstants.contentPadding),
                padding: const EdgeInsets.all(DimenConstants.contentPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Icon(Icons.list_alt_outlined),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(height: DimenConstants.contentPadding),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CardRichText(
                            boldText: "Date : ",
                            normalText: booking.bookingDate ?? "",
                          ),
                          const SizedBox(height: DimenConstants.contentPadding),
                          CardRichText(
                            boldText: "Name : ",
                            normalText: booking.userName ?? "",
                          ),
                          const SizedBox(height: DimenConstants.contentPadding),
                          CardRichText(
                            boldText: "Station : ",
                            normalText: booking.stationName ?? "",
                          ),
                          const SizedBox(height: DimenConstants.contentPadding),
                          Visibility(
                            visible: _controller.selectedStation.value ==
                                    null ||
                                _controller.selectedStation.value?.stationId ==
                                    "all",
                            child: CardRichText(
                              boldText: "Total Station Revenue : ",
                              normalText: booking.stationRevenue ?? "",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterWidget() {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(DimenConstants.contentPadding),
      child: Card(
        elevation: DimenConstants.cardElevation,
        child: Padding(
          padding: const EdgeInsets.all(DimenConstants.contentPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "From Date",
                      readOnly: true,
                      textEditingController: _controller.etFromDate,
                      onTapField: () => _controller.onTapFromDateField(),
                      validatorFunction: (p0) {
                        return _controller.validateFromDateField(p0);
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      hintText: "To Date",
                      readOnly: true,
                      textEditingController: _controller.etToDate,
                      onTapField: () => _controller.onTapToDateField(),
                      validatorFunction: (p0) {
                        return _controller.validateToDateField(p0);
                      },
                    ),
                  ),
                ],
              ),
              CustomObjectDropDown<Stations>(
                displayList: _controller.stationList,
                selected: _controller.selectedStation,
                hintText: 'Select Station',
                prefixIcon: Icons.ev_station_outlined,
                onValueChanged: (p0) => _controller.onChanged(stations: p0),
                displayTextFunction: (p0) {
                  if (p0.stationId != "all") {
                    return "${p0.stationName ?? "Unknown"} - ${p0.location ?? ""}";
                  } else {
                    return p0.stationName ?? "Unknown";
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salama_users/app/utils/logger.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/formatter/functions.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/presentation/widgets/busy_button.dart';

import '../../../core/formatter/formatter.dart';
import '../../../domain/entities/subscriptions/booking.dart';
import '../../widgets/network_image.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';

class ABookingDetails extends StatefulWidget {
  final ABookingDetailScreenParams params;
  const ABookingDetails({super.key, required this.params});

  @override
  State<ABookingDetails> createState() => _ABookingDetailsState();
}

class _ABookingDetailsState extends State<ABookingDetails> {
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    context.subsription.fetchSingleBooking(bookingId: widget.params.booking.id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstLoad) {
      _isFirstLoad = false;
      context.subsription
          .fetchSingleBooking(bookingId: widget.params.booking.id);
    }
    // if (mounted) {
    //   setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    final item = context.subsription.booking.value;
    logger.d(item?.rideStatus);
    logger.w(widget.params.booking.rideStatus);
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: const Text(
            'Trip Details',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: StreamBuilder<List<Booking>?>(
            stream: context.subsription.userBookings.stream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                var booking = widget.params.booking;
                if (mounted) {
                  setState(() {
                    booking = item ?? widget.params.booking;
                  });
                }

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      Text(
                        booking.rideStatus,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                      const Gap(5),
                      Text(
                        '${Functions.getFormattedDate(DateTime.parse(booking.createdAt))}',
                        style: TextStyle(fontSize: 14),
                      ),
                      const Gap(20),
                      Container(
                        height: 152,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/maps.png",
                                ),
                                fit: BoxFit.cover)),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.primaryColor.withOpacity(0.3)),
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.primaryBlue),
                            ),
                          ),
                        ),
                      ),
                      const Gap(20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppNetworkImage(
                              url:
                                  'https://res.cloudinary.com/duwmvd0zh/image/upload/v1715517981/30_kt4jfx.png',
                              height: 40,
                              width: 40),
                          const Gap(12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item?.user['name']}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              const Gap(5),
                              Text(
                                'Customer',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey),
                              ),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              await EasyLauncher.call(
                                  number: "${item?.user['phone']}");
                            },
                            child: Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                      const Gap(20),
                      containerRow('Id', booking.id),
                      containerRow(
                        'Amount',
                        "₦ ${Formatter.money(
                          double.tryParse(booking.amount.toString()) ?? 0,
                        )}",
                      ),
                      containerRow('From', booking.riderFromAddress),
                      containerRow('To', booking.riderToAddress),
                      booking.startTime == null
                          ? Container()
                          : containerRow(
                              'Ride Start', booking.startTime.toString()),
                      booking.endTime == null
                          ? Container()
                          : containerRow('Ride', booking.endTime.toString()),
                    ],
                  ),
                );
              }
            }),
        bottomNavigationBar: widget.params.booking.rideStatus == "BOOKING"
            ? Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BusyButton(
                          title: 'Accept Trip',
                          onTap: () {
                            context.subsription
                                .acceptRide(bookingId: widget.params.booking.id)
                                .then((_) {});
                          }),
                      const Gap(6),
                      BusyButton(
                          color: AppColors.primaryGrey.withOpacity(0.5),
                          textColor: AppColors.dark,
                          title: 'Decline',
                          onTap: () {
                            context.subsription
                                .cancelbooking(
                                    bookingId: widget.params.booking.id)
                                .then((_) {});
                          }),
                    ],
                  ),
                ),
              )
            : widget.params.booking.rideStatus == "BOOKING"
                ? Container(
                    color: AppColors.white,
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    child: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BusyButton(
                              title: 'Accept Trip',
                              onTap: () {
                                context.subsription
                                    .acceptRide(
                                        bookingId: widget.params.booking.id)
                                    .then((_) {});
                              }),
                          const Gap(6),
                          BusyButton(
                              color: AppColors.primaryGrey.withOpacity(0.5),
                              textColor: AppColors.dark,
                              title: 'Decline',
                              onTap: () {
                                context.subsription
                                    .cancelbooking(
                                        bookingId: widget.params.booking.id)
                                    .then((_) {});
                              }),
                        ],
                      ),
                    ),
                  )
                : widget.params.booking.rideStatus == "DRIVER_ACCEPTED"
                    ? Container(
                        color: AppColors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                        child: SafeArea(
                          child: BusyButton(
                              title: 'Start Trip',
                              onTap: () {
                                context.subsription
                                    .startbooking(
                                        bookingId: widget.params.booking.id)
                                    .then((_) {});
                              }),
                        ),
                      )
                    : widget.params.booking.rideStatus == "COMPLETED"
                        ? Container(
                            color: AppColors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 20),
                            child: SafeArea(
                              child: BusyButton(
                                  color: Colors.red,
                                  title: 'Report Trip',
                                  onTap: () {
                                    context.subsription
                                        .reportbooking(
                                            bookingId: widget.params.booking.id,
                                            message: 'I am reporing this trip')
                                        .then((_) {});
                                  }),
                            ),
                          )
                        : widget.params.booking.rideStatus == "DRIVING"
                            ? Container(
                                color: AppColors.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 20),
                                child: SafeArea(
                                  child: BusyButton(
                                      color: Colors.red,
                                      title: 'End Trip',
                                      onTap: () {
                                        context.subsription
                                            .reportbooking(
                                                bookingId:
                                                    widget.params.booking.id,
                                                message:
                                                    'I am reporing this trip')
                                            .then((_) {});
                                      }),
                                ),
                              )
                            : null);
  }

  Widget containerRow(
    String subtext,
    String mainText,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryGrey.withOpacity(0.6),
      ),
      child: Row(
        children: [
          Text(
            subtext,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(20),
          Expanded(
            child: Text(
              mainText,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class ABookingDetailScreenParams {
  final Booking booking;

  ABookingDetailScreenParams({required this.booking});
}

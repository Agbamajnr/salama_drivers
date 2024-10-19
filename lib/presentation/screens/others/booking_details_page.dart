import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/presentation/widgets/busy_button.dart';

import '../../../core/formatter/formatter.dart';
import '../../../domain/entities/subscriptions/booking.dart';
import '../../widgets/network_image.dart';

class BookingDetails extends StatefulWidget {
  final BookingDetailScreenParams params;
  const BookingDetails({super.key, required this.params});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
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
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = context.subsription.booking.value;
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
              final booking = widget.params.booking;
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
                      '${booking.updatedAt.formatToCustomString()}',
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
                              '0gar Emmanuel',
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
                    containerRow('Ride Start', booking.startTime.toString()),
                    containerRow('Ride', booking.endTime.toString()),
                    containerRow(
                      'Created At',
                      '${booking.updatedAt.formatToCustomString()}',
                    ),
                    containerRow(
                      'Updated At',
                      '${booking.updatedAt.formatToCustomString()}',
                    ),
                  ],
                ),
              );
            }
          }),
      bottomNavigationBar: Container(
        color: AppColors.white,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: BusyButton(title: 'Report Trip', onTap: () {}),
      ),
    );
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

class BookingDetailScreenParams {
  final Booking booking;

  BookingDetailScreenParams({required this.booking});
}

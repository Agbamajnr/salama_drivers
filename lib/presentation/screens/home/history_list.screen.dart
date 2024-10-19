import 'package:flutter/material.dart';
import 'package:salama_users/core/extensions/ctx_extension.dart';
import 'package:salama_users/core/extensions/date_extension.dart';
import 'package:salama_users/core/routes/router_names.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/domain/entities/subscriptions/booking.dart';
import 'package:salama_users/presentation/widgets/empty_placeholder.dart';

import '../../../core/formatter/formatter.dart';
import '../others/booking_details_page.dart';

class RideHistoryScreen extends StatefulWidget {
  @override
  State<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {
  @override
  void initState() {
    context.subsription.fetchBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Trips',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body:
       StreamBuilder<List<Booking>?>(
          stream: context.subsription.userBookings.stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.isEmpty) {
              return Center(child: EmptyPlaceholder(text: 'No Trips yet'));
            } else {
              final trips = (snapshot.data as List<Booking>)
                  .where((e) => e.rideStatus?.isNotEmpty == true)
                  .toList();
              return Column(
                children: List.generate(trips.length, (index) {
                  final item = trips[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: ListTile(
                      onTap: () {
                        context.nav.pushNamed(Routes.bookingDetails,
                         arguments:BookingDetailScreenParams(
                                booking: item
                              ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.directions_car,
                            color: AppColors.dark),
                      ),
                      contentPadding: EdgeInsets.zero,
                      title: Flexible(
                        child: Text(
                          item.riderFromAddress,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      subtitle: Text(
                        '${item.updatedAt.formatToCustomString()}',
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: Text(
                          "₦ ${Formatter.money(
                            double.tryParse(item.amount.toString()) ?? 0,
                          )}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13)),
                    ),
                  );
                }),
              );
            }
          }),
    );
  }
}

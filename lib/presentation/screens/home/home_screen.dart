import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/extensions/ctx_extension.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/presentation/screens/home/booking_details_page.dart';
import 'package:salama_users/presentation/widgets/busy_button.dart';

import '../../../core/formatter/formatter.dart';
import '../../../core/routes/router_names.dart';
import '../../../domain/entities/subscriptions/booking.dart';
import '../../widgets/empty_placeholder.dart';
import '../others/booking_details_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool active = false;
  final _controller = ActionSliderController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/maps.png",
                  ),
                  fit: BoxFit.cover)),
          child: DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ActionSlider.standard(
                        toggleColor: AppColors.white,
                        sliderBehavior: SliderBehavior.stretch,
                        controller: _controller,
                        backgroundColor:
                            active ? AppColors.primaryColor : AppColors.dark,
                        boxShadow: [],
                        backgroundBorderRadius: BorderRadius.circular(0),
                        child: Text(
                          active ? 'Slide to Go Online' : 'Slide to Go Offline',
                          style: TextStyle(color: AppColors.white),
                        ),
                        action: (controller) async {
                          setState(() {
                            !active;
                          });
                        },
                      ),
                      const Gap(20),
                      StreamBuilder<List<Booking>?>(
                          stream: context.subsription.userBookings.stream,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.data!.isEmpty) {
                              return Center(
                                  child:
                                      EmptyPlaceholder(text: 'No Trips yet'));
                            } else {
                              final trips = (snapshot.data as List<Booking>)
                                  .where(
                                      (e) => e.rideStatus?.isNotEmpty == true)
                                  .toList();

                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                      itemCount: trips.length,
                                      itemBuilder: (context, index) {
                                        final item = trips[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          child: ListTile(
                                              onTap: () {
                                                context.nav.pushNamed(
                                                  Routes.bookingDetails,
                                                  arguments:
                                                      BookingDetailScreenParams(
                                                          booking: item),
                                                );
                                              },
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey[200],
                                                child: const Icon(
                                                    Icons.directions_car,
                                                    color: AppColors.dark),
                                              ),
                                              contentPadding: EdgeInsets.zero,
                                              title: Flexible(
                                                child: Text(
                                                  item.riderFromAddress,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              subtitle: Text(
                                                "₦ ${Formatter.money(
                                                  double.tryParse(item.amount
                                                          .toString()) ??
                                                      0,
                                                )}",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              trailing: InkWell(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                    Routes.abookingDetails,
                                                    arguments:
                                                        ABookingDetailScreenParams(
                                                            booking: item),
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 14),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primaryGrey
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Text(
                                                    'Accept',
                                                    style: TextStyle(
                                                        color: AppColors.dark,
                                                        height: 1),
                                                  ),
                                                ),
                                              )),
                                        );
                                      }),
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                );
              })),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salama_users/app/utils/logger.dart';
import 'package:salama_users/core/alerts/__export.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/extensions/ctx_extension.dart';
import 'package:salama_users/core/formatter/functions.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/domain/entities/subscriptions/subscription.dart';
import 'package:salama_users/presentation/screens/home/paystack_webview.dart';

import '../../../core/formatter/formatter.dart';
import '../../widgets/empty_placeholder.dart';

class EarningsScreen extends StatefulWidget {
  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  @override
  void initState() {
    context.subsription.fetchSubscriptions();
    context.subsription.fetchUserSubscriptions();
    context.subsription.fetchUserActiveSubscriptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var activeSubscription;
    setState(() {
     activeSubscription = context.subsription.userActiveSubscriptions.value;
    });

    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xffC7E6FC),
            AppColors.white,
          ],
        )),
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text('Subscriptions',
                  style: TextStyle(fontWeight: FontWeight.w700))),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubscriptionCard(
                  onSubscribe: () {},
                ),
                Gap(10),
                Text('Plans',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                StreamBuilder<List<Subscription>?>(
                    stream: context.subsription.subscriptions.stream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primaryBlue,
                        ));
                      } else if (snapshot.data!.isEmpty) {
                        return Center(
                            child:
                                EmptyPlaceholder(text: 'No Subscription yet'));
                      } else {
                        final trips = (snapshot.data as List<Subscription>)
                            .where((e) => e.id?.isNotEmpty == true)
                            .toList();
                        return Column(
                          children: List.generate(trips.length, (index) {
                            final item = trips[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              child: ListTile(
                                onTap: (){
                                  if(activeSubscription != null){
                                    if(activeSubscription.isActive != null){
                                      if(activeSubscription.isActive == true) {
                                        AppFlushbar.show("You have an active subscription");
                                      }else {
                                        context.subsription
                                            .subscribe(context, planId: item.id)
                                            .then((_) {
                                          if (_?.authorizationUrl != null) {
                                            String? url = _?.authorizationUrl;
                                            logger.w(url);
                                          }
                                        });
                                      }
                                    }else{
                                      context.subsription
                                          .subscribe(context, planId: item.id)
                                          .then((_) {
                                        if (_?.authorizationUrl != null) {
                                          String? url = _?.authorizationUrl;
                                          logger.w(url);
                                        }
                                      });
                                    }
                                  }else{
                                    context.subsription
                                        .subscribe(context, planId: item.id)
                                        .then((_) {
                                      if (_?.authorizationUrl != null) {
                                        String? url = _?.authorizationUrl;
                                        logger.w(url);
                                      }
                                    });
                                  }

                                },
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: const Icon(Icons.directions_car,
                                      color: AppColors.dark),
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: Flexible(
                                  child: Text(
                                    item.title,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                trailing: activeSubscription != null ? Text("") : activeSubscription?.isActive != null ? Text("")  : activeSubscription?.isActive == true ? Text("") :  Container(
                                  width: 40,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "Pay",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(25)
                                  ),
                                )
                              ),
                            );
                          }),
                        );
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}

class SubscriptionCard extends StatelessWidget {
  final Subscription? subscription;
  final VoidCallback onSubscribe;

  const SubscriptionCard({
    this.subscription,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    final activeSubscription = context.subsription.userActiveSubscriptions.value;
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: activeSubscription?.isActive == null || activeSubscription?.isActive == false ?   Colors.red : AppColors.primaryColor,
        elevation: 0.3,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: activeSubscription == null ?
          Center(child: Text("No Active Subscription."))
              : Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                '${activeSubscription.isActive == true ? 'Active' : 'Inactive'}',
                style: TextStyle(fontSize: 16, color: activeSubscription.isActive == true ?  Colors.greenAccent : Colors.red),
              ),
              SizedBox(height: 5),
              Text(
                'Next renewal: ${Functions.getFormattedDate(DateTime.parse(activeSubscription.expiresAt.toString()))}',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade300),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

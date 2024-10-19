import 'package:flutter/material.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/extensions/ctx_extension.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/domain/entities/subscriptions/subscription.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(fontWeight: FontWeight.w700))
                  ),
          body: StreamBuilder<List<Subscription>?>(
              stream: context.subsription.subscriptions.stream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator(color: AppColors.primaryBlue,));
                } else if (snapshot.data!.isEmpty) {
                  return Center(child: EmptyPlaceholder(text: 'No Subscription yet'));
                } else {
                  final trips = (snapshot.data as List<Subscription>)
                      .where((e) => e.id?.isNotEmpty == true)
                      .toList();
                  return Column(
                children: List.generate(trips.length, (index) {
                  final item = trips[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: ListTile(
                  
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
        ));
  }

}

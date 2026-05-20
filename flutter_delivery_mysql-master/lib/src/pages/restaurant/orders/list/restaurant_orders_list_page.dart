import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/order.dart';
import 'package:udemy_flutter_delivery/src/pages/restaurant/orders/list/restaurant_orders_list_controller.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';
import 'package:udemy_flutter_delivery/src/utils/relative_time_util.dart';
import 'package:udemy_flutter_delivery/src/widgets/app_order_card.dart';
import 'package:udemy_flutter_delivery/src/widgets/no_data_widget.dart';

class RestaurantOrdersListPage extends StatelessWidget {
  final RestaurantOrdersListController con =
      Get.put(RestaurantOrdersListController());

  RestaurantOrdersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: con.status.length,
        child: Scaffold(
          appBar: _header(context),
          body: TabBarView(
            children: con.status.map((String status) {
              return _ordersByStatus(status);
            }).toList(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _header(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(104),
      child: Container(
        color: AppColors.background,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pedidos recibidos',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  dividerColor: Colors.transparent,
                  tabs: List<Widget>.generate(con.status.length, (index) {
                    return Tab(child: Text(con.status[index]));
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _ordersByStatus(String status) {
    return FutureBuilder(
      future: con.getOrders(status),
      builder: (context, AsyncSnapshot<List<Order>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 96),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (_, index) {
              return _cardOrder(snapshot.data![index]);
            },
          );
        }

        return const NoDataWidget(text: 'No hay órdenes');
      },
    );
  }

  Widget _cardOrder(Order order) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: AppOrderCard(
          orderId: '${order.id}',
          dateText: RelativeTimeUtil.getRelativeTime(order.timestamp ?? 0),
          personLabel: 'Cliente',
          personName:
              '${order.client?.name ?? ''} ${order.client?.lastname ?? ''}',
          address: order.address?.address ?? '',
          onTap: () => con.goToOrderDetail(order),
        ),
      ),
    );
  }
}

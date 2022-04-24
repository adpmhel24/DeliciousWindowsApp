import 'package:auto_route/auto_route.dart';
import 'package:delicious_inventory_system/global_bloc/bloc.dart';
import 'package:delicious_inventory_system/router/router.gr.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/material.dart' as m;

class MasterDataHomeScreen extends StatelessWidget {
  const MasterDataHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menus = masterDataMenu(context);
    return ScaffoldPage(
      content: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100.0,
          childAspectRatio: .9,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: menus.length,
        itemBuilder: (ctx, i) => masterDataMenuCard(
          label: menus[i]["label"],
          icon: menus[i]["icon"],
          onTap: menus[i]["onTap"],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> masterDataMenu(BuildContext context) {
  final router = AutoRouter.of(context)
      .parent()!
      .innerRouterOf<StackRouter>(MasterDataRouter.name);

  List<Map<String, dynamic>> menus = [
    {
      "label": "Customers",
      "icon": const Icon(FluentIcons.account_management),
      "onTap": () {
        router?.push(const CustomersScreenRoute());
        context.read<CustomersBloc>().add(
              FetchCustomerFromAPI(),
            );
      }
    },
    {
      "label": "Users",
      "icon": const Icon(FluentIcons.user_followed),
      "onTap": () {
        router?.push(const CustomersScreenRoute());
      }
    },
    {
      "label": "Items",
      "icon": const Icon(FluentIcons.product_catalog),
      "onTap": () {
        router?.push(const CustomersScreenRoute());
      }
    },
  ];
  return menus;
}

CustomCard masterDataMenuCard(
    {required String label, required Widget icon, void Function()? onTap}) {
  return CustomCard(
    width: 100,
    height: 100,
    borderRadius: 5,
    color: const Color(0xFFEEEDDE),
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(
          height: 10.h,
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

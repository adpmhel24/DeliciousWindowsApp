import 'package:fluent_ui/fluent_ui.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Orders'),
      ),
      content: TabView(
        currentIndex: currentIndex,
        closeButtonVisibility: CloseButtonVisibilityMode.never,
        onChanged: (index) => setState(() => currentIndex = index),
        tabs: const [
          Tab(
            icon: Icon(FluentIcons.add_to_shopping_list),
            text: Text('Tab Confirmation'),
          ),
          Tab(
            icon: Icon(FluentIcons.delivery_truck),
            text: Text('For Dispatch'),
          ),
          Tab(
            icon: Icon(FluentIcons.completed),
            text: Text('Completed'),
          ),
        ],
        bodies: [
          Container(
            color: const Color(0xFFFDEFF4),
            child: const Center(
              child: Text("For Confirmation"),
            ),
          ),
          Container(
            color: const Color(0xFFFDEFF4),
            child: const Center(
              child: Text("For Dispatch"),
            ),
          ),
          Container(
            color: const Color(0xFFFDEFF4),
            child: const Center(
              child: Text("Completed"),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:delicious_inventory_system/data/models/models.dart';
import 'package:delicious_inventory_system/presentations/utils/constant.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_bloc/bloc.dart';

class BrgyModalContent extends StatelessWidget {
  const BrgyModalContent({
    Key? key,
    required this.onTap,
    required this.controller,
  }) : super(key: key);

  final void Function(BrgyModel classModel) onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          TextBox(
            placeholder: "Search",
            onChanged: (value) {
              context.read<BrgyBloc>().add(SearchBrgyByKeyword(value));
            },
            autofocus: true,
          ),
          Constant.columnSpacer,
          Expanded(
            child: BlocBuilder<BrgyBloc, BrgyState>(
              builder: (_, state) {
                if (state.status == BrgyStateStatus.success) {
                  return ListView.separated(
                    separatorBuilder: (_, indx) => const Divider(
                      size: 1,
                    ),
                    itemCount: state.brgys.length,
                    itemBuilder: (_, indx) {
                      return GestureDetector(
                        onTap: () {
                          onTap(state.brgys[indx]);
                          controller.text = state.brgys[indx].name;
                        },
                        child: ListTile(
                          title: Text(
                            state.brgys[indx].name,
                            style: controller.text == state.brgys[indx].name
                                ? const TextStyle(fontWeight: FontWeight.bold)
                                : null,
                          ),
                        ),
                      );
                    },
                  );
                } else if (state.status == BrgyStateStatus.error) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const Center(child: ProgressRing());
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:delicious_inventory_system/data/models/models.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_bloc/bloc.dart';
import '../utils/constant.dart';

class CityMunicipalityModalContent extends StatelessWidget {
  const CityMunicipalityModalContent(
      {Key? key, required this.onTap, required this.controller})
      : super(key: key);

  final void Function(CityMunicipalityModel classModel) onTap;
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
              context
                  .read<CityMunicipalityBloc>()
                  .add(SearchCityMunicipalityByKeyword(value));
            },
            autofocus: true,
          ),
          Constant.columnSpacer,
          Expanded(
            child: BlocBuilder<CityMunicipalityBloc, CityMunicipalityState>(
              builder: (_, state) {
                if (state.status == CityMunicipalityStateStatus.success) {
                  return ListView.separated(
                    separatorBuilder: (_, indx) => const Divider(
                      size: 1,
                    ),
                    itemCount: state.cityMunicipality.length,
                    itemBuilder: (_, indx) {
                      return GestureDetector(
                        onTap: () {
                          onTap(state.cityMunicipality[indx]);
                          controller.text = state.cityMunicipality[indx].name;
                        },
                        child: ListTile(
                          title: Text(
                            state.cityMunicipality[indx].name,
                            style: controller.text ==
                                    state.cityMunicipality[indx].name
                                ? const TextStyle(fontWeight: FontWeight.bold)
                                : null,
                          ),
                        ),
                      );
                    },
                  );
                } else if (state.status == CityMunicipalityStateStatus.error) {
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

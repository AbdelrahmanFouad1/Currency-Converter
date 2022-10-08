import 'package:shimmer/shimmer.dart';

import '../bloc/currency_history_state.dart';
import '/core/util/resources/colors_manager.dart';
import '/core/util/resources/extensions_manager.dart';
import '/features/currency_history/presentation/widgets/linear_graph.dart';
import '/features/currency_history/presentation/widgets/previous_and_current.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/resources/font_manager.dart';
import '../../../home/presentation/bloc/home_cubit.dart';
import '../../../home/presentation/bloc/home_state.dart';
import '../bloc/currency_history_cubit.dart';

class CurrencyHistoryWidget extends StatefulWidget {
  const CurrencyHistoryWidget({Key? key}) : super(key: key);

  @override
  State<CurrencyHistoryWidget> createState() => _CurrencyHistoryWidgetState();
}

class _CurrencyHistoryWidgetState extends State<CurrencyHistoryWidget> {
  final formKey = GlobalKey<FormState>();

  List<String> times = [
    'Weekly',
    'Monthly',
    'Annually',
  ];

  int selectedTimIndex = 0;

  void _onTimeSelected(int index) {
    setState(() {
      selectedTimIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    CurrencyHistoryBloc.get(context).currencyHistory(
      from: HomeBloc.get(context).selectedFirstCountryModel!.currencyId,
      to: HomeBloc.get(context).selectedSecondCountryModel!.currencyId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0.rSp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PreviousAndCurrent(
            previousFirst: HomeBloc.get(context).selectedFirstCountryModel!,
            currentSecond: HomeBloc.get(context).selectedSecondCountryModel!,
          ),
          verticalSpace(20.rSp),
          SizedBox(
            height: 37.rSp,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.0.rSp),
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Material(
                borderRadius: BorderRadius.circular(50.rSp),
                color: selectedTimIndex == index
                    ? ColorsManager.white
                    : Colors.transparent,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _onTimeSelected(index);
                    });
                  },
                  splashColor: ColorsManager.regularGrey,
                  child: SizedBox(
                    width: 85.rSp,
                    child: Center(
                      child: Text(
                        times[index],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14.rSp,
                              fontWeight: FontWeightManager.medium,
                              color: selectedTimIndex == index
                                  ? ColorsManager.primary
                                  : ColorsManager.darkGrey,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => horizontalSpace(2.rSp),
              itemCount: 3,
            ),
          ),

          ///Linear graph
          verticalSpace(20.rSp),
          BlocBuilder<CurrencyHistoryBloc, CurrencyHistoryState>(
            builder: (context, state) {
              return state is CurrencyHistorySuccess ? LinearGraph(history: state.history,) : SizedBox(
                height: 216.rSp,
                width: double.infinity,
                child: Shimmer.fromColors(
                  baseColor:  ColorsManager.darkGrey,
                  highlightColor: ColorsManager.lightGrey,
                  child:  Container(
                    color: ColorsManager.darkGrey.withOpacity(0.2),
                  ),
                ),

              );
            },
          ),

          verticalSpace(16.rSp),

          BlocBuilder<CurrencyHistoryBloc, CurrencyHistoryState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => state
                          is CurrencyHistorySuccess
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22.0.rSp),
                          child: Container(
                            decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? null
                                  : ColorsManager.darkGrey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.rSp),
                            ),
                            padding: EdgeInsets.all(16.rSp),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    state
                                        .history[index].value1.dayOfWeek,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeightManager.medium,
                                          color: ColorsManager.darkGrey,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    state.history[index].value2
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 18.rSp,
                                          fontWeight:
                                              FontWeightManager.semiBold,
                                          color: ColorsManager.darkGrey,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    state.history[index].value1.yMd,
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeightManager.medium,
                                          color: ColorsManager.darkGrey,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Shimmer.fromColors(
                          baseColor: ColorsManager.darkGrey,
                          highlightColor: ColorsManager.lightGrey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22.0.rSp, vertical: 10.0.rSp),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorsManager.darkGrey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.rSp),
                              ),
                              padding: EdgeInsets.all(22.rSp),
                            ),
                          ),
                        ),
                  itemCount: state is CurrencyHistorySuccess
                      ? state.history.length
                      : 7,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

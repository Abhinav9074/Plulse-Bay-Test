// ignore_for_file: must_be_immutable, use_build_context_synchronously


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_bay/application/home_bloc/home_bloc.dart';
import 'package:pulse_bay/application/home_bloc/home_event.dart';
import 'package:pulse_bay/application/home_bloc/home_state.dart';
import 'package:pulse_bay/application/region_bloc/region_bloc.dart';
import 'package:pulse_bay/application/region_bloc/region_event.dart';
import 'package:pulse_bay/application/region_bloc/region_state.dart';
import 'package:pulse_bay/application/tradie_bloc/tradie_event.dart';
import 'package:pulse_bay/application/tradie_bloc/traide_bloc.dart';
import 'package:pulse_bay/domain/api/api_config.dart';
import 'package:pulse_bay/domain/api/api_data_fetch.dart';
import 'package:pulse_bay/presentation/config/text_styles.dart';
import 'package:pulse_bay/presentation/screens/home/widgets/app_bar.dart';
import 'package:pulse_bay/presentation/widgets/button.dart';
import 'package:pulse_bay/presentation/widgets/drawer_items.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

      String industry = '';
      String location = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerItems(),
        backgroundColor: const Color.fromARGB(245, 245, 245, 245),
        appBar: const CustomAppBar(),
        body: SmartRefresher(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            BlocProvider.of<HomeBloc>(context).add(HomeDataFetchEvent());
            BlocProvider.of<RegionBloc>(context).add(RegionFetchEvent());
            _refreshController.refreshCompleted();
          },
          enablePullDown: true,
          controller: _refreshController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Text heading
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'LOOKING FOR',
                  style: MyTextStyle.headingSmall,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadedState) {
                      return DropdownSearch(
                        onChanged: (value){
                          log(value.toString());
                        industry=value!;
                      },
                        items: industryList.value.map((e) {
                          return e.name;
                        }).toList(),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: DropdownSearch(),
                      );
                    }
                  },
                ),
              ),
              BlocBuilder<RegionBloc, RegionState>(
                builder: (context, state) {
                  if(state is RegionLoadedState){
                    return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: DropdownSearch(
                      onChanged: (value){
                        log(value.toString());
                        location=value!;
                      },
                      items: regionList.value.map((e){
                        return e.name;
                      }).toList(),
                    ),
                  );
                  }else{
                    return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: DropdownSearch(),
                  );
                  }
                },
              ),

               CommonButton(text: 'Search',onPressed: (){
                if(location.isNotEmpty){
                  BlocProvider.of<TradieBloc>(context).add(TradieDateFetchEvent(location: location));
                Navigator.pushNamed(context, '/tradies',arguments: location);
                }
               },),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Expanded(
                      child: ValueListenableBuilder(
                          valueListenable: industryList,
                          builder:
                              (BuildContext context, dynamic list, Widget? _) {
                            return _industryGridView(list, context);
                          }),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

//Grid view of all industries
  Widget _industryGridView(List<dynamic> list, BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(list.length, (index) {
        final data = list[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 194, 192, 192)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.network(
                  width: 50,
                  height: 50,
                  ApiConfig.baseUrl + data.icon,
                  semanticsLabel: 'Image',
                  placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    height: 50,
                    width: 50,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.name,
                  style: MyTextStyle.headingExtraSmall,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

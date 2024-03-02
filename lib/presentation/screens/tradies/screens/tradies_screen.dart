import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_bay/application/tradie_bloc/tradie_state.dart';
import 'package:pulse_bay/application/tradie_bloc/traide_bloc.dart';
import 'package:pulse_bay/domain/api/api_config.dart';
import 'package:pulse_bay/domain/api/api_data_fetch.dart';
import 'package:pulse_bay/domain/models/tradies_model.dart';
import 'package:pulse_bay/presentation/config/text_styles.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TradiedScreen extends StatelessWidget {
  const TradiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          data!.toString(),
          style: MyTextStyle.headingSmall,
        ),
      ),
      body: BlocBuilder<TradieBloc, TradieState>(
        builder: (context, state) {
          if (state is TradieLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (tradiesList.value.isEmpty) {
            return Center(child: Lottie.asset('assets/logo/no_data.json'));
          } else if (state is TradieDataLoadedState) {
            return Column(
              children: [
                Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: tradiesList,
                        builder: (BuildContext context, List<TradiesModel> list,
                            Widget? _) {
                          return ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                final values = list[index];
                                return ListTile(
                                  leading: Image.network(ApiConfig.baseUrl+values.logo!,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error,size: 50,);
                                  },
                                  width: 50,
                                  ),
                                  title: Text(values.name!,style: MyTextStyle.headingSmall,),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(values.region!,style: MyTextStyle.smallText,),
                                      Text('Rating : ${values.rating}',style: MyTextStyle.smallText,),
                                    ],
                                  ),
                                );
                              });
                        }))
              ],
            );
          }else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

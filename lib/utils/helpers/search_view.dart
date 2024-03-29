import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/search_view_controller.dart';
import '../constants/string_constants.dart';

class SearchView extends SearchDelegate {
  SearchViewController searchViewController = Get.put(SearchViewController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              "Search term must be of at least one letter letters.",
            ),
          )
        ],
      );
    } else {
      searchViewController.getSuggestion(query);
      return Obx(
        () {
          if (searchViewController.isLoading.value == true) {
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: Lottie.asset(
                  StringConstants.loadingLottie,
                  repeat: true,
                ),
              ),
            );
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: searchViewController.placeList.value.length,
              itemBuilder: (context, index) {
                String description =
                    searchViewController.placeList.value[index].description!;
                return ListTile(
                  title: Text(description),
                  onTap: () {
                    close(context, description);
                  },
                );
              },
            );
          }
        },
      );
    }
  }
}

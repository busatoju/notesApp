import 'package:flutter/material.dart';
import 'package:note_app/features/home/home_view_model.dart';

class ListNote extends StatelessWidget {
  const ListNote({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: ListView.builder(
          itemCount: viewModel.lenghtList,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () =>
                    viewModel.navigatorDetailsPage(viewModel.listNote[index]),
                title: Text(viewModel.listNote[index].title),
                subtitle: Text(
                  viewModel.listNote[index].body,
                  maxLines: 1,
                ),
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:note_app/features/home/list_note.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _viewModel;

  @override
  void didChangeDependencies() {
    _viewModel = HomeViewModel(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas'),
        actions: [
          IconButton(
              onPressed: () => _viewModel.logoff(),
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: StreamBuilder<List<Note>>(
          stream: _viewModel.fetchListNote(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done ||
                snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data?.isNotEmpty ?? false) {
                _viewModel.setListNote = snapshot.data ?? [];
                return ListNote(
                  viewModel: _viewModel,
                );
              } else {
                return const Center(
                  child: Text(
                    'Não há anotações',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
            } else {
              return Container();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _viewModel.navigatorCreateNote(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

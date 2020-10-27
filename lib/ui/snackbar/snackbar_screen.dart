import 'package:flutter/material.dart';
import 'package:flutter_app/ui/snackbar/snackbar_bloc.dart';
import 'package:flutter_app/ui/snackbar/snackbar_event.dart';
import 'package:flutter_app/ui/snackbar/snackbar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnackBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SnackBarBloc(),
      child: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocListener<SnackBarBloc, SnackBarState> (
        listener: (context, state) {
          if(state is Success) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text('success'),
              )
            );
          }
        },
        child: BlocBuilder<SnackBarBloc, SnackBarState> (
          builder: (context, state) {
            if(state is Initial) {
              return Center(child: Text('Press'));
            }
            if(state is Loading) {
              return Center(child: CircularProgressIndicator());
            }
            if(state is Success) {
              return Center(child: Text('Success'));
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.tag_faces),
            onPressed: () => BlocProvider.of<SnackBarBloc>(context).add(FetchData()),
          )
        ],
      ),
    );
  }
}


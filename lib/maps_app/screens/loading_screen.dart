import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/maps_app/screens/screens.dart';
import '/maps_app/blocs/gps/gps_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllReady ? const MapScreen() : const GpsAccesScreen();
        },
      ),
    );
  }
}

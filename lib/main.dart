import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'maps_app/maps_app.dart';
import 'maps_app/blocs/blocs.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(
          create: (context) => MapBloc(
            locationBloc: BlocProvider.of<LocationBloc>(context),
          ),
        ),
      ],
      child: const MapsApp(),
    ),
  );
}

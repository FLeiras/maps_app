import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? _mapCtrl;

  MapBloc() : super(const MapState()) {
    on<MapEvent>((event, emit) {});

    on<OnMapInitializedEvent>(_onInitMap);
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapCtrl = event.controller;

    emit(state.copyWith(isMapInitialized: true));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);

    _mapCtrl!.animateCamera(cameraUpdate);
  }
}

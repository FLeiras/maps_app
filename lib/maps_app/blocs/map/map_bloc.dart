import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapCtrl;
  StreamSubscription<LocationState>? locationStateSubcription;

  MapBloc({
    required this.locationBloc,
  }) : super(const MapState()) {
    on<MapEvent>((event, emit) {});

    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowUser>(_onStartFollowingUser);
    on<OnStopFollowUser>(
        (event, emit) => emit(state.copyWith(isFollowingUser: false)));

    on<UpdateUserPolyLinesEvent>(_onPolylineNewPoint);
    on<OnToggleUserRoute>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));

    locationStateSubcription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnowLocation != null) {
        add(UpdateUserPolyLinesEvent(locationState.myLocationHystory));
      }

      if (!state.isFollowingUser) return;
      if (locationState.lastKnowLocation == null) return;

      moveCamera(locationState.lastKnowLocation!);
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapCtrl = event.controller;

    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser(OnStartFollowUser event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));

    if (locationBloc.state.lastKnowLocation == null) return;
    moveCamera(locationBloc.state.lastKnowLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolyLinesEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.red,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocationHistory,
    );

    final currentPolyline = Map<String, Polyline>.from(state.polylines);
    currentPolyline['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolyline));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);

    _mapCtrl?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubcription?.cancel();
    return super.close();
  }
}

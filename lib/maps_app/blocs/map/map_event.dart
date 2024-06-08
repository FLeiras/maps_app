part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;

  const OnMapInitializedEvent(this.controller);
}

class OnStartFollowUser extends MapEvent {}

class OnStopFollowUser extends MapEvent {}

class UpdateUserPolyLinesEvent extends MapEvent {
  final List<LatLng> userLocationHistory;
  const UpdateUserPolyLinesEvent(this.userLocationHistory);
}

class OnToggleUserRoute extends MapEvent {}

part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnowLocation;
  final List<LatLng> myLocationHystory;

  const LocationState({
    this.followingUser = false,
    this.lastKnowLocation,
    myLocationHystory,
  }) : myLocationHystory = myLocationHystory ?? const [];

  @override
  List<Object?> get props => [
        followingUser,
        lastKnowLocation,
        myLocationHystory,
      ];

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnowLocation,
    List<LatLng>? myLocationHystory,
  }) =>
      LocationState(
        followingUser: followingUser ?? this.followingUser,
        lastKnowLocation: lastKnowLocation ?? this.lastKnowLocation,
        myLocationHystory: myLocationHystory ?? this.myLocationHystory,
      );
}

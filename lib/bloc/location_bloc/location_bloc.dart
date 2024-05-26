import 'package:absher/bloc/location_bloc/location_event.dart';
import 'package:absher/core/app_enums.dart';

import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/repos/favorite_repository.dart';
import '../../data/repos/location_respository.dart';
import '../../models/vendor_model.dart';
import '../../presentation/screens/location_screen/widgets/marker.dart';
import 'location_state.dart';
import 'package:custom_map_markers/custom_map_markers.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  double? latitudeCurrent, longitudeCurrent;

  GoogleMapController? mapController;

  List<VendorModel> allVendors = [];
  List<VendorModel> selectedVendors = [];

  List<Category> allCategories = [];
  List<Category> selectedCategories = [];
  List<Category> pendingCategories = [];

  List<MarkerData> currentMarkers = [];

  LocationBloc() : super(LocationState()) {
    on<LocationEvent>((event, emit) async {
      if (event is CurrentLocation) {
        emit(state.copyWith(screenStates: ScreenStates.loading));
        await getPosition();
        if (latitudeCurrent == null) {
          emit(ExitLocation());
        } else {
          final response = await LocationRepository.getVendorsNear(
              latitude: latitudeCurrent!, longitude: longitudeCurrent!);
          response.fold((l) {
            emit(state.copyWith(screenStates: ScreenStates.error, error: l));
          }, (r) {
            allVendors = r;
            for (VendorModel vendor in allVendors) {
              if (!allCategories
                  .any((element) => element.id == vendor.category!.id)) {
                allCategories.add(vendor.category!);
              }
            }
            selectedCategories.addAll(allCategories);
            pendingCategories.addAll(selectedCategories);
            refreshSelectedVendorsList();
            setMarkers();
            emit(state.copyWith(
                screenStates: ScreenStates.success,
                latitude: latitudeCurrent,
                longitude: longitudeCurrent,
                vendorList: [...allVendors],
                allCategories: allCategories,
                pendingCategories: pendingCategories,
                selectedCategories: selectedCategories,
                vendorSelected: selectedVendors,
                myMark: [...currentMarkers]));
          });
        }
      }

      if (event is FilterVendors) {
        selectedCategories.clear();
        selectedCategories.addAll(pendingCategories);
        refreshSelectedVendorsList();
        setMarkers();
        emit(state.copyWith(
            myMark: [...currentMarkers],
            vendorSelected: selectedVendors,
            index: -1,
            check: !state.check));
      }

      if (event is ClickMarker) {
        emit(state.copyWith(index: event.index));
      }

      if (event is IndexIncrement) {
        int indexIncrement = state.index;
        if (indexIncrement == state.vendorSelected.length - 1) {
          mapController?.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(double.parse(state.vendorSelected[0].latitude!),
                  double.parse(state.vendorSelected[0].longitude!)),
              16));

          emit(state.copyWith(index: 0));
        } else {
          mapController?.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(
                  double.parse(state.vendorSelected[state.index + 1].latitude!),
                  double.parse(
                      state.vendorSelected[state.index + 1].longitude!)),
              16));
          emit(state.copyWith(index: indexIncrement + 1));
        }
      }

      if (event is IndexDecrement) {
        int indexIncrement = state.index;
        if (indexIncrement == 0) {
          mapController?.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(
                  double.parse(state
                      .vendorSelected[state.vendorSelected.length - 1]
                      .latitude!),
                  double.parse(state
                      .vendorSelected[state.vendorSelected.length - 1]
                      .longitude!)),
              16));
          emit(state.copyWith(index: state.vendorSelected.length - 1));
        } else {
          mapController?.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(
                  double.parse(
                      state.vendorSelected[indexIncrement - 1].latitude!),
                  double.parse(
                      state.vendorSelected[indexIncrement - 1].longitude!)),
              16));
          emit(state.copyWith(index: indexIncrement - 1));
        }
      }

      if (event is CheckIndex) {
        if (pendingCategories
            .any((element) => element.id == allCategories[event.index].id)) {
          pendingCategories.remove(allCategories[event.index]);
          emit(state.copyWith(
              pendingCategories: pendingCategories, check: !state.check));
        } else {
          pendingCategories.add(allCategories[event.index]);
          emit(state.copyWith(
              pendingCategories: pendingCategories, check: !state.check));
        }
      }

      if (event is ChangeLocationListFavoriteStatus) {
        int targetedIndex = selectedVendors
            .indexWhere((element) => element.id == event.vendorId);
        if (selectedVendors[targetedIndex].favoriteStatus) {
          selectedVendors[targetedIndex].favoriteStatus = false;
          int currentIndex = state.index;
          emit(state.copyWith(vendorSelected: selectedVendors, index: 0));
          emit(state.copyWith(
              vendorSelected: selectedVendors, index: currentIndex));
          final response =
              await FavoriteRepository.removeFavorite(event.vendorId);
          response.fold((l) {
            selectedVendors[targetedIndex].favoriteStatus = true;
            int currentIndex = state.index;
            emit(state.copyWith(vendorSelected: selectedVendors, index: 0));
            emit(state.copyWith(
                vendorSelected: selectedVendors, index: currentIndex));
          }, (r) {});
        } else {
          selectedVendors[targetedIndex].favoriteStatus = true;
          int currentIndex = state.index;
          emit(state.copyWith(vendorSelected: selectedVendors, index: 0));
          emit(state.copyWith(
              vendorSelected: selectedVendors, index: currentIndex));
          final response = await FavoriteRepository.addFavorite(event.vendorId);
          response.fold((l) {
            selectedVendors[targetedIndex].favoriteStatus = false;
            int currentIndex = state.index;
            emit(state.copyWith(vendorSelected: selectedVendors, index: 0));
            emit(state.copyWith(
                vendorSelected: selectedVendors, index: currentIndex));
          }, (r) {});
        }
      }
    });
  }

  void refreshSelectedVendorsList() {
    selectedVendors.clear();
    for (VendorModel vendor in allVendors) {
      if (selectedCategories
          .any((element) => element.id == vendor.category!.id)) {
        selectedVendors.add(vendor);
      }
    }
  }

  Future<void> getPosition() async {
    await determinePosition().then((value) {
      if (value == null) return;
      latitudeCurrent = value.latitude;
      longitudeCurrent = value.longitude;
    });
  }

  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    try {
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location services are disabled.');
      }
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          return Future.error('Location services are disabled.');
        }
      }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }

  setMarkers() {
    currentMarkers.clear();
    currentMarkers.add(
      MarkerData(
          marker: Marker(
            markerId: const MarkerId("My Location"),
            position: LatLng(latitudeCurrent!, longitudeCurrent!),
          ),
          child: Image.asset(
            ImageManager.locationMap,
            width: 100,
            height: 100,
          )),
    );
    for (int i = 0; i < selectedVendors.length; i++) {
      currentMarkers.add(MarkerData(
          marker: Marker(
              draggable: false,
              markerId: MarkerId("$i"),
              position: LatLng(double.parse(selectedVendors[i].latitude ?? "0"),
                  double.parse(selectedVendors[i].longitude ?? "0")),
              onTap: () {
                add(ClickMarker(i));
              }),
          child: MarkerWidget(
              image: selectedVendors[i].category!.thumbnail!,
              colors: selectedVendors[i].category!.color!)));
    }
  }
}

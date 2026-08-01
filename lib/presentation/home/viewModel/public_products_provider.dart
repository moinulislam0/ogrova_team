import 'package:flutter_riverpod/flutter_riverpod.dart'; // legacy এর বদলে এটি ব্যবহার করা ভালো
import 'package:flutter_riverpod/legacy.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/models/public_products_model.dart';
import 'package:ogrova_team/data/repositories/public_products_repository.dart';
import 'package:ogrova_team/data/sources/remote/public_products_service.dart';

class PublicProductsState {
  final String? errorMessage;
  final bool isLoading;
  final ProductResponse? data;

  PublicProductsState({required this.isLoading, this.errorMessage, this.data});

  PublicProductsState copyWith({
    bool? isLoading,
    String? errorMessage,
    ProductResponse? data,
  }) {
    return PublicProductsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}

class PublicProductsProvicer extends StateNotifier<PublicProductsState> {
  final PublicProductsRepository remote;

  PublicProductsProvicer({required this.remote})
    : super(PublicProductsState(isLoading: false));

  Future<bool> getPublicProducts() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await remote.products();

      state = state.copyWith(
        isLoading: false,
        data: response,
        errorMessage: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }
}

final publicProducts =
    StateNotifierProvider<PublicProductsProvicer, PublicProductsState>((ref) {
      return PublicProductsProvicer(
        remote: PublicProductsRepository(
          remoteService: PublicProductsService(apiClient: ApiClient()),
        ),
      );
    });

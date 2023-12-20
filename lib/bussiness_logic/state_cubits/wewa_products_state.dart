part of 'wewa_products_cubit.dart';

@immutable
abstract class WewaProductsState {}

class WewaProductsInitial extends WewaProductsState {}
class WewaProductsSuccess extends WewaProductsState {}
class WewaCategorisSuccess extends WewaProductsState {}
class WewaProductsNewCat extends WewaProductsState {}
class WewaProductsLoading extends WewaProductsState {}
class WewaProductsFail extends WewaProductsState {}
class WewaProductsFiltered extends WewaProductsState {}

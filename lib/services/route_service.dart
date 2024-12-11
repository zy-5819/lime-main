// import 'package:capella_app/api/generated/app/route.pbgrpc.dart';
// import 'package:capella_app/api/generated/google/protobuf/any.pb.dart';
// import 'package:capella_app/providers/top_level_providers.dart';
// import 'package:capella_app/services/geometry_factory.dart';
// import 'package:capella_app/services/logout_interceptor.dart';
// import 'package:capella_app/services/logout_service.dart';
// import 'package:capella_app/util/log_util.dart';
// import 'package:dart_jts/dart_jts.dart';
// import 'package:fixnum/fixnum.dart';
// import 'package:flutter/material.dart';
// import 'package:grpc/grpc.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class RouteService extends LogoutService {
//   final Ref _ref;
//   late RouteRpcClient _route;

//   RouteService(this._ref) : super(_ref) {
//     _route = RouteRpcClient(_ref.watch(channelProvider), interceptors: [
//       LogoutInterceptor(
//         onLoggedOutDetected: onLoggedOutDetected,
//         callOptions: options,
//       )
//     ]);
//   }

//   Future<RouteDto> create(String? name, String? description, Int64? mapId,
//       Int64? mapVersion, List<Offset> points) async {
//     try {
//       return await _route.create(CreateRouteRequest(
//         name: name,
//         description: description,
//         mapId: mapId,
//         mapVersion: mapVersion,
//         geometry: WKBWriter()
//             .write(geometryFactory.createLineString(
//                 points.map((e) => Coordinate(e.dx, e.dy)).toList()))
//             .toList(),
//       ));
//     } on GrpcError catch (e) {
//       Log.d('route_service/create:$e');
//       rethrow;
//     }
//   }

//   Future<void> updateGeometry(
//       Int64? id, Int64? mapId, Int64? mapVersion, List<Offset> points) async {
//     try {
//       await _route.updateGeometry(UpdateRouteGeometryRequest(
//           id: id,
//           mapId: mapId,
//           mapVersion: mapVersion,
//           geometry: WKBWriter().write(geometryFactory.createLineString(
//             points.map((e) => Coordinate(e.dx, e.dy)).toList(),
//           ))));
//     } on GrpcError catch (e) {
//       Log.d('route_service/updateGeometry:${e.message}');
//       rethrow;
//     }
//   }

//   Future<void> update(Int64? routeId, String? name, String? description) async {
//     try {
//       await _route.update(UpdateRouteRequest(
//         id: routeId,
//         name: name,
//         description: description,
//       ));
//     } on GrpcError catch (e) {
//       Log.d('route_service/update:${e.message}');
//       rethrow;
//     }
//   }

//   ///根据查询条件分页查询路线
//   Future<List<RouteDto>> listBy({
//     Int64? mapId,
//     String? keyword,
//     int page = 1,
//     int pageSize = 10,
//   }) async {
//     try {
//       final routes = await _route.list(ListRequest(
//           filters: Any.pack(RouteFilter(mapId: mapId)),
//           keyword: keyword,
//           paging: PagingInfo(page: page, pageSize: pageSize)));
//       return routes.results;
//     } on GrpcError catch (e) {
//       Log.d('route_service/listBy:${e.message}');
//       rethrow;
//     }
//   }

//   Future<RouteListResponse> listByMapId(Int64? mapId) async {
//     try {
//       return await _route
//           .list(ListRequest(filters: Any.pack(RouteFilter(mapId: mapId))));
//     } on GrpcError catch (e) {
//       Log.d('route_service/list:${e.message}');
//       rethrow;
//     }
//   }

//   Future<List<RouteDto>> listAndPage(ListRequest listRequest) async {
//     try {
//       return (await _route.list(listRequest)).results;
//     } on GrpcError catch (e) {
//       Log.d('route_service/list:${e.message}');
//       rethrow;
//     }
//   }

//   Future<RouteDto> get(Int64? routeId) async {
//     try {
//       return await _route.get(GetRequest(id: routeId));
//     } on GrpcError catch (e) {
//       Log.d('route_service/get:${e.message}');
//       rethrow;
//     }
//   }

//   Future<void> delete(Int64? routeId) async {
//     try {
//       await _route.delete(DeleteRequest(id: routeId));
//     } on GrpcError catch (e) {
//       Log.d('route_service/delete:${e.message}');
//       rethrow;
//     }
//   }
// }

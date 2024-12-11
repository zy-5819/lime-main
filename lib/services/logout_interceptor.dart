// import 'dart:async';

// import 'package:async/async.dart';

// typedef OnLoggedOutDetected = void Function();

// class LogoutInterceptor implements ClientInterceptor {
//   /// 当登录信息失效时调用的回调。
//   final OnLoggedOutDetected? onLoggedOutDetected;

//   /// 传入值为空时使用默认的token。
//   final String? token;

//   final CallOptions? callOptions;

//   LogoutInterceptor({
//     this.onLoggedOutDetected,
//     this.token,
//     this.callOptions,
//   });

//   @override
//   ResponseStream<R> interceptStreaming<Q, R>(
//       ClientMethod<Q, R> method,
//       Stream<Q> requests,
//       CallOptions options,
//       ClientStreamingInvoker<Q, R> invoker) {
//     final response = DelegatingResponseStream<R>(invoker(method, requests,
//             (callOptions ?? CallOptions()).mergedWith(options)))
//         .handleError(
//       (Object error) {
//         Log.w('interceptUnary: ${method.path}');
//         onLoggedOutDetected?.call();
//       },
//       test: (error) =>
//           (error is GrpcError) && error.code == StatusCode.unauthenticated,
//     );
//     return response;
//   }

//   @override
//   ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
//       CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
//     final op = (callOptions ?? CallOptions()).mergedWith(options);
//     return DelegatingResponseFuture<R>(invoker(method, request, op)).catchError(
//       (Object e) {
//         Log.w('interceptUnary: ${method.path}');
//         onLoggedOutDetected?.call();
//         return;
//       },
//       test: (error) =>
//           (error is GrpcError) && error.code == StatusCode.unauthenticated,
//     );
//   }
// }

// class DelegatingResponseStream<R> extends DelegatingStream<R>
//     implements ResponseStream<R> {
//   Response responseDelegate;
//   DelegatingResponseStream.split(this.responseDelegate, Stream<R> delegate)
//       : super(delegate);

//   DelegatingResponseStream(ResponseStream<R> delegate)
//       : this.split(delegate, delegate);

//   @override
//   ResponseFuture<R> get single => DelegatingResponseFuture.split(
//         responseDelegate,
//         super.single,
//       );

//   @override
//   ResponseStream<R> handleError(Function onError,
//       {bool Function(dynamic error)? test}) {
//     return DelegatingResponseStream.split(
//       responseDelegate,
//       super.handleError(onError, test: test),
//     );
//   }

//   @override
//   Future<void> cancel() async {
//     await responseDelegate.cancel();
//   }

//   @override
//   Future<Map<String, String>> get headers => responseDelegate.headers;

//   @override
//   Future<Map<String, String>> get trailers => responseDelegate.trailers;
// }

// class DelegatingResponseFuture<R> extends DelegatingFuture<R>
//     implements ResponseFuture<R> {
//   Response responseDelegate;

//   DelegatingResponseFuture.split(
//     this.responseDelegate,
//     Future<R> futureDelegate,
//   ) : super(futureDelegate);

//   DelegatingResponseFuture(ResponseFuture<R> delegate)
//       : this.split(delegate, delegate);

//   @override
//   ResponseStream<R> asStream() =>
//       DelegatingResponseStream.split(responseDelegate, super.asStream());

//   @override
//   ResponseFuture<R> catchError(Function onError,
//           {bool Function(Object error)? test}) =>
//       DelegatingResponseFuture.split(
//           responseDelegate, super.catchError(onError, test: test));

//   @override
//   ResponseFuture<S> then<S>(FutureOr<S> Function(R p1) onValue,
//       {Function? onError}) {
//     return DelegatingResponseFuture.split(
//         responseDelegate, super.then(onValue, onError: onError));
//   }

//   @override
//   // ignore: strict_raw_type
//   ResponseFuture<R> whenComplete(FutureOr Function() action) {
//     return DelegatingResponseFuture.split(
//         responseDelegate, super.whenComplete(action));
//   }

//   @override
//   ResponseFuture<R> timeout(Duration timeLimit,
//       {FutureOr<R> Function()? onTimeout}) {
//     return DelegatingResponseFuture.split(
//         responseDelegate, super.timeout(timeLimit, onTimeout: onTimeout));
//   }

//   @override
//   Future<void> cancel() => responseDelegate.cancel();

//   @override
//   Future<Map<String, String>> get headers => responseDelegate.headers;

//   @override
//   Future<Map<String, String>> get trailers => responseDelegate.trailers;
// }

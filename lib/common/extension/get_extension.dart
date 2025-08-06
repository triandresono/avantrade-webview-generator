part of 'extension.dart';

extension GetExtension on GetInterface {
  Worker listen<T>({
    required RxInterface<Case<T>> listener,
    required WorkerCallback<Case<T>> callback,
  }) {
    StreamSubscription sub = listener.listen(
      (event) {
        callback(event);
      },
    );
    return Worker(sub.cancel, '[ever]');
  }
}

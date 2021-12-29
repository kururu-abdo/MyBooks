import 'dart:async';

class StreamProvider <T> {
  

      
final _data = StreamController<T>.broadcast();
Stream<T> get getData => _data.stream;
void Function(T) get   setData => _data.sink.add;

  void dispose() {
    _data.close();
  
  }




}


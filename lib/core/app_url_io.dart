import 'dart:io';

String getNativeApiUrl() {
  if (Platform.isAndroid) {
    return 'http://10.0.2.2:3001/api';
  } 
    return 'http://localhost:3001/api';
  
}

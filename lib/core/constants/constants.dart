// ignore_for_file: constant_identifier_names


const Environment environment = Environment.staging;
const int CONNECT_TIMEOUT = 15;
const int RECEIVE_TIMEOUT = 30;

const String CLIENT_ID = 'Client-Id';
const String CLIENT_KEY = 'Client-Key';
const String CLIENT_SECRET = 'Client-Secret';
const String CONTENT_TYPE_DEFAULT = 'application/json';

//Maps constant
const double ZOOM_LEVEL = 15;

//Fetch hotel constant
const int FETCH_PER_PAGE = 50;
const int FETCH_HOTEL_RADIUS = 5000;

enum Environment {
  staging,
  production;
}

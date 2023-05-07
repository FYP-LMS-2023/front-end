abstract class Constants {
  static const String baseURL = String.fromEnvironment(
    'BASE_URL',
    // defaultValue: 'https://smash-back-end-lms.vercel.app/',
    defaultValue: 'http://192.168.31.241:8080/',
  );
}

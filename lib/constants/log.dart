import 'package:logger/logger.dart';

class Log {
  static void e(
    dynamic message, [
    Exception? error,
    StackTrace? stackTrace,
  ]) {
    Logger(printer: PrettyPrinter(colors: true)).e(message, error, stackTrace);
  }

  static void d(
    dynamic message, [
    Exception? error,
    StackTrace? stackTrace,
  ]) {
    Logger(printer: PrettyPrinter(colors: true)).d(message, error, stackTrace);
  }

  static void i(
    dynamic message, [
    Exception? error,
    StackTrace? stackTrace,
  ]) {
    Logger(printer: PrettyPrinter(colors: true)).i(message, error, stackTrace);
  }

  static void v(
    dynamic message, [
    Exception? error,
    StackTrace? stackTrace,
  ]) {
    Logger(printer: PrettyPrinter(colors: true)).v(message, error, stackTrace);
  }

  static void w(
    dynamic message, [
    Exception? error,
    StackTrace? stackTrace,
  ]) {
    Logger(printer: PrettyPrinter(colors: true)).w(message, error, stackTrace);
  }
}

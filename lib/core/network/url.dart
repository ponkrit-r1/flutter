import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl =
    dotenv.env['BASE_API_URL'] ?? 'http://203.154.201.217:8000';

import 'dart:io';

String fixture(String name) =>
    File('test/authentication/fixtures/$name').readAsStringSync();

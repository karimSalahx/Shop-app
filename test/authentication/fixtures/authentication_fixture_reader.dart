import 'dart:io';

String authenticationFixture(String name) =>
    File('test/authentication/fixtures/$name').readAsStringSync();

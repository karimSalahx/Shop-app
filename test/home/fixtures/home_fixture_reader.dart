import 'dart:io';

String homeFixture(String name) =>
    File('test/home/fixtures/$name').readAsStringSync();

import 'package:flutter_test/flutter_test.dart';
import 'package:healthiee/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

void main() {
  int mst = 700;
  group('Testing App Performance', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Admin Test', (tester) async {
// Fresh Start
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Select Admin
      await tester.tap(find.byKey(Key('admin')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Admin Login
      await tester.tap(find.byKey(Key('login')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Admin Login Credentials
      await tester.enterText(
          find.byKey(Key('login_email')), 'iit2222010@iiita.ac.in');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('login_password')), 'jaimatadi');
      await Future.delayed(Duration(milliseconds: mst));

// Confirm Credentials
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 3));

// Add Medicine
      await tester.tap(find.byKey(Key('addMeds')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Medicine Details
      await tester.enterText(find.byKey(Key('name')), 'Rat Poison');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('quantity')), '1000');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('price')), '10000');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('date')), '7/4/21');
      await Future.delayed(Duration(milliseconds: mst));

// Add Confirm
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Scroll Check
      await binding.watchPerformance(() async {
        await tester.fling(
            find.byType(SingleChildScrollView), Offset(0, -300), 10000);
        await tester.pumpAndSettle();
        await Future.delayed(Duration(milliseconds: mst));
        await tester.fling(
            find.byType(SingleChildScrollView), Offset(0, 300), 10000);
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summary');

// Delete Medicine
      await tester.tap(find.byKey(Key('3')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 2));

// Back to Admin Dashboard
      await tester.pageBack();
      await Future.delayed(Duration(seconds: 2));

// Add Staff
      await tester.tap(find.byKey(Key('addStaff')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Staff Details
      await tester.enterText(find.byKey(Key('name')), 'Akash');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('dept')), 'ENT');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('dst')), '9:00');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('det')), '5:00');
      await Future.delayed(Duration(milliseconds: mst));

// Confirm Details
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Scroll Check
      await binding.watchPerformance(() async {
        await tester.fling(
            find.byType(SingleChildScrollView), Offset(0, -300), 10000);
        await tester.pumpAndSettle();
        await Future.delayed(Duration(milliseconds: mst));
        await tester.fling(
            find.byType(SingleChildScrollView), Offset(0, 300), 10000);
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summary');

// Delete Staff
      await tester.tap(find.byKey(Key('3')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 2));

// Back to DashBoard
      await tester.pageBack();
      await Future.delayed(Duration(seconds: 2));

// View Patients
      await tester.tap(find.byKey(Key('patientList')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Delete Patient
      // await tester.tap(find.byKey(Key('0')));
      // await tester.pumpAndSettle();
      // await Future.delayed(Duration(milliseconds: mst));

      // await tester.tap(find.text('Delete'));
      // await tester.pumpAndSettle();
      // await Future.delayed(Duration(seconds: 2));

// Scroll Test
      await binding.watchPerformance(() async {
        await tester.fling(find.byType(ListView), Offset(0, -300), 10000);
        await tester.pumpAndSettle();

        await tester.fling(find.byType(ListView), Offset(0, 300), 10000);
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summary');

// Back to Dashboard
      await tester.pageBack();
      await Future.delayed(Duration(seconds: 2));

// View Doctors
      await tester.tap(find.byKey(Key('doctorList')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Delete Doctor
      // await tester.tap(find.byKey(Key('0')));
      // await tester.pumpAndSettle();
      // await Future.delayed(Duration(milliseconds: mst));

      // await tester.tap(find.text('Delete'));
      // await tester.pumpAndSettle();
      // await Future.delayed(Duration(seconds: 2));

// Scroll Test
      await binding.watchPerformance(() async {
        await tester.fling(find.byType(ListView), Offset(0, -300), 10000);
        await tester.pumpAndSettle();

        await tester.fling(find.byType(ListView), Offset(0, 300), 10000);
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summary');

// Back to Dashboard
      await tester.pageBack();
      await Future.delayed(Duration(seconds: 2));

// Update Profile
      await tester.tap(find.byKey(Key('updateProfile')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

      await tester.enterText(find.byType(TextField), 'Test Name');
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Add Donor
      await tester.tap(find.byKey(Key('addDonor')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Donor Details
      await tester.enterText(find.byKey(Key('name')), 'Karan');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('organ')), 'Kidney');
      await Future.delayed(Duration(milliseconds: mst));

// Confirm Details
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Scroll Check
      await binding.watchPerformance(() async {
        await tester.fling(
            find.byType(SingleChildScrollView), Offset(0, -300), 10000);
        await tester.pumpAndSettle();
        await Future.delayed(Duration(milliseconds: mst));
        await tester.fling(
            find.byType(SingleChildScrollView), Offset(0, 300), 10000);
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summary');

// Delete Donor
      await tester.tap(find.byKey(Key('3')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 1));

// Back to DashBoard
      await tester.pageBack();
      await Future.delayed(Duration(seconds: 2));

// Admin SignOut
      await tester.tap(find.byKey(Key('signOut')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));
      await tester.pageBack();
      await Future.delayed(Duration(milliseconds: mst));
    });

    testWidgets('Doctor Test', (tester) async {
// Fresh Start
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Select Doctor
      await tester.tap(find.byKey(Key('doctor')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Login
      await tester.tap(find.byKey(Key('login')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Enter Credentials
      await tester.enterText(
          find.byKey(Key('login_email')), 'iit3333010@iiita.ac.in');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('login_password')), 'jaimatadi');

// Confirm Login
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 4));

// View Upcomming Appointments
      await tester.tap(find.byKey(Key('appointments')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Back to Dashboard
      await tester.pageBack();
      await Future.delayed(Duration(milliseconds: mst));

// Update Profile
      await tester.tap(find.byKey(Key('updateProfile')));
      await tester.pumpAndSettle();

// Doctor Details
      await tester.enterText(find.byKey(Key('name')), 'Test Doctor');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('licno')), '123456');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('dept')), 'Neurosurgeon');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('qual')), '12th Pass');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('dst')), '9:00');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('det')), '5:00');
      await Future.delayed(Duration(milliseconds: mst));

// Confirm Details
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 2));

// Doctor SignOut
      await tester.tap(find.byKey(const Key('signOut')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));
      await tester.pageBack();
      await Future.delayed(Duration(milliseconds: mst));
    });

    testWidgets('Patient Test', (tester) async {
// Fresh Start
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Select Doctor
      await tester.tap(find.byKey(Key('patient')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Login
      await tester.tap(find.byKey(Key('login')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));

// Enter Credentials
      await tester.enterText(
          find.byKey(Key('login_email')), 'iit4444010@iiita.ac.in');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('login_password')), 'jaimatadi');

// Confirm Login
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 4));

// View Upcomming Appointments
      await tester.tap(find.byKey(Key('availableDoctors')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 2));

// Back to Dashboard
      await tester.pageBack();
      await Future.delayed(Duration(milliseconds: mst));

// Update Profile
      await tester.tap(find.byKey(Key('updateProfile')));
      await tester.pumpAndSettle();

// Patient Details
      await tester.enterText(find.byKey(Key('name')), 'Test Patient');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('age')), '21');
      await Future.delayed(Duration(milliseconds: mst));
      await tester.enterText(find.byKey(Key('gender')), 'Male');
      await Future.delayed(Duration(milliseconds: mst));

// Confirm Details
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 2));

// Patient SignOut
      await tester.tap(find.byKey(const Key('signOut')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: mst));
      await tester.pageBack();
      await Future.delayed(Duration(milliseconds: mst));
    });
  });
}

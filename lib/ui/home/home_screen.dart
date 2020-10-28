import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/custom/custom_inherited_widget.dart';
import 'package:flutter_app/ui/auth/login/login_screen.dart';
import 'package:flutter_app/ui/snackbar/snackbar_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class HomeScreen extends StatefulWidget {
  final Widget child;

  HomeScreen({this.child});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _today = DateTime.now();
  int _counter = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 4
              ),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SnackBarScreen()));
                },
                child: Icon(
                    Icons.message
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 4
              ),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () => _decrementCounter(),
                child: Icon(
                    Icons.remove
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 4
              ),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () => _incrementCounter(),
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 4
              ),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () => {},
                child: Icon(
                    Icons.update
                ),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          title: Text(
              'Home'
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: ()  async {
              final User user = _auth.currentUser;
              if (user != null) {
                await _auth.signOut();
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(user.uid + ' has successfully signed out.'),
                ));
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            },
            child: Icon(
              Icons.exit_to_app,
            ),
          ),
          flexibleSpace: null,
          bottom: null,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: GestureDetector(
                onTap: () => _selectDate(context),
                child: Icon(
                  Icons.date_range,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 4
              ),
              child: GestureDetector(
                onTap: () => print('Redirect'),
                child: Icon(
                  Icons.perm_contact_calendar,
                ),
              ),
            ),
          ],
        ),
        body: CustomInheritedWidget(
          widget: widget.child,
          data: _counter,
          date: '${_today.toLocal()}'.split(' ')[0],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch(theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return _buildMaterialDatePicker(context);
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return _buildCupertinoDatePicker(context);
        break;
      default:
        break;
    }
  }

  void _buildMaterialDatePicker(BuildContext context)  async {
    final DateTime selectedDate = await showDatePicker(
      //Choose the picker interface or input interface
      // param : input | calendar
        initialEntryMode: DatePickerEntryMode.calendar,
        /// Select choose which one first
        /// param: year | day
        initialDatePickerMode: DatePickerMode.year,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2021),
        helpText: 'Choose the date',
        cancelText: 'Dismiss',
        confirmText: 'Confirm',
        selectableDayPredicate: _decideWhichDayToEnable
    );

    if(selectedDate != null && selectedDate != _today) {
      setState(() {
        _today = selectedDate;
      });
    }
  }

  void _buildCupertinoDatePicker(BuildContext context)  async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumYear: 1900,
              maximumYear: 2021,
              use24hFormat: true,
              onDateTimeChanged: (selectedDate) {
                if(selectedDate != null && selectedDate != _today) {
                  setState(() {
                    _today = selectedDate;
                  });
                }
              },
            ),
          );
        }
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      if(_counter < 0) {
        _counter = 0;
      }
    });
  }

  /// This decides which day will be enabled
  /// This will be called every time while displaying day in calender.
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 2))) &&
        day.isBefore(DateTime.now().add(Duration(days: 2))))) {
      return true;
    }
    return false;
  }
}

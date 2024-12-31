import 'package:calm/module/auth/auth_bloc/auth_bloc.dart';
import 'package:calm/module/auth/login_screen.dart';
import 'package:calm/module/home/home_bloc/home_bloc.dart';
import 'package:calm/module/home/home_bloc/home_event.dart';
import 'package:calm/module/home/home_bloc/home_state.dart';
import 'package:calm/utils/extentions.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(FetchUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.pushReplacementNamed(
            context,
            LoginScreen.route,
          );
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text('Calm'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  context.read<AuthBloc>().add(LogoutRequested());
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Column(
          children: [
            StreamBuilder<Map<String, dynamic>?>(
              stream: context.read<HomeBloc>().userStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                return EasyDateTimeLinePicker.itemBuilder(
                  focusedDate: DateTime.now(),
                  currentDate: DateTime.now(),
                  firstDate: DateTime(2000, 1, 1),
                  lastDate: DateTime.now().add(10.years),
                  onDateChange: (date) {
                    if (date.difference(DateTime.now()).inMinutes > 0) {
                      return;
                    }
                    if (snapshot.data?['streak'].contains(date.toString()) ==
                        false) {
                      context.read<HomeBloc>().add(ClickDate(date, true));
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (context) {
                        return _Dialog(date: date);
                      },
                    );
                  },
                  itemBuilder:
                      (context, date, isSelected, isDisabled, isToday, onTap) {
                    bool isStreak =
                        (snapshot.data?['streak'].contains(date.toString()) ==
                            true);
                    Color getBorderedColor() {
                      if (isStreak) {
                        return Colors.teal;
                      } else {
                        return Colors.grey;
                      }
                    }

                    // Background color
                    Color getBackgroundColor() {
                      if (isStreak) {
                        return Colors.teal;
                      } else {
                        return Colors.white;
                      }
                    }

                    // Text color
                    Color getTextColor() {
                      if (isStreak) {
                        return Colors.white;
                      } else {
                        return Colors.black;
                      }
                    }

                    return GestureDetector(
                      onTap: onTap,
                      child: Container(
                        decoration: BoxDecoration(
                          color: getBackgroundColor(),
                          border: Border.all(
                            color: getBorderedColor(),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              date.month.month,
                              style: TextStyle(
                                color: getTextColor(),
                              ),
                            ),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                color: getTextColor(),
                              ),
                            ),
                            Text(
                              date.weekday.weekday,
                              style: TextStyle(
                                color: getTextColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemExtent: 70,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Dialog extends StatefulWidget {
  final DateTime date;

  const _Dialog({required this.date});

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AlertDialog(
          title: Text('Date Selected'),
          content: Text(widget.date.toString()),
          actions: [
            TextButton.icon(
              style: TextButton.styleFrom(
                  iconColor: Theme.of(context).colorScheme.error),
              onPressed: () {
                context.read<HomeBloc>().add(ClickDate(widget.date, false));
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete),
              label: Text(
                'Remove',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.check),
              label: Text('Keep'),
            ),
          ],
        );
      },
    );
  }
}

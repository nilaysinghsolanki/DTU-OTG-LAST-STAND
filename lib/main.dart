import 'package:date_time_picker/date_time_picker.dart';
import 'package:nilay_dtuotg_2/Screens/patchProfileData.dart';
import 'package:nilay_dtuotg_2/Screens/patchProfileData.dart';
import 'package:nilay_dtuotg_2/Screens/testingScreen.dart';
import 'package:nilay_dtuotg_2/models/lecture.dart';
import './Screens/tabsScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './Screens/enterDetailsScreen.dart';
import 'package:flutter/rendering.dart';
import './Screens/addEventScreen.dart';
import './Screens/invite_screen.dart';
import 'package:flutter/services.dart';
import './Screens/eventsDetailScreen.dart';
import 'package:nilay_dtuotg_2/Screens/authScreen.dart';
import 'package:nilay_dtuotg_2/Screens/homeTab.dart';
import 'package:nilay_dtuotg_2/Screens/loadingScreen.dart';
import 'package:nilay_dtuotg_2/Screens/scheduleTab.dart';
import 'package:nilay_dtuotg_2/plus_controller.dart';
import 'package:path/path.dart' as path;
import './models/events.dart';
import './Screens/profileDetailsScreen.dart';
import 'package:provider/provider.dart';
import './providers/info_provider.dart';
import './providers/server_connection_functions.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:progress_indicators/progress_indicators.dart';

import './models/screenArguments.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'Screens/eventsdetailsDESIGN.dart';

void main() => runApp(MyApp());
var event_name;
var event_description;
List<Widget> Events = [];
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
/////////////////////COLORS
Color newcolor = Colors.transparent;
TextStyle dark_theme_text_style = TextStyle(color: Colors.white);
Color tilecolor = Colors.white;

TextStyle general_text_style = TextStyle(color: Colors.brown);
////////////////////////////PAGESNAVIGATION
bool _events_pressed = false;
bool _adding_to_app_pressed = false;

class MyApp extends StatelessWidget {
  PlusAnimation _plusAnimation;
  static const double width = 500;
  static const double height = 200;

  Artboard _riveArtboard;
  bool _events_pressed = false;
  bool _adding_to_app_pressed = false;
  GlobalKey materialNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context1) {
    return MultiProvider(
      providers: [
        Provider.value(
            value: MaterialNavigatorKey(
                materialNavigatorKey: materialNavigatorKey)),
        ChangeNotifierProvider.value(value: TimeTableData()),
        Provider.value(value: SCF(Server_Connection_Functions())),
        ChangeNotifierProvider.value(value: TabsScreenContext()),
        ChangeNotifierProvider.value(value: EventsImages()),
        ChangeNotifierProvider.value(value: OwnerIdData()),
        ChangeNotifierProvider.value(value: AddEventScreenData()),
        ChangeNotifierProvider.value(value: Event()),
        ChangeNotifierProvider.value(value: EventsData()),
        ChangeNotifierProvider.value(value: UsernameData()),
        ChangeNotifierProvider.value(value: ProfileData()),
        ChangeNotifierProvider.value(value: AccessTokenData()),
        ChangeNotifierProvider.value(value: EmailAndUsernameData())
      ],
      child: MaterialApp(
        navigatorKey: materialNavigatorKey, // GlobalKey()

        routes: {
          TestingScreen.routeName: (context) => TestingScreen(),
          '/ProfileDetailsScreen': (context) => ProfileDetailsScreem(),
          'patchProfileScreen': (context) => PatchProfileScreen(),
          'inviteScreen': (context) => InviteScreen(),
          'AddEventScreen': (context) => AddEventScreen(),
          '/EventsDetailScreen': (context) => EventsDetailScreen(
                key: _scaffoldKey,
              ),
          '/AuthScreen': (context) => AuthScreen(),
          '/EnterDetailsScreen': (context) => EnterDetailsScreen(),
          '/TabsScreen': (context) => TabsScreen(),
          '/schedule': (context1) => ScheduleTab(),
          '/homeScreen': (context1) => HomeScreen(),
          '/loading': (context1) => LoadingScreen(),
          '/eventdetailsdesign': (context1) => EventDetailsDesign(),
        },
        title: 'Rive Flutter Demo',
        home: LoadingScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> ScatteredListtiles = [
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Builder(
        builder: (_) => ListTile(
          onTap: () async {
            var result = await Provider.of<AccessTokenData>(_, listen: false)
                .deleteAccessToken();
            print('./////logout result $result');
            if (result) Navigator.of(_).pushNamed('/AuthScreen');
          },
          leading: CircleAvatar(
            child: Icon(Icons.logout, color: Colors.brown),
            backgroundColor: Color(0xffF2EFE4),
          ),
          title: Text(
            "log out",
            style: general_text_style,
          ),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: newcolor,
      ),
      child: Builder(
        builder: (_) => ListTile(
          onTap: () async {
            print('.patch profile..');
            Navigator.of(_).pushNamed('patchProfileScreen');
          },
          leading: CircleAvatar(
            backgroundColor: Colors.brown,
          ),
          title: Text(
            "edit profile",
            style: TextStyle(
                color: Colors.brown,
                backgroundColor: Color(0xffF2EFE4),
                fontSize: 20),
          ),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: newcolor),
      child: Builder(
        builder: (_) => ListTile(
          onTap: () {
            Navigator.of(_).pushNamed('/schedule');
          },
          leading: CircleAvatar(
            child: Icon(Icons.calendar_today, color: Colors.brown),
            backgroundColor: Color(0xffF2EFE4),
          ),
          title: Text(
            "Schedule",
            style: TextStyle(
                color: Colors.brown,
                backgroundColor: Color(0xffF2EFE4),
                fontSize: 20),
          ),
        ),
      ),
    ),
    Builder(
      builder: (_) => ListTile(
        onTap: () {
          Navigator.of(_).pushNamed('inviteScreen');
        },
        leading: CircleAvatar(
          child: Icon(Icons.face_retouching_natural, color: Colors.brown),
          backgroundColor: Color(0xffF2EFE4),
        ),
        title: Text(
          "invite friends",
          style: TextStyle(
              color: Colors.brown,
              backgroundColor: Color(0xffF2EFE4),
              fontSize: 20),
        ),
      ),
    ),
    ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.motorcycle_rounded, color: Colors.brown),
        backgroundColor: Color(0xffF2EFE4),
      ),
      title: Text(
        "Catch-A-Ride",
        style: TextStyle(
            color: Colors.brown,
            backgroundColor: Color(0xffF2EFE4),
            fontSize: 20),
      ),
    ),
    ListTile(
      tileColor: newcolor,
      leading: CircleAvatar(
        child: Icon(Icons.report, color: Colors.brown),
        backgroundColor: Color(0xffF2EFE4),
      ),
      title: Text(
        "Emergency",
        style: TextStyle(
            color: Colors.brown,
            backgroundColor: Color(0xffF2EFE4),
            fontSize: 20),
      ),
    ),
    ListTile(
      tileColor: newcolor,
      leading: CircleAvatar(
        child: Icon(Icons.work, color: Colors.brown),
        backgroundColor: Color(0xffF2EFE4),
      ),
      title: Text(
        "Active Projects",
        style: TextStyle(
            color: Colors.brown,
            backgroundColor: Color(0xffF2EFE4),
            fontSize: 20),
      ),
    ),
    Container(
      color: newcolor,
      alignment: Alignment.bottomCenter,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
        ),
        title: Text("I have a B-Plan , for selling DTU",
            style: general_text_style),
        subtitle:
            Text("-Every Entrepreneur at E-cell", style: general_text_style),
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Assets/newframe.png"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: ListView(
                children: ScatteredListtiles,
              ),
            ),
          ), // Populate the Drawer in the next step.
        ),
        body: MyRiveAnimation(),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////HOMEPAGE
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool initialized = false;
  PlusAnimation _plusAnimation;

  Color newcolor = Colors.transparent;

  Artboard _riveArtboard;
  List<Event> evesForSchedule = [];
  List<Event> sheduled = [];
  double width = 500;
  int weekDayIndex = 1;

  double height = 200;
  List<Event> sheduledToday = [];

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('Assets/BT_animation.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;

        // Add a controller to play back a known animation on the main/default
        // artboard. We store a reference to it so we can toggle playback.

        setState(() => _riveArtboard = artboard);
        _riveArtboard
            .addController(_plusAnimation = PlusAnimation('Animation 1'));
        _plusAnimation.instance.animation.loop = Loop.loop;
      },
    );
  }

  var scf;
  bool eventsInitialized = false;

  void didChangeDependencies() async {
    print('home init');
    if (!eventsInitialized) {
      if (!Provider.of<EventsData>(context, listen: false)
          .getOnceDownloaded()) {
        scf = Provider.of<SCF>(context, listen: false).get();
        await scf.fetchListOfEvents(context);
        Provider.of<EventsData>(context, listen: false).setOnceDownloaded(true);

        // Provider.of<EventsImages>(context, listen: false).fetchList(
        //     Provider.of<EventsData>(context, listen: false).getEvents(),
        //     Provider.of<AccessTokenData>(context, listen: false)
        //         .getAccessToken());
      }
      sheduledToday =
          Provider.of<EventsData>(context, listen: false).getEvents();

      setState(() {
        eventsInitialized = true;
      });
    }

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool imgFetched =
        Provider.of<EventsImages>(context, listen: true).imgFetched;
    List<Widget> ScatteredListtiles = [
      Column(
        children: [
          SingleChildScrollView(
            child: !eventsInitialized
                ? Expanded(
                    child: Rive(
                      artboard: _riveArtboard,
                      alignment: Alignment.bottomCenter,
                      useArtboardSize: true,
                    ),
                  )
                : ListTile(
                    trailing: Text("Events", style: general_text_style),
                  ),
          ),
        ],
      ),
<<<<<<< HEAD
      (DateTime.now().hour >= 8 && DateTime.now().hour <= 17)
          ? TimeTableHomeScreenListTile()
          : ListTile(),
=======
      DateTime.now().hour <= 17 && DateTime.now().hour>=8 ? TimeTableHomeScreenListTile() : ListTile(),
>>>>>>> 6650853b09b3e643da96d5c3f1a27cb9d400b401
      imgFetched
          ? Center(
              child: Expanded(
                child: CarouselSlider.builder(
<<<<<<< HEAD
                    itemCount: sheduledToday.length,
=======


                    itemCount: Provider.of<EventsData>(context, listen: false)
                        .events
                        .length,
>>>>>>> 6650853b09b3e643da96d5c3f1a27cb9d400b401
                    itemBuilder: (context, itemIndex, pageViewIndex) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/eventdetailsdesign',
                              arguments: ScreenArguments(
<<<<<<< HEAD
                                  id: sheduledToday[itemIndex].id,
                                  scf: scf,
                                  context: context));
                        },
                        child: Image.network(
                          sheduled[itemIndex]
                              .eventImageUri
                              .toString()
                              .replaceFirst("http", 'https'),
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            // Appropriate logging or analytics, e.g.
                            // myAnalytics.recordError(
                            //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                            //   exception,
                            //   stackTrace,
                            // );
                            return FittedBox(
                              child: Card(
                                color: Colors.cyan,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        size: 55,
                                      ),
                                      Text('😢 Can\'t load image ',
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w900,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: 'Open Sans',
                                              fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          loadingBuilder: (BuildContext context,
                              Widget decoration,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return decoration;
                            return Center(
                              child: FittedBox(
                                child: Row(
                                  children: [
                                    FadingText('image loading...'),
                                    CircularProgressIndicator(
                                      backgroundColor: Colors.brown,
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
=======
                                  id: Provider.of<EventsData>(context,
                                          listen: false)
                                      .events[itemIndex].id,
                                  scf: scf,
                                  context: context));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                              image: NetworkImage(
                                  Provider.of<EventsData>(context, listen: false)
                                      .events[itemIndex].event_image
                                      .toString()
                              )
                            )
                          ),

>>>>>>> 6650853b09b3e643da96d5c3f1a27cb9d400b401
                        ),
                      );
                    },
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: false,
                        height: 500,
                        viewportFraction: 1)),
              ),
            )
          : ListTile(
              trailing: Text("Projects", style: general_text_style),
            ),
      ListTile(
        title: Text("Internship/Job Opportunities", style: general_text_style),
        trailing: Icon(Icons.work_outline),
      ),
    ];

    return Flexible(
      child: StaggeredGridView.countBuilder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        crossAxisCount: 4,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) =>
            AnimationConfiguration.staggeredGrid(
          position: index,
          columnCount: 0,
          duration: const Duration(milliseconds: 500),
          child: SlideAnimation(
            horizontalOffset: 100.0,
            child: FlipAnimation(
              flipAxis: FlipAxis.y,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: Center(child: ScatteredListtiles[index]),
              ),
            ),
          ),
        ),
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(2, index.isEven ? 4 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}

class TimeTableHomeScreenListTile extends StatefulWidget {
  const TimeTableHomeScreenListTile({
    Key key,
  }) : super(key: key);

  @override
  _TimeTableHomeScreenListTileState createState() =>
      _TimeTableHomeScreenListTileState();
}

class _TimeTableHomeScreenListTileState
    extends State<TimeTableHomeScreenListTile> {
  bool initialized = false;

  int weekDayIndex = 1;
  List<Lecture> lectures = [];
  Lecture _lecture;
  DateTime _selectedDay = DateTime.now();
  @override
  void didChangeDependencies() async {
    if (!initialized) {
      weekDayIndex = DateTime.now().weekday > 5 ? 5 : DateTime.now().weekday;
      await Provider.of<TimeTableData>(context, listen: false)
          .fetchAndSetData(context);
      lectures =
          Provider.of<TimeTableData>(context, listen: false).get(weekDayIndex);
      if (lectures.isNotEmpty) {
        lectures.forEach((element) {
          int hour = element.time.hour;
          int length = element.length;
          bool happeningNow = false;

          if (element.time.hour == TimeOfDay.now().hour) {
            happeningNow = true;
          } else {
            if ((element.time.hour < TimeOfDay.now().hour) &&
                ((element.time.hour + element.length) > TimeOfDay.now().hour)) {
              happeningNow = true;
            }
          }
          if (happeningNow) {
            _lecture = element;
          }
        });
      }
      setState(() {
        initialized = true;
      });
    }

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    //_selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    int lectureStart =
        _lecture.time.hour > 12 ? _lecture.time.hour - 12 : _lecture.time.hour;
    int lectureEnd =
        lectureStart == 12 ? _lecture.length : lectureStart + _lecture.length;
    return initialized
        ? lectures.isNotEmpty
            ? _lecture.free
                ? GlowingProgressIndicator(child: Text('free time'))
                : ListTile(
                    title: Text(_lecture.name, style: general_text_style),
                    subtitle: Text(
                        lectureStart.toString() +
                            '-' +
                            '${lectureEnd.toString()}',
                        style: general_text_style),
                    trailing: GlowingProgressIndicator(
                      child: Icon(Icons.schedule),
                    ),
                    onTap: () {})
            : Text('No lectures')
        : Center(
            child: FadingText('Loading...'),
          );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////ADDEVENTSPAGE
class AddEventsPage extends StatefulWidget {
  const AddEventsPage({Key key}) : super(key: key);

  @override
  _AddEventsPageState createState() => _AddEventsPageState();
}

class _AddEventsPageState extends State<AddEventsPage> {
  var event_description_channged;
  var event_name_changed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'new Event',
          style: TextStyle(color: Colors.brown, fontSize: 30),
        ),
        backgroundColor: newcolor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: newcolor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                color: newcolor,
                child: TextField(
                    style: TextStyle(color: Colors.brown, fontSize: 30),
                    cursorColor: Colors.brown,
                    cursorHeight: 35,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 4),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 3),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: "Name of the event",
                        helperText: 'Keep it short, this is just a beta.',
                        hintStyle: TextStyle(color: Colors.black26),
                        labelStyle:
                            TextStyle(color: Colors.brown, fontSize: 30),
                        hoverColor: Colors.brown,
                        fillColor: newcolor,
                        focusColor: Colors.white),
                    onChanged: (NameOfEvent) {
                      print("The value entered is : $NameOfEvent");
                      event_name_changed = "$NameOfEvent";
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                color: newcolor,
                child: TextField(
                    style: TextStyle(color: Colors.brown, fontSize: 30),
                    cursorColor: Colors.brown,
                    cursorHeight: 35,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 4),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 3),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: "Description",
                        helperText: 'Keep it short, this is just a beta.',
                        hintStyle: TextStyle(color: Colors.black26),
                        labelStyle:
                            TextStyle(color: Colors.brown, fontSize: 30),
                        hoverColor: Colors.brown,
                        fillColor: newcolor,
                        focusColor: Colors.white),
                    onChanged: (DescriptionOfEvent) {
                      print("The value entered is : $DescriptionOfEvent");
                      event_description_channged = "$DescriptionOfEvent";
                    }),
              ),
            ),
            FloatingActionButton(
                backgroundColor: Colors.brown,
                onPressed: () {
                  event_description = event_description_channged;
                  event_name = event_name_changed;

                  Events.add(Card(
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.star,
                        color: Colors.purple,
                      ),
                      title: Text(event_name),
                      subtitle: Text(event_description),
                    ),
                  ));
                }),
          ],
        ),
      ),
    );
  }
}

//////////////////////////ADDTOSCHEDULEPAGE
class AddToSchedulePage extends StatefulWidget {
  const AddToSchedulePage({Key key}) : super(key: key);

  @override
  _AddToSchedulePageState createState() => _AddToSchedulePageState();
}

class _AddToSchedulePageState extends State<AddToSchedulePage> {
  var event_description_channged;
  var event_name_changed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2EFE4),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Add Event Details",
          style: TextStyle(color: Colors.brown),
        ),
        titleTextStyle: TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Assets/newframe.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: TextField(
                        style: TextStyle(color: Colors.brown, fontSize: 30),
                        cursorColor: Colors.brown,
                        cursorHeight: 35,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 4),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 3),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: "Name of the event",
                            helperText: 'Keep it short, this is just a beta.',
                            hintStyle: TextStyle(color: Colors.black26),
                            labelStyle:
                                TextStyle(color: Colors.brown, fontSize: 30),
                            hoverColor: Colors.brown,
                            fillColor: newcolor,
                            focusColor: Colors.white),
                        onChanged: (NameOfEvent) {
                          print("The value entered is : $NameOfEvent");
                          event_name_changed = "$NameOfEvent";
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0,
                    color: newcolor,
                    child: TextField(
                        style: TextStyle(color: Colors.brown, fontSize: 30),
                        cursorColor: Colors.brown,
                        cursorHeight: 35,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 4),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 3),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: "Description",
                            helperText: 'Keep it short, this is just a beta.',
                            hintStyle: TextStyle(color: Colors.black26),
                            labelStyle:
                                TextStyle(color: Colors.brown, fontSize: 30),
                            hoverColor: Colors.brown,
                            fillColor: newcolor,
                            focusColor: Colors.white),
                        onChanged: (DescriptionOfEvent) {
                          print("The value entered is : $DescriptionOfEvent");
                          event_description_channged = "$DescriptionOfEvent";
                        }),
                  ),
                ),
                FloatingActionButton(
                    backgroundColor: Colors.brown,
                    onPressed: () {
                      event_description = event_description_channged;
                      event_name = event_name_changed;

                      Events.add(Card(
                        child: ListTile(
                          leading: Icon(
                            FontAwesomeIcons.star,
                            color: Colors.purple,
                          ),
                          title: Text(event_name),
                          subtitle: Text(event_description),
                        ),
                      ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////ADDPROJECTPAGE
class AddProjectPage extends StatefulWidget {
  const AddProjectPage({Key key}) : super(key: key);

  @override
  _AddProjectPageState createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  var event_description_channged;
  var event_name_changed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: newcolor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: newcolor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                color: newcolor,
                child: TextField(
                    style: TextStyle(color: Colors.brown, fontSize: 30),
                    cursorColor: Colors.brown,
                    cursorHeight: 35,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 4),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 3),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: "Name of the event",
                        helperText: 'Keep it short, this is just a beta.',
                        hintStyle: TextStyle(color: Colors.black26),
                        labelStyle:
                            TextStyle(color: Colors.brown, fontSize: 30),
                        hoverColor: Colors.brown,
                        fillColor: newcolor,
                        focusColor: Colors.white),
                    onChanged: (NameOfEvent) {
                      print("The value entered is : $NameOfEvent");
                      event_name_changed = "$NameOfEvent";
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                color: newcolor,
                child: TextField(
                    style: TextStyle(color: Colors.brown, fontSize: 30),
                    cursorColor: Colors.brown,
                    cursorHeight: 35,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 4),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 3),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: "Description",
                        helperText: 'Keep it short, this is just a beta.',
                        hintStyle: TextStyle(color: Colors.black26),
                        labelStyle:
                            TextStyle(color: Colors.brown, fontSize: 30),
                        hoverColor: Colors.brown,
                        fillColor: newcolor,
                        focusColor: Colors.white),
                    onChanged: (DescriptionOfEvent) {
                      print("The value entered is : $DescriptionOfEvent");
                      event_description_channged = "$DescriptionOfEvent";
                    }),
              ),
            ),
            FloatingActionButton(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                backgroundColor: Colors.brown,
                onPressed: () {
                  event_description = event_description_channged;
                  event_name = event_name_changed;

                  if (event_description_channged == null ||
                      event_name_changed == null) {
                    Events.add(Card(
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.star,
                          color: Colors.purple,
                        ),
                        title: Text(event_name),
                        subtitle: Text(event_description),
                      ),
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////EVENTSPAGE

class EventsPage extends StatefulWidget {
  const EventsPage({Key key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        color: newcolor,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: Events.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 350),
              child: SlideAnimation(
                verticalOffset: 100.0,
                child: FlipAnimation(child: Events[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

////////////////////CUSTOMPAGE
class CustomPage extends StatefulWidget {
  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  var event_description_channged;
  var event_name_changed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Add Event',
          style: TextStyle(color: Colors.brown, fontSize: 30),
        ),
        backgroundColor: newcolor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                color: newcolor,
                child: TextField(
                    style: TextStyle(color: Colors.brown, fontSize: 30),
                    cursorColor: Colors.brown,
                    cursorHeight: 35,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 4),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 3),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: "Name of the event",
                        helperText: 'Keep it short, this is just a beta.',
                        hintStyle: TextStyle(color: Colors.black26),
                        labelStyle:
                            TextStyle(color: Colors.brown, fontSize: 30),
                        hoverColor: Colors.brown,
                        fillColor: newcolor,
                        focusColor: Colors.white),
                    onChanged: (NameOfEvent) {
                      print("The value entered is : $NameOfEvent");
                      setState(() {
                        event_name_changed = "$NameOfEvent";
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                color: newcolor,
                child: TextField(
                    style: TextStyle(color: Colors.brown, fontSize: 30),
                    cursorColor: Colors.brown,
                    cursorHeight: 35,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 4),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 3),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: "Description",
                        helperText: 'Keep it short, this is just a beta.',
                        hintStyle: TextStyle(color: Colors.black26),
                        labelStyle:
                            TextStyle(color: Colors.brown, fontSize: 30),
                        hoverColor: Colors.brown,
                        fillColor: newcolor,
                        focusColor: Colors.white),
                    onChanged: (DescriptionOfEvent) {
                      print("The value entered is : $DescriptionOfEvent");
                      setState(() {
                        event_description_channged = "$DescriptionOfEvent";
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 22),
              child: FloatingActionButton.extended(
                  label: Text(
                    'save',
                    style: TextStyle(
                        color: (event_name_changed == null ||
                                event_description_channged == null)
                            ? Colors.brown[200]
                            : Colors.white,
                        fontSize: 20),
                  ),
                  icon: Icon(
                    Icons.check,
                    color: (event_name_changed == null ||
                            event_description_channged == null)
                        ? Colors.brown[200]
                        : Colors.white,
                  ),
                  backgroundColor: Colors.brown,
                  onPressed: () {
                    event_description = event_description_channged;
                    event_name = event_name_changed;
                    if (event_name_changed != null &&
                        event_description_channged != null) {
                      Events.add(Card(
                        child: ListTile(
                          leading: Icon(
                            FontAwesomeIcons.star,
                            color: Colors.purple,
                          ),
                          title: Text(event_name),
                          subtitle: Text(event_description),
                        ),
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('event saved'),
                        backgroundColor: Colors.brown,
                      ));
                    }

                    if (event_name_changed != null &&
                        event_description_channged != null)
                      Navigator.of(context).pop();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////ADDINGPAGE
class AddingPage extends StatefulWidget {
  @override
  _AddingPageState createState() => _AddingPageState();
}

class _AddingPageState extends State<AddingPage> {
  PlusAnimation _plusAnimation;
  double width = 500;
  double height = 200;
  Color newcolor = Colors.transparent;

  Artboard _riveArtboard;
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('Assets/appbar.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;

        // Add a controller to play back a known animation on the main/default
        // artboard. We store a reference to it so we can toggle playback.

        setState(() => _riveArtboard = artboard);
        _riveArtboard.addController(_plusAnimation = PlusAnimation('Idle'));
      },
    );
  }

  void _events_page_function(bool _eventspressed) {
    if (_adding_to_app_pressed == false) {
      if (_events_pressed == true) {
        newcolor = Color(0xfff2efe4);

        setState(() {
          _events_pressed = _eventspressed;
        });
      } else
        newcolor = Color(0xfff2efe4);
    }
  }

  void _adding_page_open_function(bool _adding_page_active) {
    if (_plusAnimation == null) {
      _riveArtboard.addController(
        _plusAnimation = PlusAnimation('Plus'),
      );
    }

    if (_adding_page_active == true) {
      _plusAnimation.start();
    } else {
      _plusAnimation.reverse();
    }

    setState(() {
      if (_adding_page_active == true) {
        _plusAnimation.isActive = false;
        _riveArtboard.addController(_plusAnimation = PlusAnimation('Plus'));

        print("_adding_page_active");
      }
      _adding_to_app_pressed = _adding_page_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Icon> myicons = [
      Icon(
        FontAwesomeIcons.star,
        color: Colors.purple,
      ),
      Icon(
        Icons.schedule_outlined,
        color: Colors.black,
      ),
      Icon(
        FontAwesomeIcons.tasks,
        color: Colors.greenAccent,
      ),
    ];
    List<Text> titlelist = [
      Text("Add to Events", style: general_text_style),
      Text("Add to Schedule", style: general_text_style),
      Text("Share details about Projects", style: general_text_style),
    ];
    List<Text> subtitlelist = [
      Text(
          "Update via this feature to let people know the details of any event"),
      Text(
          "Update your personal schedule with new tasks assigned like self study,sports.etc"),
      Text(
          "Update via this feature to let people know the details of any projects in DTU, looking for Volunteers"),
    ];
    List<Card> AddingButtons = [
      Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              //  Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => CustomPage()));
              Navigator.of(context).pushNamed('AddEventScreen', arguments: 1);
            },
            leading: Icon(
              FontAwesomeIcons.star,
              color: Colors.purple,
            ),
            title: Text("Add to Events", style: general_text_style),
            subtitle: Text(
                "Update via this feature to let people know the details of any event"),
          ),
        ),
      ),
      Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              //  Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => CustomPage()));
              Navigator.of(context).pushNamed('AddEventScreen', arguments: 2);
            },
            leading: Icon(
              FontAwesomeIcons.star,
              color: Colors.purple,
            ),
            title: Text("Add to projects", style: general_text_style),
            subtitle: Text(
                "Update via this feature to let people know the details of any event"),
          ),
        ),
      ),
      Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              //  Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => CustomPage()));
              Navigator.of(context).pushNamed('AddEventScreen', arguments: 3);
            },
            leading: Icon(
              FontAwesomeIcons.star,
              color: Colors.purple,
            ),
            title: Text("Add to internships/jobs", style: general_text_style),
            subtitle: Text(
                "Update via this feature to let people know the details of any event"),
          ),
        ),
      ),
      // Card(
      //   elevation: 0,
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: ListTile(
      //       onTap: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => AddToSchedulePage()));
      //       },
      //       leading: Icon(
      //         Icons.schedule_outlined,
      //         color: Colors.black,
      //       ),
      //       title: Text("Add to Schedule", style: general_text_style),
      //       subtitle: Text(
      //           "Update your personal schedule with new tasks assigned like self study,sports.etc"),
      //     ),
      //   ),
      // ),
      Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProjectPage()));
            },
            leading: Icon(
              FontAwesomeIcons.tasks,
              color: Colors.greenAccent,
            ),
            title:
                Text("Share details about Projects", style: general_text_style),
            subtitle: Text(
                "Update via this feature to let people know the details of any projects in DTU, looking for Volunteers"),
          ),
        ),
      ),
    ];

    return Expanded(
      child: Container(
        alignment: Alignment.center,


        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 350),
              child: SlideAnimation(
                verticalOffset: 100.0,
                child: FlipAnimation(child: AddingButtons[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
////////////////////////////////////////////////////RIVEANIMATION

class MyRiveAnimation extends StatefulWidget {
  @override
  _MyRiveAnimationState createState() => _MyRiveAnimationState();
}

class _MyRiveAnimationState extends State<MyRiveAnimation> {
  PlusAnimation _plusAnimation;
  static const double width = 500;
  static const double height = 200;
  Color newcolor = Colors.transparent;

  Artboard _riveArtboard;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('Assets/appbar.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;

        // Add a controller to play back a known animation on the main/default
        // artboard. We store a reference to it so we can toggle playback.

        setState(() => _riveArtboard = artboard);
        _riveArtboard.addController(_plusAnimation = PlusAnimation('Idle'));
      },
    );
  }

  void _events_page_function(bool _eventspressed) {
    if (_adding_to_app_pressed == false) {
      if (_events_pressed == true) {
        newcolor = Color(0xfff2efe4);

        setState(() {
          _events_pressed = _eventspressed;
        });
      } else
        newcolor = Color(0xfff2efe4);
    }
  }

  void _adding_page_open_function(bool _adding_page_active) {
    if (_plusAnimation == null) {
      _riveArtboard.addController(
        _plusAnimation = PlusAnimation('Plus'),
      );
    }

    if (_adding_page_active == true) {
      _plusAnimation.start();
      newcolor = Color(0xfff2efe4);
    } else {
      _plusAnimation.reverse();
      if (_events_pressed == true) {
        newcolor = Color(0xfff2efe4);
      } else if (_events_pressed == false) {
        newcolor = Color(0xfff2efe4);
      }
    }

    setState(() {
      if (_adding_page_active == true) {
        _plusAnimation.isActive = false;
        _riveArtboard.addController(_plusAnimation = PlusAnimation('Plus'));

        print("_adding_page_active");
      }
      _adding_to_app_pressed = _adding_page_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("Assets/Frame 4.png"),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_adding_to_app_pressed == false && _events_pressed == false)
            Container(

              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://dtuotgstorage.blob.core.windows.net/media/events/1_AXF8IYKqC3Y7JxYRaUrCPQ.png'),
                      backgroundColor: newcolor,
                      radius: 5,
                    ),
                    CircleAvatar(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddEventsPage()));
                        },
                      ),
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: newcolor,
                      radius: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: newcolor,
                      radius: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: newcolor,
                      radius: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: newcolor,
                      radius: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: newcolor,
                      radius: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: newcolor,
                      radius: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: newcolor,
                      radius: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: newcolor,
                      radius: 5,
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              height: 200,

            ),

          //NAVIGATION OF PAGES
          if (_adding_to_app_pressed == true)
            AddingPage()
          else if (_events_pressed == true)
            EventsPage()
          else
            HomePage(),

          Container(
            padding: EdgeInsets.all(0),
            width: width,
            color: Colors.transparent,
            child: _riveArtboard == null
                ? const SizedBox()
                : GestureDetector(
                    onTapUp: (tapinfo) {
                      var localtouchposition =
                          (context.findRenderObject() as RenderBox)
                              .globalToLocal(tapinfo.globalPosition);

                      var tophalftouched = localtouchposition.dy < height / 2;
                      var hometouched = localtouchposition.dx < width / 6;
                      var internshiptouched =
                          localtouchposition.dx < 2 * (width / 6);
                      var profiletouched = localtouchposition.dx < width;
                      var lowerblanktouched =
                          localtouchposition.dx < 3 * (width / 6);
                      var eventstouched =
                          localtouchposition.dx < 5 * (width / 8);

                      if (!tophalftouched) {
                        if (hometouched) {
                          if (!_adding_to_app_pressed) {
                            setState(() {
                              if (_events_pressed == true) {
                                _events_pressed = !_events_pressed;

                                _plusAnimation.isActive = false;
                                _riveArtboard.addController(
                                    _plusAnimation = PlusAnimation('home'));
                              }
                            });
                          }
                        } else if (internshiptouched) {
                          if (!_adding_to_app_pressed) {
                            setState(() {
                              _plusAnimation.isActive = false;
                              _riveArtboard.addController(
                                  _plusAnimation = PlusAnimation('internship'));
                            });
                          }
                        } else if (lowerblanktouched) {
                          setState(() {
                            _adding_to_app_pressed = !_adding_to_app_pressed;
                            _adding_page_open_function(_adding_to_app_pressed);
                          });
                        } else if (eventstouched) {
                          if (!_adding_to_app_pressed) {
                            setState(() {
                              _events_pressed = !_events_pressed;
                              _events_page_function(_events_pressed);
                              _plusAnimation.isActive = false;
                              _riveArtboard.addController(
                                  _plusAnimation = PlusAnimation('events'));
                            });
                          }
                        } else if (profiletouched) {
                          if (!_adding_to_app_pressed) {
                            setState(() {
                              _plusAnimation.isActive = false;
                              _riveArtboard.addController(
                                  _plusAnimation = PlusAnimation('profile'));
                              print("Profile Touched");
                            });
                            Navigator.of(context)
                                .pushNamed('/ProfileDetailsScreem');
                          }
                        }
                      } else {
                        setState(() {
                          _adding_to_app_pressed = !_adding_to_app_pressed;
                          _adding_page_open_function(_adding_to_app_pressed);
                        });
                      }
                    },
                    child: Container(
                      color: Colors.transparent,

                      child: Rive(
                        artboard: _riveArtboard,
                        alignment: Alignment.bottomCenter,
                        useArtboardSize: true,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

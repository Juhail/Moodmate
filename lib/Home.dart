import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:moodmate/additionals/MoodCalender.dart';
import 'package:moodmate/additionals/homeanimation.dart';
import 'package:moodmate/additionals/animation.dart' as animation;
import 'package:moodmate/additionals/macrad.dart';
import 'package:moodmate/additionals/moodchallenge.dart';
import 'package:moodmate/additionals/weeklymoodbar.dart';
import 'package:moodmate/additionals/quotes.dart';
import 'package:moodmate/additionals/todaysmood.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
 int currentLevel =0;
class _HomeState extends State<Home> {
  List<String> activities = [
    'Go for a walk',
    'Read a book',
    'Watch a movie',
    'Cook a meal',
  ];
DateTime now = DateTime.now();
final PageController pageController = PageController(viewportFraction: 0.95);
  int activePage = 0;

  Future<List<bool>> getMoodStatusForCurrentMonth() async {
    final moodBox = Hive.box('moods');
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    List<bool> moodStatus = List.generate(daysInMonth, (index) {
      DateTime day = DateTime(now.year, now.month, index + 1);
      String dateKey = DateFormat('yyyy-MM-dd').format(day);
      return moodBox.containsKey(dateKey);
    });
    // If less than 31 days, pad with false
    if (moodStatus.length < 31) {
      moodStatus.addAll(List.filled(31 - moodStatus.length, false));
    }
    return moodStatus;
  }

@override
void initState() {
  super.initState();
  }
bool isActive = true;
  @override
  Widget build(BuildContext context) {
  //  String date =DateFormat('d EEE MMM').format(now).toUpperCase();
    return Scaffold(
      backgroundColor: Color.fromARGB(232, 247, 244, 242),
      body: SingleChildScrollView(
        child: 
        isActive?
        
        Column(children: [AnimatedWavyHeader(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [  Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("You Feel $todayMood!",style :TextStyle(letterSpacing: 1.8,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
             SizedBox(child: animation.SmileyAnimation(),)            ], ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                  child: Column(
                    children: [ 
                      // First Container
                      GestureDetector(
                        onTap: () { setState(() {
    isActive = !isActive;
    print(isActive);
  });},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 56,
                          decoration: BoxDecoration(
                            color: MoodColor,
                            borderRadius: BorderRadius.circular(30),
                        
                          ),child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              
                                Text(isActive? 'MIS': 'Feel Better?', style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:  Colors.white,
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                   const   SizedBox(height: 15,),
                      // Second Container
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 129,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                      
                        ),child: Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,0),
                          child: Column(
                          children:  [
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                                              
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 230, 235, 218),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                        child: SvgPicture.asset(
                                          'assets/${getMoodpic(todayMood)}.svg',
                                          width: 50,
                                          height: 50,
                                         // fit: BoxFit.cover,
                                        ),
                                      ),
                                  ),
                                ),
                                SizedBox(width: 10,)
,                                Expanded(flex:1,
  child: Column(
                                    children: [
                                      Text('Freud score',style:TextStyle(color:MoodColor,fontSize: 12,),),
                                      Text('80',style: TextStyle(fontWeight: FontWeight.bold,color: MoodColor,fontSize: 30),)
                                    ],
                                  ),
)
                              ],
                            ),
                            Spacer(),
                        Container(
                          width: 180,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 230, 235, 218),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(child: Text('Happy',style: TextStyle(fontWeight: FontWeight.bold,color: MoodColor),))
                        ),
                            SizedBox(height: 10,),

                          ],),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
Expanded(
  flex: 1,
  child: Padding(
    padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
    child: GestureDetector(
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoodCalendar(),
          ),
        );
      },
      child: FutureBuilder<List<bool>>(
        future: getMoodStatusForCurrentMonth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data available"));
          }

          final moodStatuses = snapshot.data!;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/sadh.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Text(
                        'Calendar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MoodColor,
                        ),
                      ),
                    ],
                  ),
                  GridView.count(
                    crossAxisCount: 7,
                    mainAxisSpacing: 4,
                    shrinkWrap: true,
                    crossAxisSpacing: 4,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: List.generate(31, (index) {
                      bool isFilled = moodStatuses[index];
                      return Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isFilled ? MoodColor : const Color.fromARGB(255, 210, 220, 187),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  ),
) ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15,0,15,0),
            child:WeeklyMoodBar()
            ),   
ChangeNotifierProvider(
  create: (_) => QuoteLogic(),
  child: HomeQuoteCard(),
),
       //
       //
       //
       
       
        ]):
        //
        //
        //
        Column(children: [
        AnimatedWavyHeader(
     
              
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
          AnimatedWavyHeader(
            // width: MediaQuery.of(context).size.width,
            // height:350,
           
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [  Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("You Feel $todayMood!",style :TextStyle(letterSpacing: 1.8,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
             SizedBox(child: animation.SmileyAnimation(),)                
              ],
            ),
          ),
          ],
          ),
        ),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
            child: Column(
            children: [
              Row(
              children: [
                Expanded(
                flex: 1,
                child: GestureDetector(
                         onTap: () { setState(() {
    isActive = !isActive;
    print(isActive);
  });
                                },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Text(
                                           'Feel Better?',
                        style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9BB068),
                        ),
                      ),
                      ],
                    ),
                    ),
                  ),
                ),
                ),
//
//
//
                SizedBox(width: 10),
                Expanded(
                flex: 1,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                                    color: const Color(0xFF9BB068),

                  borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Breath',
                        style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                        ),
                      ),
                    ),
                    ],
                  ),
                  ),
                ),
                ),
              ],
              ),
              SizedBox(height: 15),
    

              
            ],
            ),
          ),
          ),
        ],
        ),
        SizedBox(
        height: 160,
        child: Stack(
          children: [
          PageView.builder(
            controller: pageController,
            itemCount: moodCards.length,
            onPageChanged: (index) {
            setState(() {
              activePage = index;
            });
            },
            itemBuilder: (context, index) {
            final card = moodCards[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              child: Container(
                height: 200,
              decoration: BoxDecoration(
                color: card['color'],
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
                ],
              ),
              child: card['child'],
              ),
            );
            },
          ),
        
          ],
        ),
        ), 
                SizedBox(height: 15,),

Padding(
  padding: const EdgeInsets.only(bottom: 20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List<Widget>.generate(
      moodCards.length,
      (index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: () {
            pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: CircleAvatar(
            radius: 4,
            backgroundColor: activePage == index
                ? Colors.black
                : Colors.grey.shade400,
          ),
        ),
      ),
    ),
  ),
),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ChangeNotifierProvider(
              create: (_) => MoodChallengeLogic(),
              child: MoodChallengeCard(),
            ),
          ),

      ]),
      ),
    );
  }
}



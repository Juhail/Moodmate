import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

// ─────────────────────────────────────────────
// QUOTE DATA SOURCE
class QuoteSource {
  static final List<Map<String, String>> quotes = [
    {'quote': "Confidence is quiet. Insecurity is loud.", 'author': "Unknown"},
    {'quote': "If it costs your peace, it’s too expensive.", 'author': "Unknown"},
    {'quote': "Be so good they can’t ignore you.", 'author': "Steve Martin"},
    {'quote': "You don’t need permission to evolve.", 'author': "Unknown"},
    {'quote': "You carry so much light. Don’t hide it.", 'author': "Nayyirah Waheed"},
    {'quote': "Start before you’re ready.", 'author': "Steven Pressfield"},
    {'quote': "Fall in love with becoming. Not just the result.", 'author': "Unknown"},
    {'quote': "Done is better than perfect.", 'author': "Sheryl Sandberg"},
    {'quote': "Silence is an answer too.", 'author': "Unknown"},
    {'quote': "Rest is productive.", 'author': "Unknown"},
    {'quote': "Doubt kills more dreams than failure ever will.", 'author': "Suzy Kassem"},
    {'quote': "You’re allowed to outgrow people. That doesn’t make you bad.", 'author': "Unknown"},
    {'quote': "Grow through what you go through.", 'author': "Unknown"},
    {'quote': "Your vibe attracts your tribe.", 'author': "Unknown"},
    {'quote': "Discomfort means growth.", 'author': "Jay Shetty"},
    {'quote': "The road to success is dotted with tempting parking spots.", 'author': "Will Rogers"},
    {'quote': "I am not lazy. I am on energy-saving mode.", 'author': "Unknown"},
    {'quote': "Some people graduate with honors. I am just honored to graduate.", 'author': "Unknown"},
    {'quote': "Before you diagnose yourself with depression, make sure you're not surrounded by assholes.", 'author': "William Gibson"},
    {'quote': "Don’t take life too seriously. You’ll never get out of it alive.", 'author': "Elbert Hubbard"},
    {'quote': "I love deadlines. I like the whooshing sound they make as they fly by.", 'author': "Douglas Adams"},
    {'quote': "Just because you’re trash doesn’t mean you can’t do great things. It’s called garbage can, not garbage cannot.", 'author': "Unknown"},
    {'quote': "You have survived 100% of your worst days. You're doing great.", 'author': "Unknown"},
    {'quote': "Life is short. Smile while you still have teeth.", 'author': "Unknown"},
    {'quote': "The brain is a wonderful organ—it starts working the moment you get up and does not stop until you get into the office.", 'author': "Robert Frost"},
  ];
}



// ─────────────────────────────────────────────
// LOGIC PROVIDER
class QuoteLogic extends ChangeNotifier {
  final Box box = Hive.box('quotesData');

  int? get pinnedIndex => box.get('pinnedIndex');

  Map<String, String> get currentQuote {
    final quotes = QuoteSource.quotes;
    if (pinnedIndex != null && pinnedIndex! < quotes.length) {
      return quotes[pinnedIndex!];
    }
    return quotes[Random().nextInt(quotes.length)];
  }

  List<int> get likedQuotes => box.get('likedQuotes', defaultValue: <int>[]).cast<int>();

  bool isLiked(int index) => likedQuotes.contains(index);

  void toggleLike(int index) {
    final liked = likedQuotes;
    liked.contains(index) ? liked.remove(index) : liked.add(index);
    box.put('likedQuotes', liked);
    notifyListeners();
  }

  void pin(int index) {
    box.put('pinnedIndex', index);
    notifyListeners();
  }
}

// ─────────────────────────────────────────────
// HOME QUOTE CARD
class HomeQuoteCard extends StatelessWidget {
  const HomeQuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final quote = context.watch<QuoteLogic>().currentQuote;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: const Color.fromARGB(205, 203, 202, 202),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
   padding: const EdgeInsets.fromLTRB(30, 30, 30, 15),       
       child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                quote['quote'] ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(                  letterSpacing: 4,  
                  fontSize: 22,  
                  fontWeight: FontWeight.w300,  
                  color: Colors.black,  
),
              ),
              Text('-${quote['author'] ?? ''}-',textAlign: TextAlign.right,  
                style: const TextStyle(  
                  letterSpacing: 4,  
                  fontSize: 20,  
                  fontWeight: FontWeight.w200,  
                  color: Colors.black,  
                ),  ),
              //
              GestureDetector(
                onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: context.read<QuoteLogic>(),
            child: QuotesScreen(),
          ),
                ),
              );
            },
                child: Container(  
                    width: 400,  
                    height: 50,  
                    decoration: BoxDecoration(  
                      color: const Color.fromARGB(205, 189, 188, 188),  
                      borderRadius: BorderRadius.circular(20),  
                    ),  
                    child: const Center(  
                      child: Text(  
                        'read more..',  
                        style: TextStyle(  
                          fontSize: 20,  
                          fontWeight: FontWeight.w200,  
                          color: Colors.black,  
                        ),  
                      ))
              ),
             )   ],
          
                ),
        ),
    ));
  }
}

// ─────────────────────────────────────────────
// FULLSCREEN QUOTES SCREEN
class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final controller = PageController();
  final quotes = QuoteSource.quotes;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final logic = Provider.of<QuoteLogic>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.push_pin_outlined, color: Colors.black),
            onPressed: () => logic.pin(currentIndex),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: quotes.length,
            scrollDirection: Axis.vertical,
            onPageChanged: (i) => setState(() => currentIndex = i),
            itemBuilder: (_, i) {
              final quote = quotes[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      quote['quote'] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '-${quote['author'] ?? ''}-',
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 60),
                  ],
                ),
              );
            },
          ),
          //bottom bar 
          Positioned(
            bottom: 20,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Category Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 216, 216, 216).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.grid_view, size: 20, color: Colors.black),
                      SizedBox(width: 6),
                      Text(
                        'cat',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Like Button
                GestureDetector(
                  onTap: () => logic.toggleLike(currentIndex),
                  child: Icon(
                    logic.isLiked(currentIndex)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 33,
                    color: logic.isLiked(currentIndex) ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

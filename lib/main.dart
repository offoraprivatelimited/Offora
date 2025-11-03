import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const OfforaApp());
}

class OfforaApp extends StatelessWidget {
  const OfforaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offora - Discover All Offers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const OfforaLandingPage(),
    );
  }
}

// --- Helpers ---
Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// --- Main Landing Page Widget ---
class OfforaLandingPage extends StatelessWidget {
  const OfforaLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              ),
            ),
          ),
          const Positioned(
            top: -150,
            left: -150,
            child: BlurredCircle(size: 400, color: Colors.white10),
          ),
          const Positioned(
            bottom: -100,
            right: -100,
            child: BlurredCircle(size: 350, color: Colors.white10),
          ),
          // Dark overlay for a more premium, contrasty background
          Container(color: Colors.black54),
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  HeroSection(
                    isDesktop: MediaQuery.of(context).size.width > 800,
                  ),
                  const SizedBox(height: 100),
                  const Center(child: AboutSection()),
                  const SizedBox(height: 100),
                ]),
              ),
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FooterSection(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- 1. Hero Section Widget ---
class HeroSection extends StatelessWidget {
  final bool isDesktop;
  const HeroSection({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width > 600 && size.width <= 1024;
    final double titleSize = isDesktop ? 100 : (isTablet ? 84 : 56);
    final double subTitleSize = isDesktop ? 24 : (isTablet ? 20 : 18);
    final double bodySize = isDesktop ? 16 : (isTablet ? 15 : 14);
    final double comingSoonSize = isDesktop ? 56 : (isTablet ? 44 : 34);
    final double sectionHeight = isDesktop ? size.height : size.height * 0.9;
    final double maxWidth = isDesktop ? 1100 : (isTablet ? 900 : 800);
    return SizedBox(
      height: sectionHeight,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isDesktop ? 24 : 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Offora',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Discover the Best Offers from Every Store — All in One Place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: subTitleSize,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Offora helps you explore live discounts and deals from clothing, groceries, electronics, restaurants, and every type of store near you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: bodySize,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                SubtleGlowText(
                  text: 'Coming Soon',
                  fontSize: comingSoonSize,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFF4B0),
                      Color(0xFFFFD700),
                      Color(0xFFFFA000),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                const SocialMediaIconsRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Notify Me Input Field and Button ---
class NotifyMeForm extends StatelessWidget {
  final bool isDesktop;
  const NotifyMeForm({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool stackVertical = width < 420;
    return Container(
      constraints: const BoxConstraints(maxWidth: 520),
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 16),
      child: stackVertical
          ? Column(
              children: [
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter your email for early access...',
                    hintStyle: const TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: GradientButton(
                    label: 'Notify Me',
                    onPressed: () {},
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your email for early access...',
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GradientButton(
                  label: 'Notify Me',
                  onPressed: () {},
                ),
              ],
            ),
    );
  }
}

// --- Social Media Icons Row ---
class SocialMediaIconsRow extends StatelessWidget {
  const SocialMediaIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    const shareUrl = 'https://legendaryone.in';
    const shareText = 'Check out Offora — Discover the best offers from every store!';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialIcon(
          icon: Icons.facebook,
          onTap: () {
            _launchUrl('https://www.facebook.com/sharer/sharer.php?u=$shareUrl');
          },
        ),
        SocialIcon(
          icon: Icons.alternate_email, // X/Twitter placeholder
          onTap: () {
            final url = Uri.encodeComponent(shareUrl);
            final text = Uri.encodeComponent(shareText);
            _launchUrl('https://twitter.com/intent/tweet?text=$text&url=$url');
          },
        ),
        SocialIcon(
          icon: Icons.business, // LinkedIn placeholder
          onTap: () {
            _launchUrl('https://www.linkedin.com/sharing/share-offsite/?url=$shareUrl');
          },
        ),
        SocialIcon(
          icon: Icons.chat, // WhatsApp placeholder
          onTap: () {
            final msg = Uri.encodeComponent('$shareText $shareUrl');
            _launchUrl('https://wa.me/?text=$msg');
          },
        ),
      ],
    );
  }
}

// --- 2. About / Highlights Section ---
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    bool isMobile = width < 600;
    bool isTablet = width >= 600 && width <= 1024;
    final double headingSize = isMobile ? 28 : (isTablet ? 32 : 40);
    final double bodySize = isMobile ? 15 : (isTablet ? 16 : 18);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'What is Offora?',
              style: TextStyle(
                color: Colors.white,
                fontSize: headingSize,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Offora is your all-in-one destination to find, compare, and enjoy the best offers from every business — from fashion and food to tech and travel. We’re redefining the way you shop smarter.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: bodySize,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Wrap(
              spacing: 40.0,
              runSpacing: 40.0,
              alignment: WrapAlignment.center,
              children: [
                _FeatureCard(
                  icon: Icons.explore,
                  title: 'Explore Offers',
                  isMobile: isMobile,
                ),
                _FeatureCard(
                  icon: Icons.compare_arrows,
                  title: 'Compare Deals',
                  isMobile: isMobile,
                ),
                _FeatureCard(
                  icon: Icons.bookmark_border,
                  title: 'Save Favorites',
                  isMobile: isMobile,
                ),
                _FeatureCard(
                  icon: Icons.location_on,
                  title: 'Location-Based Search',
                  isMobile: isMobile,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- 3. Optional: Countdown Section ---
class CountdownSection extends StatefulWidget {
  const CountdownSection({super.key});

  @override
  State<CountdownSection> createState() => _CountdownSectionState();
}

class _CountdownSectionState extends State<CountdownSection> {
  final DateTime _launchDate = DateTime.now().add(const Duration(days: 30));
  Duration _timeRemaining = const Duration();

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      _timeRemaining = _launchDate.difference(DateTime.now());
    });
    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    if (_timeRemaining.isNegative) return const SizedBox.shrink();

    String days = _timeRemaining.inDays.toString().padLeft(2, '0');
    String hours = (_timeRemaining.inHours % 24).toString().padLeft(2, '0');
    String minutes = (_timeRemaining.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (_timeRemaining.inSeconds % 60).toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Text(
            'Launch In:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TimeCard(value: days, unit: 'Days'),
              _TimeCard(value: hours, unit: 'Hours'),
              _TimeCard(value: minutes, unit: 'Minutes'),
              _TimeCard(value: seconds, unit: 'Seconds'),
            ],
          ),
        ],
      ),
    );
  }
}

// --- 4. Footer Section ---
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text(
            'Developed by ',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
              foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.hovered)) {
                  return const Color(0xFFFFD700); // yellow on hover
                }
                return Colors.white70; // default
              }),
              overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            onPressed: () {
              // Open legendaryone.in (I can add url_launcher on request)
            },
            child: const Text(
              'Legendary One',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.white38,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Reusable Components (Styling) ---
class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6A11CB).withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isMobile;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isMobile ? 150 : 200,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white12),
              color: Colors.white.withOpacity(0.05),
            ),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                ).createShader(bounds);
              },
              child: Icon(icon, color: Colors.white, size: 40),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeCard extends StatelessWidget {
  final String value;
  final String unit;

  const _TimeCard({required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SubtleGlowText(
            text: value,
            fontSize: 64,
            fontWeight: FontWeight.bold,
            gradient: const LinearGradient(
              colors: [Color(0xFFFFFFFF), Color(0xFF8E2DE2)],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            unit,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class SubtleGlowText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final LinearGradient? gradient;
  final double? letterSpacing;

  const SubtleGlowText({
    super.key,
    required this.text,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w600,
    this.color = Colors.white,
    this.gradient,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      shadows: [
        Shadow(
          color: color.withOpacity(0.6),
          blurRadius: 8.0,
        ),
      ],
    );

    if (gradient != null) {
      return ShaderMask(
        shaderCallback: (Rect bounds) {
          return gradient!.createShader(bounds);
        },
        child: Text(text, style: style.copyWith(color: Colors.white)),
      );
    }

    return Text(text, style: style);
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const SocialIcon({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          hoverColor: Colors.white10,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.08),
              border: Border.all(color: Colors.white24, width: 0.5),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

class BlurredCircle extends StatelessWidget {
  final double size;
  final Color color;

  const BlurredCircle({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: size / 2,
            spreadRadius: size / 4,
          ),
        ],
      ),
    );
  }
}

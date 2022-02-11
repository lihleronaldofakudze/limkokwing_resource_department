import 'package:fluent_ui/fluent_ui.dart';

import '../constants.dart';

class HomeButton extends StatefulWidget {
  final String asset;
  final String title;
  final String route;
  const HomeButton(
      {Key? key, required this.asset, required this.title, required this.route})
      : super(key: key);

  @override
  _HomeButtonState createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, widget.route);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.alias,
        child: PhysicalModel(
          elevation: 15.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: 200,
            height: 200,
            decoration: Constants().homeContainerDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.asset,
                  height: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.title,
                  style: Constants().homeTitleStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

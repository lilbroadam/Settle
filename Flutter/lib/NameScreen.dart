import 'import_all.dart';

class NameScreen extends StatefulWidget {
  final DarkThemeProvider themeChange = new DarkThemeProvider();
  final bool newSession;
  final context;
  NameScreen(this.newSession, this.context);
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _formKey = GlobalKey<FormState>();

  void _navigate(String name) {
    if (widget.newSession) {
      Navigator.push(
        widget.context,
        MaterialPageRoute(
            builder: (context) => CreateSettle(name)),
      );
    } else {
      Navigator.push(
        widget.context,
        MaterialPageRoute(
            builder: (context) => JoinSettle(name)),
      );
    }
  }

  String getImage() {
    setState(() {});
    return widget.themeChange.darkTheme
        ? 'assets/background-dark.png'
        : 'assets/background.png';
  }

  Widget build(BuildContext context) {
    final myControler = TextEditingController();
    final double width = 55;
    final double height = 50;
    final margin = EdgeInsets.all(18);
    final nextButton = SizedBox(
      width: width,
      height: height,
      child: AppTheme.nextButton(context, () {
        if (_formKey.currentState.validate()) _navigate(myControler.text);
      }),
    );

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(getImage()), fit: BoxFit.cover)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.only(left: 20, top: 15),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
            tooltip: getText(context, "tipback"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(getText(context, "getname"),
                      style: TextStyle(fontSize: 25)),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      controller: myControler,
                      textAlign: TextAlign.center,
                      validator: (text) {
                        myControler.text = text.trim();
                        text = text.trim();
                        if (text.isEmpty) {
                          return getText(context, "invalidname");
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(),
                    ),
                  ),
                  Container(
                    margin: margin,
                    child: nextButton,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

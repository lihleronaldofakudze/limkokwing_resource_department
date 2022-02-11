import 'package:fluent_ui/fluent_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Center(
          child: Text(
        'Limkokwing University \nResources Management System',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      )),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/login-amico.png',
                height: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Access your account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 400,
                  child: TextBox(
                    header: 'Username',
                    placeholder: 'Enter your username',
                    keyboardType: TextInputType.name,
                  )),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: 400,
                  child: TextBox(
                    header: 'Password',
                    placeholder: 'Enter your username',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    suffix: IconButton(
                        icon: Icon(FluentIcons.red_eye), onPressed: () {}),
                  )),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 240,
                child: FilledButton(
                  child: Text('Login'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  // style: ButtonStyle(backgroundColor: Button),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}

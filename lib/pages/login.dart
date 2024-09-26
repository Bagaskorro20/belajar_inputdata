import 'package:flutter/material.dart';
import 'package:inputdata/pages/mainNavigation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obText = true;

  Map<String, dynamic> dataLogin = {
    "nama": "Tejo",
    "email": "tejo@gmail.com",
    "password": "123"
  };

  TextEditingController _emailControler = TextEditingController();
  TextEditingController _passwordControler = TextEditingController();

  void _loginCheck() {
    if (_emailControler.text == dataLogin['email']) {
      if (_passwordControler.text == dataLogin['password']) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainNavigation(
              login: dataLogin,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Maaf Password Anda Salah"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Maaf Email Anda Belum Terdaftar"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
            child: Column(
              children: [
                Text(
                  "Bahasa Indonesia",
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/768px-Instagram_logo_2022.svg.png"),
                ),
                SizedBox(
                  height: 80,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailControler,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Email address",
                    contentPadding: EdgeInsets.only(left: 20, right: 20),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: obText,
                  controller: _passwordControler,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Password",
                      contentPadding: EdgeInsets.only(left: 20, right: 20),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obText = !obText;
                            });
                          },
                          icon: Icon(obText
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined))),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _loginCheck,
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 17),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Lupa Kata Sandi?",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text("Buat Akun Baru"),
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.blue.shade700),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 20,
                        width: 70,
                        child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Meta_Platforms_Inc._logo.svg/1280px-Meta_Platforms_Inc._logo.svg.png"),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

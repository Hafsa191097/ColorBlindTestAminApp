import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Auth/auth.dart';
import '../../../Constants/Widgets.dart';
import '../../Auth/firestore.dart';
import 'Login.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({super.key});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      var snackBar = const SnackBar(
                          content: Text('Email Cannot Be Empty!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isObscure = !_isObscure;
                      },
                      icon: Icon(_isObscure
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      var snackBar = const SnackBar(
                          content: Text('Password Cannot Be Empty!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (value.length < 8) {
                      var snackBar = const SnackBar(
                          content: Text(
                              'Length Of Password Should be Greater than 8!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 57,
                  child: ElevatedButton(
                    
                    onPressed: () async {

                      try {
                        if (_key.currentState!.validate()) {
                          await AuthService().registerUser(_emailController.text,
                              _passwordController.text, context).then((value) async {
                                await FireStoreDataBase().addLDataOfUsers(_emailController.text,_passwordController.text);
                                Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                                });
                          
                        }
                      } on FirebaseAuthException catch (e) {
                        
                        var snackBar =
                            SnackBar(content: Text(e.message.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.redAccent, //background color of button
                      side: const BorderSide(
                          width: 2,
                          color: Colors.white), //border width and color

                      shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          const EdgeInsets.all(5), //content padding inside button
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Login()));
                  },
                  child: const Text(
                    'Already have an Account? SignIn',
                    style: TextStyle(color: Colors.black, fontSize: 15),
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

// class Register_Screen extends StatelessWidget {
//   const Register_Screen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final _emailController = TextEditingController();
//     final _passwordController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         title: appBar(context),
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         elevation: 0.0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height:140),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 32.0),
//               SizedBox(
//                 width: double.infinity,
//                 height: 57,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       AuthService().registerUser(
//                           _emailController.text, _passwordController.text,context);

//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const Login()));
//                     } on FirebaseAuthException catch (e) {
//                       var snackBar =
//                           SnackBar(content: Text(e.message.toString()));
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                     
//                     }
//                   },
//                   child: Text(
//                     'Register',
//                     style: TextStyle(color: Colors.white, fontSize: 17),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                         Colors.redAccent, //background color of button
//                     side: const BorderSide(
//                       width: 2,
//                       color: Colors.white,
//                     ), //border width and color

//                     shape: RoundedRectangleBorder(
//                       //to set border radius to button
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: EdgeInsets.all(5), //content padding inside button
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) => const Login()));
//                 },
//                 child: const Text(
//                   'Already have an account, Login',
//                   style: TextStyle(color: Colors.black, fontSize: 15),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

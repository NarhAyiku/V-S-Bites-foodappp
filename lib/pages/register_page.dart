      import 'package:flutter/material.dart';
      import 'package:foodappp/services/auth/auth_service.dart';
        import '../components/my_button.dart';
        import '../components/my_textfield.dart';

      class RegisterPage extends StatefulWidget {
         final void Function()? onTap;
        const RegisterPage({super.key, required this.onTap});

       @override
        State<RegisterPage> createState() => _RegisterPageState();
      }

      class _RegisterPageState extends State<RegisterPage> {
        //text editing controllers
        final  emailController = TextEditingController();
        final  passwordController = TextEditingController();
        final  confirmPasswordController =TextEditingController ();

        // register meth0d
        void register() async{
          // get auth services
          final _authservices = AuthServices();


         // check if passwords match -> create user
         if(passwordController.text == confirmPasswordController.text){
          // try creating user 
            try {
              await _authservices.signUpWithEmailPassword(
                emailController.text,
                passwordController.text,
              );
            } 

            // display error if any
            catch (e) {
              showDialog(
              context: context, 
              builder: (context) => AlertDialog(
                title: Text (e.toString()
                ),
              ),
              );
            }
          }

         // if passwords don't match -> show error
          else{
              showDialog(context: context, 
              builder: (context) => const AlertDialog(
                title: Text("Passwords do not match"),
              ),
              );
            }        
        }        

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Icon(
                    Icons.lock_open_rounded,
                    size: 100,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),

                  //message, app slogan
                  Text(
                    "Let's create an account for you",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  //confirm password textfield
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm password",
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  //sign up button
                  MyButton(
                    text: "Sign up",
                    onTop: (){
                       print('Widget was tapped!');
                    }, 
                    onTap: () { 
                      register();
                    },
                  ),

                  const SizedBox(height: 25),

                  //already have an account? Login here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Login now",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }
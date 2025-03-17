import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/auth/login_screen.dart';
import 'package:grocery_app/screens/bottom_bar_screen.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import '../../consts/consts.dart';
import '../../consts/firebase_consts.dart';
import '../../services/global_methods.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/text_widget.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  var _obscureText = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressTextController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _addressFocusNode.dispose();

    super.dispose();
  }

  bool _isLoading = false;

  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();
      try {
        await auth.createUserWithEmailAndPassword(
            email: _emailController.text.toLowerCase().trim(),
            password: _passwordController.text.trim());
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const BottomBarScreen()));
        print('success');
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Consts.authImagesPaths[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              duration: 800,
              autoplayDelay: 5000,
              itemCount: Consts.authImagesPaths.length,
              pagination: const SwiperPagination(
                  // alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white, activeColor: Colors.red)),
              // control: const SwiperControl(color: Colors.black),
            ),
            Container(
              color: Colors.black.withOpacity(0.8),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => Navigator.canPop(context)
                          ? Navigator.pop(context)
                          : null,
                      child: const Icon(
                        IconlyLight.arrowLeft2,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextWidget(
                      text: 'Welcome',
                      color: Colors.white,
                      textSize: 30,
                      isTitle: true,
                    ),
                    TextWidget(
                      text: 'Sign up to continue',
                      color: Colors.white,
                      textSize: 16,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(_emailFocusNode);
                              },
                              controller: _fullNameController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field is missing';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  hintText: 'Full Name',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !value.contains('@gmail.com')) {
                                  return 'Enter a valid email address';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(_addressFocusNode);
                              },
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscureText,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 8) {
                                  return 'Enter a valid password';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Icon(
                                        _obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white,
                                      )),
                                  hintText: 'Password',
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                _submitFormOnRegister();
                              },
                              controller: _addressTextController,
                              focusNode: _addressFocusNode,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 10) {
                                  return 'Enter a valid address';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  hintText: 'Shipping address',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    // _isLoading
                    //     ? const Center(child: CircularProgressIndicator())
                    //     :
                    AuthButton(
                        function: () {
                          _submitFormOnRegister();
                        },
                        buttonText: 'Sign up'),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Already a user?',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                          children: [
                            TextSpan(
                                text: '  Sign in',
                                style: const TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    GlobalMethods.navigateTo(
                                        context, LoginScreen.routeName);
                                  })
                          ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

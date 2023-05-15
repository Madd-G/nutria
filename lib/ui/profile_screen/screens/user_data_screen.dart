import 'package:flutter/material.dart';
import 'package:nutria/blocs/bloc_imports.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({Key? key}) : super(key: key);

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenBloc = context.read<ScreenBloc>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            screenBloc.add(ScreenEventGoToProfileScreen());
          },
        ),
        title: const Text('User Data'),
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 190.0,
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Column(
                      children: const [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/profile-3.png'),
                          radius: 60.0,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'akhmadnuralamsyah@gmail.com',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        )
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Form(
                          key: _updateFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Nama Lengkap',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: size.height * 0.018,
                              ),
                              TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF7F7F7),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFE9EBEF))),
                                  hintText: 'Alamsyah',
                                  hintStyle: TextStyle(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFE9EBEF))),
                                  contentPadding: EdgeInsets.all(12.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.018,
                              ),
                              const Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: size.height * 0.018,
                              ),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFF7F7F7),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFE9EBEF))),
                                    hintText: 'akhmadnuralamsyah@gmail.com',
                                    hintStyle: TextStyle(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFE9EBEF))),
                                    contentPadding: EdgeInsets.all(12.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                                validator: (String? value) {
                                  const String expression =
                                      "[a-zA-Z0-9+._%-+]{1,256}"
                                      "\\@"
                                      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
                                      "("
                                      "\\."
                                      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
                                      ")+";
                                  final RegExp regExp = RegExp(expression);
                                  return !regExp.hasMatch(value!)
                                      ? "Silakan, masukkan email yang valid!"
                                      : null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 30.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: const Center(
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
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

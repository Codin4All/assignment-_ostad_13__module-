import 'package:batch_18/task_manager/controller/auth_controller.dart';
import 'package:batch_18/task_manager/models/api_response.dart';
import 'package:batch_18/task_manager/models/user_model.dart';
import 'package:batch_18/task_manager/screens/main_nav_screen.dart';

import 'package:batch_18/task_manager/service/api_caller.dart';
import 'package:batch_18/task_manager/utils/urls.dart';
import 'package:batch_18/task_manager/widgets/screen_bg.dart';
import 'package:batch_18/task_manager/widgets/tm_appbar.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> onTapUpdateProfile() async {
    Map<String, dynamic> requestbody = {
      "email": emailController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "mobile": mobileController.text,
      "password": passwordController.text,
    };
    if (passwordController.text.isNotEmpty) {
      requestbody['password'] = passwordController.text;
    }

    final ApiResponse response = await ApiCaller.postRequest(
      url: TMUrls.ProfileUpdateURL,

      body: requestbody,
    );
   
     

    if (response.isSuccess) {

       UserModel model = UserModel(
        sId: AuthController.userData?.sId,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobile: mobileController.text, 

        

      );
    
    AuthController.updateUserData(model);
    setState(() {
      
    });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    UserModel user = AuthController.userData!;
    emailController.text = user.email!;
    firstNameController.text = user.firstName!;
    lastNameController.text = user.lastName!;
    mobileController.text = user.mobile!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(),
      body: ScreenBG(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 130),
                Text(
                  'Update Profile ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 25),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(hintText: 'First Name'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(hintText: 'Last name'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(hintText: 'Mobile'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                ),

                SizedBox(height: 20),

                FilledButton(
                  onPressed: () {
                    onTapUpdateProfile();
                  },
                  child: Icon(Icons.arrow_forward_ios_sharp, size: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

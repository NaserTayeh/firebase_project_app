// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:final_project_firebase/components/custom_button.dart';
import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  Widget textFormField({required String hintText}) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
      child: ListTile(
        leading: Text(hintText),
      ),
    );

    // TextFormField(
    //   decoration: InputDecoration(
    //       filled: true,
    //       hintText: 'Naser',
    //       fillColor: Colors.grey[300],
    //       border: OutlineInputBorder(
    //           borderSide: BorderSide.none,
    //           borderRadius: BorderRadius.circular(10))),
    // );
  }

  @override
  Widget build(BuildContext context) {
    String? email = Provider.of<MyProvider>(context).loggingUser.emailAddress;
    String? name = Provider.of<MyProvider>(context).loggingUser.fullName;

    Provider.of<MyProvider>(context, listen: false).updatedFullName.text = name;
    Provider.of<MyProvider>(context, listen: false).updatedEmail.text = email;
    Widget nonEditTextField() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg'),
                radius: 50,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          textFormField(
              hintText: Provider.of<MyProvider>(context).loggingUser.fullName),
          SizedBox(
            height: 10,
          ),
          textFormField(
              hintText:
                  Provider.of<MyProvider>(context).loggingUser.emailAddress),
        ],
      );
    }

    Widget editTextField() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg'),
                radius: 50,
              ),
            ],
          ),
          TextFormField(
            style: TextStyle(
                color: Provider.of<MyProvider>(context).isDarkMode
                    ? Colors.white
                    : Colors.black),
            controller: Provider.of<MyProvider>(context).updatedFullName,
            decoration: InputDecoration(hintText: "full Name"),
          ),
          TextFormField(
            style: TextStyle(
                color: Provider.of<MyProvider>(context).isDarkMode
                    ? Colors.white
                    : Colors.black),
            controller: Provider.of<MyProvider>(context).updatedEmail,
            decoration: InputDecoration(
              hintText: "emailAddres",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            function: () {
              Provider.of<MyProvider>(context, listen: false)
                  .profileValidation(context);

              // profileVaidation(
              //   context: context,
              //   emailAdress: emailAddress,
              //   fullName: fullName,
              // );
            },
            text: "Up date",
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Provider.of<MyProvider>(context).isEdit
            ? IconButton(
                onPressed: () {
                  Provider.of<MyProvider>(context, listen: false)
                      .changeIsEdit(false);
                },
                icon: Icon(Icons.close),
              )
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<MyProvider>(context, listen: false)
                  .changeIsEdit(true);
            },
            icon: Icon(Icons.edit),
          ),
        ],
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Provider.of<MyProvider>(context).isEdit
                    ? editTextField()
                    : nonEditTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

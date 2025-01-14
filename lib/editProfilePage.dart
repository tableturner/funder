import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'classes/user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'profilepage.dart';
import 'loginpage.dart';




class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  String displayName=currentUserModel.displayName;
  String bio=currentUserModel.bio;
  File _image;
  String url=currentUserModel.photoUrl;
  String uid= currentUserModel.uid;
  List<dynamic> myRequests;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();


  Future<void> setImage() async {
   var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);

setState(() {
  _image = sampleImage;
});
   uploadImage();

  }

  //Gets the info from database of the current user when page loads
  @override
  void initState() {
    super.initState();

//    currentUser= new User();
//    currentUser.getInfo().then((_) => setState(() {
//      if(currentUser.getBio()!=null) {
//        bio = currentUser.getBio();
//      }
//      if(currentUser.getDisplayName()!=null) {
//        displayName = currentUser.getDisplayName();
//      }
//      if(currentUser.getPhotoUrl()!=null) {
//        url = currentUser.getPhotoUrl();
//      }
////      if(currentUser.getRequests()!=null){
////        myRequests=currentUser.getRequests();
////
////      }
//    }));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(

          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child:
                  url== null
                  ? CircularProgressIndicator()
                  : CircleAvatar(
                      backgroundImage: NetworkImage(url),
                      radius: 75.0),

            ),
            FlatButton(
              //TODO: get the change picture functionality working
                onPressed: () {
                 setImage();
                },
                child: Text(
                  "Change Photo",
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)
    )
  ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                      onChanged: (value){
                        displayName=value;
                      },
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Username",

                      )),
                  TextField(
                      onChanged: (value) {
                        bio = value;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "bio",
                      )),
                ],
              ),
            ),
            RaisedButton(
              //Updates the user's profile changes to Firestore and User class
                onPressed: () {


                  Firestore.instance.collection('users').document(uid).updateData({
                    "displayName":displayName,
                    "bio":bio,
                    'photoUrl':url
                  });
                  //How to update porfile page as well when pushed to it, do other pages now have access to this updated usermodel?
                  currentUserModel=new User(displayName: displayName,bio: bio,email: currentUserModel.email,uid: currentUserModel.uid,photoUrl: url);
                  print(bio);
                  print(displayName);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfilePage()));
                  //either sets the image and sends to databse here or in earlier method


                },
                child: Text("Save Changes")),
            RaisedButton(

               onPressed: () {
                 Navigator.pop(context);
//                 url=currentUser.getPhotoUrl();
               },
                child: Text("Back")),


          ])

  );}

  Future<void> uploadImage() async{
    StorageReference firebaseStorageRef=
    FirebaseStorage.instance.ref().child('$uid.jpg');
    StorageUploadTask task= firebaseStorageRef.putFile(_image);

    var downloadUrl=await (await task.onComplete).ref.getDownloadURL();
    setState(() {
      url=downloadUrl.toString();
    });

    print(url);


  }

  Widget buildTextField({String name, TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            name,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: name,
          ),
        ),
      ],
    );
  }
}

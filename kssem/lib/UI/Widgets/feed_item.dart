import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kssem/Utilities/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Screens/image_preview_screen.dart';

enum Options {
  Edit,
  Delete,
}

buildFeedCard(BuildContext context,
    {String name,
    String content,
    String timestamp,
    String photoUrl,
    String title,
    String imageUrl,
    int likeCount,
    Function onLiked,
    bool isLiked}) {
  var devicesize = MediaQuery.of(context);

  return Card(
    elevation: 2,
    color: Theme.of(context).colorScheme.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        buildHeader(devicesize,
            name: name, photoUrl: photoUrl, context: context),
        buildContent(
            content: content,
            title: title,
            imageUrl: imageUrl,
            context: context),
        buildFooter(devicesize,
            timestamp: timestamp,
            onLiked: onLiked,
            isLiked: isLiked,
            likeCount: likeCount,
            context: context),
      ],
    ),
  );
}

Flexible buildContent(
    {BuildContext context, String content, String title, String imageUrl}) {
  return Flexible(
    fit: FlexFit.loose,
    child: Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          imageUrl == null
              ? Container(
                  height: 0,
                )
              :
              // child:
              Hero(
                  // key: UniqueKey(),
                  tag: "$imageUrl",
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ImagePreview(imageUrl: imageUrl)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          imageBuilder: (_, imageprovider) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight: SizeConfig.blockSizeVertical * 25,
                                  maxWidth: SizeConfig.screenWidth),
                              child: Container(
                                // color: Colors.grey[200],
                                foregroundDecoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.white)],
                                    borderRadius: BorderRadius.circular(25),
                                    // border: Border(: BorderSide(color: Colors.black)),
                                    image: DecorationImage(
                                        image: imageprovider,
                                        fit: BoxFit.cover)),
                                // child: Image.network(
                                //   imageUrl,
                                //   fit: BoxFit.cover,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
          // ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Linkify(
              onOpen: (link) async {
                if (await canLaunch(link.url)) {
                  await launch(
                    link.url,
                    // forceWebView: true,
                    enableJavaScript: true,
                  );
                } else {
                  throw 'Could not launch $link';
                }
              },
              style: TextStyle(fontSize: 16),
              linkStyle: TextStyle(color: Colors.blue),
              text: content,
            ),
          ),
        ],
      ),
    ),
  );
}

Container buildHeader(MediaQueryData devicesize,
    {Widget options, String name, String photoUrl, BuildContext context}) {
  SizeConfig().init(context);
  return Container(
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border(
            bottom: BorderSide(
          width: .50,
          color: Theme.of(context).colorScheme.primary,
        ))),
    child: Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: CircleAvatar(
              maxRadius: 23,
              backgroundColor: Colors.blue[900],
              backgroundImage: photoUrl != null
                  ? NetworkImage(photoUrl)
                  : AssetImage('assets/defaultprofile.png'),
            )),
        SizedBox(
          width: 15,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 40),
          child: Container(
            width: devicesize.size.width * .53, //225,
            height: devicesize.size.height * .07, //50,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  name,
                  // "name "
                  // "Sameer Kashayp",
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Container buildProfileHeader(MediaQueryData devicesize,
    {Widget options,
    String name,
    String photoUrl,
    Function onPressedEdit,
    Function onPressedDelete,
    BuildContext context}) {
  return Container(
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border(bottom: BorderSide(width: .50, color: Colors.black26))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: CachedNetworkImage(
              imageUrl: photoUrl,
              imageBuilder: (_, imageprovider) {
                return CircleAvatar(
                  maxRadius: 23,
                  backgroundImage: imageprovider,
                  backgroundColor: Colors.blue[900],
                );
              },
            )),
        // SizedBox(
        //   width: SizeConfig.blockSizeHorizontal * 3,
        // ),
        Padding(
          padding: EdgeInsets.only(
              top: 10, right: SizeConfig.blockSizeHorizontal * .6),
          child: Container(
            width: devicesize.size.width * .53, //225,
            height: devicesize.size.height * .07, //50,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Wrap(children: <Widget>[
                  Text(
                    name,
                    // "Sameer Kashayp",?
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ]),
              ],
            ),
          ),
        ),
        buildOptions(devicesize,
            onPressedEdit: onPressedEdit, onPressedDelete: onPressedDelete),
      ],
    ),
  );
}

Container buildFooter(
  MediaQueryData devicesize, {
  BuildContext context,
  String timestamp,
  int likeCount,
  Function onLiked,
  bool isLiked,
}) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border(
        top: BorderSide(color: Colors.black45, width: 0.50),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 3,
            bottom: SizeConfig.blockSizeHorizontal * 1.25,
          ),
          // child: Material(
          //   borderRadius: BorderRadius.circular(30),
          //   borderOnForeground: true,
          child: IconButton(
            iconSize: SizeConfig.blockSizeHorizontal * 6,
            enableFeedback: true,

            splashColor: Colors.red,
            onPressed: onLiked,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.grey,
              size: 30,
            ),
            // ),
          ),
        ),

        Expanded(
          child: Text(
            likeCount.toString(),
            // "1000",
            // style: TextStyle(color: Colors.black87),
          ),
        ),
        // Container(width: 20,),
        // Padding(
        //   padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
        //   child: Material(
        //     shadowColor: Colors.white,
        //     borderOnForeground: true,
        //     borderRadius: BorderRadius.circular(25),
        //     child: IconButton(
        //       splashColor: Colors.black,
        //       icon: Icon(FontAwesome.share_square_o),
        //       onPressed: () {},
        //     ),
        //   ),
        // ),
        SizedBox(width: SizeConfig.screenWidth * .40),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            timestamp,
            style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.3),
            // " 1 May 2019, 1:45 pm",
          ),
        )
      ],
    ),
  );
}

Padding buildOptions(MediaQueryData devicesize,
    {Function onPressedEdit, Function onPressedDelete}) {
  return Padding(
    padding: EdgeInsets.only(left: devicesize.size.width * 0.01),
    child: PopupMenuButton(
      onSelected: (Options choice) {
        if (choice == Options.Edit) {
          onPressedEdit();
        } else if (choice == Options.Delete) {
          onPressedDelete();
        }
      },
      icon: Icon(Icons.more_vert),
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                // onPressed: onPressedEdit,
                (Icons.edit),
              ),
              Text("Edit"),
            ],
          ),
          value: Options.Edit,
        ),
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: onPressedDelete,
              ),
              Text("Delete"),
            ],
          ),
          value: Options.Delete,
        ),
      ],
    ),
  );
}

buildProfileFeedCard(BuildContext context,
    {String name,
    String content,
    String photoUrl,
    String timestamp,
    String title,
    String imageUrl,
    Function onPressedEdit,
    Function onPressedDelete,
    Function onLiked,
    bool isLiked,
    int likeCount}) {
  var devicesize = MediaQuery.of(context);

  return Card(
    elevation: 2,
    color: Theme.of(context).colorScheme.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        buildProfileHeader(devicesize,
            name: name,
            photoUrl: photoUrl,
            onPressedDelete: onPressedDelete,
            onPressedEdit: onPressedEdit,
            context: context),
        buildContent(content: content, title: title, imageUrl: imageUrl),
        buildFooter(
          devicesize,
          timestamp: timestamp,
          onLiked: onLiked,
          isLiked: isLiked,
          likeCount: likeCount,
        )
      ],
    ),
  );
}

import 'package:accident/Presentation/dashboard/components/seconadary_components/room_mate_column.dart';
import 'package:flutter/material.dart';

class RoomMates extends StatefulWidget {
  const RoomMates({super.key});

  @override
  State<RoomMates> createState() => _RoomMates();
}

class _RoomMates extends State<RoomMates> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.all(MediaQuery.of(context).size.height * 0.0080),
            child: RoomMateColumn(
              department: 'Software Engineer',
              imageUrl:
                  'https://image.tensorartassets.com/cdn-cgi/image/anim=true,plain=false,w=2048,f=jpeg,q=85/posts/images/664286442867920848/0c6d57b6-18cd-4826-a7e0-d0b3d3758d82.jpg',
              name: 'Harshali Bagul',
            ),
          ),
          Padding(
            padding:
                EdgeInsets.all(MediaQuery.of(context).size.height * 0.0080),
            child: RoomMateColumn(
              department: 'CRPF',
              imageUrl:
                  'https://t4.ftcdn.net/jpg/04/01/64/61/360_F_401646148_P8vp7rMVrnauzPapMQCuupZu4eXaM6ac.jpg',
              name: 'Akshay Salve',
            ),
          ),
          Padding(
            padding:
                EdgeInsets.all(MediaQuery.of(context).size.height * 0.0080),
            child: RoomMateColumn(
              department: 'Software Tester',
              imageUrl:
                  'https://image.tensorartassets.com/cdn-cgi/image/w=600/posts/images/698586356636672348/9139e674-e28e-44ab-bf61-ebae4f65d81f.jpg',
              name: 'Savita Thete',
            ),
          ),
          Padding(
            padding:
                EdgeInsets.all(MediaQuery.of(context).size.height * 0.0080),
            child: RoomMateColumn(
              department: 'Software Engineer',
              imageUrl:
                  'https://www.shutterstock.com/image-photo/headshot-portrait-handsome-guy-19-600nw-2457814671.jpg',
              name: 'Sachin Shivade',
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_player/const/colors.dart';
import 'package:m_player/const/text_style.dart';
import 'package:m_player/controllers/player_controller.dart';
import 'package:m_player/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        leading: const Icon(Icons.sort_rounded),
        title: const Text('M Player'),
      ),
      body: FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No song found',
                  style: ourStyle(),
                ),
              );
            } else {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: Obx(
                            () => ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              tileColor: bgColor,
                              leading: QueryArtworkWidget(
                                id: snapshot.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note,
                                  color: whiteColor,
                                ),
                              ),
                              title: Text(
                                snapshot.data![index].displayNameWOExt,
                                style: ourStyle(),
                              ),
                              subtitle: Text(
                                '${snapshot.data![index].artist}',
                                style: ourStyle(),
                              ),
                              trailing: controller.playIndex.value == index &&
                                      controller.isPlaying.value
                                  ? const Icon(
                                      Icons.play_arrow,
                                      color: whiteColor,
                                    )
                                  : null,
                              onTap: () {
                                Get.to(
                                    () => Player(
                                          data: snapshot.data!,
                                        ),
                                    transition: Transition.downToUp);
                                controller.playSong(
                                    snapshot.data![index].uri, index);
                              },
                            ),
                          ),
                        );
                      }));
            }
          }),
    );
  }
}

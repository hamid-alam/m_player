import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_player/const/colors.dart';
import 'package:m_player/const/text_style.dart';
import 'package:m_player/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
            children: [
              Expanded(
                  child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: 300,
                height: 300,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                alignment: Alignment.center,
                child: QueryArtworkWidget(
                  id: data[controller.playIndex.value].id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: double.infinity,
                  artworkWidth: double.infinity,
                  nullArtworkWidget: const Icon(
                    Icons.music_note,
                    color: whiteColor,
                  ),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(17))),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        data[controller.playIndex.value].displayNameWOExt,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: ourStyle(),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        data[controller.playIndex.value].artist.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: ourStyle(),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.position.value,
                              style: ourStyle(),
                            ),
                            Expanded(
                                child: Slider(
                              min: const Duration(seconds: 0)
                                  .inSeconds
                                  .toDouble(),
                              max: controller.max.value,
                              value: controller.value.value,
                              onChanged: (newValue) {
                                controller
                                    .changeDurationToSeconds(newValue.toInt());
                                newValue = newValue;
                              },
                            )),
                            Text(
                              controller.duration.value,
                              style: ourStyle(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.playSong(
                                    data[controller.playIndex.value - 1].uri,
                                    controller.playIndex.value - 1);
                              },
                              icon: const Icon(
                                Icons.skip_previous,
                                size: 40,
                              )),
                          Obx(
                            () => CircleAvatar(
                              radius: 35,
                              backgroundColor: bgDarkColor,
                              child: Transform.scale(
                                scale: 2.5,
                                child: IconButton(
                                  onPressed: () {
                                    if (controller.isPlaying.value) {
                                      controller.audioPlayer.pause();
                                      controller.isPlaying(false);
                                    } else {
                                      controller.audioPlayer.play();
                                      controller.isPlaying(true);
                                    }
                                  },
                                  icon: controller.isPlaying.value
                                      ? const Icon(
                                          Icons.pause_circle,
                                          color: whiteColor,
                                        )
                                      : const Icon(
                                          Icons.play_arrow_rounded,
                                          color: whiteColor,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.playSong(
                                    data[controller.playIndex.value + 1].uri,
                                    controller.playIndex.value + 1);
                              },
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                size: 40,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

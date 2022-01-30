import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/chat_message.dart';
import 'package:yulli/screens/preview/preview_screen.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/extensions/index.dart';
import 'package:yulli/widgets/opacity_button.dart';

class ChatMessageItem extends StatelessWidget {
  const ChatMessageItem({
    Key key,
    @required this.message,
    @required this.participantId,
  })  : assert(message != null),
        assert(participantId != null),
        super(key: key);

  final ChatMessage message;
  final String participantId;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final isParticipant = message.senderId == participantId;

    return Align(
      alignment: isParticipant ? Alignment.centerLeft : Alignment.centerRight,
      child: GestureDetector(
        onLongPress: () async {
          if (message.type == ChatMessageType.text) {
            await Clipboard.setData(ClipboardData(text: message.content));
            await HapticFeedback.vibrate();
            Fluttertoast.showToast(
              msg: "Copié",
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        },
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .7),
          padding: const EdgeInsets.symmetric(
            vertical: AppDimens.smPadding,
            horizontal: AppDimens.padding,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: AppDimens.smPadding,
          ),
          decoration: BoxDecoration(
            color: isParticipant
                ? AppColors.messageParticipantColor
                : AppColors.primary,
            borderRadius: BorderRadius.circular(AppDimens.nsmPadding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Builder(builder: (context) {
                if (message.type == ChatMessageType.text) {
                  return Linkify(
                    text: message.content,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: isParticipant
                              ? AppColors.messageParticipantTextColor
                              : Colors.white,
                        ),
                    linkStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: (isParticipant
                                  ? AppColors.messageParticipantTextColor
                                  : Colors.white)
                              .withOpacity(.7),
                          decoration: TextDecoration.underline,
                        ),
                    options: LinkifyOptions(
                      looseUrl: true,
                      humanize: false,
                    ),
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        Fluttertoast.showToast(
                          msg: localization.notices.unsupportedLink,
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                        );
                      }
                    },
                  );
                  // return Text(
                  //   message.content,
                  //   style: TextStyle(
                  //     color: isParticipant
                  //         ? AppColors.messageParticipantTextColor
                  //         : Colors.white,
                  //   ),
                  // );
                }
                if (message.type == ChatMessageType.image) {
                  return CachedNetworkImage(
                    imageUrl: message.file.downloadUrl,
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        ),
                      );
                    },
                    fit: BoxFit.fitWidth,
                    errorWidget: (_, __, ___) {
                      return Container(
                        width: double.infinity,
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Icon(
                          FeatherIcons.alertCircle,
                          color: AppColors.errorColor,
                        ),
                      );
                    },
                    imageBuilder: (context, imageProvider) {
                      return OpacityButton(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PreviewScreen(
                                fileUrl: message.file.downloadUrl,
                                isVideo: false,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.width * .7,
                          ),
                          margin: const EdgeInsets.only(
                            top: AppDimens.smPadding,
                            bottom: AppDimens.smPadding,
                          ),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                if (message.type == ChatMessageType.video) {
                  return OpacityButton(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PreviewScreen(
                            fileUrl: message.file.downloadUrl,
                            isVideo: true,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.width * .7,
                      ),
                      margin: const EdgeInsets.only(
                        top: AppDimens.smPadding,
                        bottom: AppDimens.smPadding,
                      ),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(8),
                        color: Colors.grey,
                      ),
                      child: Material(
                        type: MaterialType.circle,
                        color: Colors.white,
                        elevation: 2,
                        shadowColor: Colors.black38,
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              }),
              Text(
                message.createdAt.timeOfDay(context),
                style: TextStyle(
                  color: (isParticipant
                          ? AppColors.messageParticipantTextColor
                          : Colors.white)
                      .withOpacity(.7),
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

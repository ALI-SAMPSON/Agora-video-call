import 'package:agora_video_call/socket/model/res_call_accept_model.dart';
import 'package:agora_video_call/socket/model/res_call_request_model.dart';
import 'package:agora_video_call/socket/socket_constants.dart';
import 'package:agora_video_call/socket/socket_manager.dart';
import 'package:agora_video_call/utils/color_utils.dart';
import 'package:agora_video_call/utils/constants/arg_constants.dart';
import 'package:agora_video_call/utils/constants/route_constants.dart';
import 'package:agora_video_call/utils/dimens.dart';
import 'package:agora_video_call/utils/localization/localization.dart';
import 'package:agora_video_call/utils/navigation.dart';
import 'package:agora_video_call/utils/permission_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:permission_handler/permission_handler.dart';

class CommonScreen extends StatefulWidget {
  @override
  _CommonScreenState createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      initSocketManager(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).appBarLabel),
        centerTitle: true,
        backgroundColor: ColorUtils.accentColor,
      ),
      body: Center(
        child: RaisedButton(
          color: ColorUtils.accentColor,
          child: Text(Localization.of(context).primaryBtnLabel,
              style: TextStyle(
                  color: ColorUtils.whiteColor, fontSize: buttonLabelFontSize)),
          onPressed: () {
            PermissionUtils.requestPermission(
                [PermissionGroup.camera, PermissionGroup.microphone], context,
                isOpenSettings: true, permissionGrant: () async {
              emit(
                  SocketConstants.connectCall,
                  ({
                    ArgParams.connectId: 2, //Receiver Id
                  }));
              NavigationUtils.push(context, RouteConstants.routePickUpScreen,
                  arguments: {
                    ArgParams.resCallAcceptModel:
                        ResCallAcceptModel(otherUserId: 2), //Receiver Id
                    ArgParams.resCallRequestModel: ResCallRequestModel(),
                    ArgParams.isForOutGoing: true,
                  });
            });
          },
        ),
      ),
    );
  }
}

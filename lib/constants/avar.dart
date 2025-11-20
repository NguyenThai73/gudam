import 'package:app_dong_ho/constants/dialog.show.image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_user/service_user.dart';

import '../confing.dart';
import '../main/cubit/user.change.cubit.dart';
import 'button.not.click.multi.dart';

class Avar extends StatelessWidget {
  const Avar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserChangeCubit, UserModel?>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: ClipOval(
                  child: (state != null && state.avatar != null && state.avatar != "")
                      ? ButtonNotClickMulti(
                        onTap: (){ context.showDialogImage("$baseUrlImage${state.avatar}");},
                        child: CachedNetworkImage(
                            imageUrl: "$baseUrlImage${state.avatar}",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                "assets/noavatar.png",
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                      )
                      : Image.asset(
                          "assets/noavatar.png",
                          fit: BoxFit.cover,
                        )),
            ),
            SizedBox(width: 15),
            Text(
              state?.fullName ?? "",
              style: TextStyle(fontSize: 16, color: Color(0xFF000000)),
            )
          ],
        );
      },
    );
  }
}

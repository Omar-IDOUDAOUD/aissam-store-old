import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/public/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        children: [
          _Header(),
          SizedBox(height: 40),
          _getSettingRow(
              'assets/icons/ic_fluent_person_24_regular.svg',
              'Account information',
              () => Get.toNamed('/settings/account_info')),
          _getDivider(),
          _getSettingRow(
              'assets/icons/ic_fluent_location_24_regular.svg',
              'Addresses information',
              () => Get.toNamed('/settings/user_addresses')),
          _getDivider(),
          _getSettingRow(
              'assets/icons/ic_fluent_payment_24_regular.svg', 'Payment'),
          _getDivider(),
          _getSettingRow('assets/icons/ic_fluent_weather_sunny_24_regular.svg',
              'Appearence', () => Get.toNamed('/settings/appearence')),
          _getDivider(),
          _getSettingRow('assets/icons/ic_fluent_alert_urgent_24_regular.svg',
              'Notifications', () => Get.toNamed('/settings/notifications')),
          Spacer(),
          Button(
            isOutline: true,
            isHeightMinimize: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LOGOUT',
                  style: Get.textTheme.headlineSmall!.copyWith(
                    color: ColorsConsts.a,
                  ),
                ),
                SvgPicture.asset(
                    'assets/icons/ic_fluent_sign_out_24_regular.svg'),
              ],
            ),
          ),
          SizedBox(
            height: 85,
          ),
        ],
      ),
    );
  }

  _getDivider() => SizedBox(
        height: 30,
        child: Center(
          child: Divider(
            color: Colors.grey.withOpacity(.5),
            height: 2,
          ),
        ),
      );

  _getSettingRow(String iconPath, String label, [Function()? onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            height: 25,
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: Get.textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: ColorsConsts.a,
            ),
          ),
          Spacer(),
          SvgPicture.asset(
            'assets/icons/ic_fluent_chevron_right_24_filled.svg',
            height: 20,
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fatima zahra',
                style: Get.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorsConsts.a,
                  height: 1,
                ),
              ),
              Text(
                'Good Morning',
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorsConsts.b,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(
            'assets/images/image_4.png',
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}

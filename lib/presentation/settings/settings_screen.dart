import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sodakkuapp/presentation/widgets/log_out_dialog_widget.dart';
import 'package:sodakkuapp/utils/constant.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: headerColor,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: headerComponentsColor,
            size: 16,
          ),
        ),
        elevation: headerElevation,
        title: Text("Settings", style: TextStyle(color: headerComponentsColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: SvgPicture.asset(
                  ordersvg,
                  colorFilter: ColorFilter.mode(appColor, BlendMode.srcIn),
                ),
                title: Text(
                  "Orders",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/order');
                },
              ),
              Divider(color: greyColor.shade400),
              ListTile(
                leading: SvgPicture.asset(
                  customersvg,
                  colorFilter: ColorFilter.mode(appColor, BlendMode.srcIn),
                ),
                title: Text(
                  "Customer Support & FAQ",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/customerSupport');
                },
              ),
              Divider(color: greyColor.shade400),
              ListTile(
                leading: SvgPicture.asset(
                  addresssvg,
                  colorFilter: ColorFilter.mode(appColor, BlendMode.srcIn),
                ),
                title: Text(
                  "Addresses",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/address');
                },
              ),
              Divider(color: greyColor.shade400),
              ListTile(
                leading: SvgPicture.asset(
                  refundssvg,
                  colorFilter: ColorFilter.mode(appColor, BlendMode.srcIn),
                ),
                title: Text(
                  "Refunds",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/refunds');
                },
              ),
              Divider(color: greyColor.shade400),
              ListTile(
                leading: SvgPicture.asset(
                  profilessvg,
                  colorFilter: ColorFilter.mode(appColor, BlendMode.srcIn),
                ),
                title: Text(
                  "Profile",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              Divider(color: greyColor.shade400),
              // ListTile(
              //   leading: Image.asset(suggestIcon),
              //   title: Text("Suggest Products",
              //       style: Theme.of(context).textTheme.displayMedium),
              //   trailing:
              //       Icon(Icons.arrow_forward_ios_rounded, color: greyColor),
              //   onTap: () {
              //     //  Navigator.pushNamed(context, '/profile');
              //   },
              // ),
              // Divider(
              //   color: greyColor.shade400,
              // ),
              ListTile(
                leading: SvgPicture.asset(
                  paymentsvg,
                  colorFilter: ColorFilter.mode(appColor, BlendMode.srcIn),
                ),
                title: Text(
                  "Payment management",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/paymentManagementScreen');
                },
              ),
              Divider(color: greyColor.shade400),
              ListTile(
                leading: SvgPicture.asset(
                  generalInfosvg,
                  colorFilter: ColorFilter.mode(appColor, BlendMode.srcIn),
                ),
                title: Text(
                  "General Info",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/generalPolicies');
                },
              ),
              Divider(color: greyColor.shade400),
              ListTile(
                leading: SvgPicture.asset(
                  notificationsvg,
                  colorFilter: ColorFilter.mode(appColor, BlendMode.srcIn),
                ),
                title: Text(
                  "Notifications",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
              Divider(color: greyColor.shade400),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  showLogOutDialog(context);
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Color(0xFFCE1717), width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFCE1717),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

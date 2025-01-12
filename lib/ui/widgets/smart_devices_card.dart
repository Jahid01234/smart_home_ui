import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmartDevicesCard extends StatelessWidget {
  final String smartDeviceName;
  final String iconPath;
  final bool powerOn;
  final void Function(bool)? onChanged;

  const SmartDevicesCard({
    super.key,
    required this.smartDeviceName,
    required this.iconPath,
    required this.powerOn,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: powerOn ? Colors.grey[900] : Colors.grey[200],
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // iconPath......
            Image.asset(
              iconPath,
              height: 50,
              color: powerOn ? Colors.white : Colors.black,
            ),

            // DeviceName + PowerOnOff/switch......
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                      smartDeviceName,
                      style:  TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: powerOn ? Colors.white: Colors.black,
                      ),
                    ),
                ),
                Transform.rotate(
                  angle: pi/2,
                  child: CupertinoSwitch(
                      value: powerOn,
                      onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

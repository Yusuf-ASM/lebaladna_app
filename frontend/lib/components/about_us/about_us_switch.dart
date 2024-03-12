import 'package:flutter/material.dart';

import '../../backend/shared_variables.dart';

class AboutUsSwitch extends StatefulWidget {
  final String switchName;
  final String switchKey;
  const AboutUsSwitch({super.key, required this.switchName, required this.switchKey});

  @override
  State<AboutUsSwitch> createState() => _AboutUsSwitchState();
}

class _AboutUsSwitchState extends State<AboutUsSwitch> {
  @override
  Widget build(BuildContext context) {
    bool switchValue = box.get(widget.switchKey);
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.switchName),
          box.get("chill")
              ? Switch(
                  splashRadius: 30.0,
                  value: switchValue,
                  onChanged: (value) {
                    setState(
                      () {
                        switchValue = value;
                        box.put(widget.switchKey, value);
                      },
                    );
                  },
                )
              : Switch(
                  activeColor: Colors.blueAccent,
                  activeTrackColor: Colors.grey.shade400,
                  inactiveThumbColor: Colors.blueGrey.shade600,
                  inactiveTrackColor: Colors.grey.shade400,
                  splashRadius: 30,
                  value: switchValue,
                  onChanged: (value) {
                    setState(
                      () {
                        switchValue = value;
                        box.put(widget.switchKey, value);
                      },
                    );
                  },
                ),
        ],
      ),
    );
  }
}

class AboutUsSwitchV2 extends StatefulWidget {
  final String switchName;
  final Function(bool value) callback;
  const AboutUsSwitchV2({
    super.key,
    required this.switchName,
    required this.callback,
  });

  @override
  State<AboutUsSwitchV2> createState() => _AboutUsSwitchV2State();
}

class _AboutUsSwitchV2State extends State<AboutUsSwitchV2> {
  bool switchValue = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.switchName,
            style: const TextStyle(fontSize: NormalTextSize),
          ),
          Switch(
            activeColor: Colors.blueAccent,
            activeTrackColor: Colors.grey.shade400,
            inactiveThumbColor: Colors.blueGrey.shade600,
            inactiveTrackColor: Colors.grey.shade400,
            splashRadius: 25,
            value: switchValue,
            onChanged: (value) {
              setState(() => switchValue = !switchValue);
              widget.callback(switchValue);
            },
          ),
        ],
      ),
    );
  }
}

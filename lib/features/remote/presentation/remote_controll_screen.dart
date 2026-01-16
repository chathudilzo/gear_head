import 'package:flutter/material.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:o3d/o3d.dart';

class RemoteControllScreen extends StatefulWidget {
  const RemoteControllScreen({super.key});

  @override
  State<RemoteControllScreen> createState() => _RemoteControllScreenState();
}

class _RemoteControllScreenState extends State<RemoteControllScreen> {
  final O3DController _o3dController = O3DController();
  bool _isLocked = true;
  double _currentExposure = 1.0;

  void _handleLockToggele() {
    setState(() {
      _isLocked = !_isLocked;
    });

    if (_isLocked) {
      _o3dController.cameraOrbit(45, 80, 15);
      _currentExposure = 0.2;
    } else {
      _o3dController.cameraOrbit(0, 85, 8);
      _currentExposure = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            const Text("FORD MUSTANG",
                style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w300)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                const Text("CONNECTED",
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.green,
                        fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.8,
                colors: [
                  AppColors.primaryAccent.withOpacity(0.05),
                  AppColors.background,
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
                flex: 3,
                child: O3D.asset(
                    src: "assets/models/low_poly_ford_mustang.glb",
                    controller: _o3dController,
                    autoPlay: false,
                    exposure: _currentExposure,
                    backgroundColor: Colors.transparent,
                    cameraOrbit: CameraOrbit(45, 80, 15))),
            Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.9), // Glass feel
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(40)),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 40,
                        offset: const Offset(0, -10),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildRemoteBtn(
                              isActive: _isLocked,
                              icon: _isLocked ? Icons.lock : Icons.lock_open,
                              label: _isLocked ? "LOCK" : "UNLOCK",
                              onPressed: () {
                                _handleLockToggele();
                              }),
                          _buildRemoteBtn(
                            isActive: false,
                            icon: Icons.lightbulb_outline,
                            label: "FLASH",
                            onPressed: () async {
                              List<String> animations =
                                  await _o3dController.availableAnimations();
                              print(animations);

                              // In a real car, this sends a signal to the ECU
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Lights Flashing...")),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildClimateButton(),
                    ],
                  ),
                ))
          ],
        ),
      ]),
    );
  }

  Widget _buildRemoteBtn(
      {required IconData icon,
      required String label,
      required bool isActive,
      required VoidCallback onPressed}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primaryAccent
                  : Colors.white.withOpacity(0.03),
              shape: BoxShape.circle,
              border:
                  Border.all(color: isActive ? Colors.white24 : Colors.white10),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                          color: AppColors.primaryAccent.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2)
                    ]
                  : [],
            ),
            child: Icon(icon,
                color: isActive ? Colors.black : Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
              fontSize: 10,
              letterSpacing: 1.5,
              color: isActive ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildClimateButton() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white10),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "INTERIOR TEMP",
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Text(
                "32^C",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("PRE-COOL CABIN"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          )
        ],
      ),
    );
  }
}

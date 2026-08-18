import 'package:flutter/material.dart';
import '../models/scene.dart';
import '../services/asset_service.dart';
import 'placeholder_image.dart';

class SceneViewer extends StatefulWidget {
  final Scene scene;
  final Function(String) onHotspotTapped;

  const SceneViewer({
    required this.scene,
    required this.onHotspotTapped,
    super.key,
  });

  @override
  State<SceneViewer> createState() => _SceneViewerState();
}

class _SceneViewerState extends State<SceneViewer> {
  String? selectedHotspotId;
  final Set<String> pressedHotspotIds = {};
  bool _hasLoggedInitialAsset = false;

  @override
  Widget build(BuildContext context) {
    if (!_hasLoggedInitialAsset) {
      _hasLoggedInitialAsset = true;
      AssetService.logAssetStatus(widget.scene.backgroundImage);
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedHotspotId = null;
        });
      },
      child: Container(
        color: const Color(0xFF0A1428),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            return Stack(
              children: [
                Positioned.fill(
                  child: PlaceholderImage(
                    assetPath: widget.scene.backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                ),
                ...widget.scene.hotspots.map((hotspot) {
                  return _buildHotspot(hotspot, screenWidth, screenHeight);
                }),
                if (selectedHotspotId != null)
                  _buildHotspotInfo(
                    widget.scene.hotspots
                        .firstWhere((h) => h.id == selectedHotspotId!),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHotspot(Hotspot hotspot, double screenWidth, double screenHeight) {
    final isSelected = selectedHotspotId == hotspot.id;
    final isPressed = pressedHotspotIds.contains(hotspot.id);
    
    final left = (hotspot.position.x * screenWidth) - hotspot.radius;
    final top = (hotspot.position.y * screenHeight) - hotspot.radius;

    return Positioned(
      left: left,
      top: top,
      width: hotspot.radius * 2,
      height: hotspot.radius * 2,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            pressedHotspotIds.add(hotspot.id);
          });
        },
        onTapUp: (_) {
          setState(() {
            pressedHotspotIds.remove(hotspot.id);
          });
        },
        onTapCancel: () {
          setState(() {
            pressedHotspotIds.remove(hotspot.id);
          });
        },
        onTap: () {
          setState(() {
            selectedHotspotId = hotspot.id;
          });
          widget.onHotspotTapped(hotspot.id);
        },
        child: Transform.scale(
          scale: isPressed ? 0.9 : 1.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? const Color(0xFF00D9FF).withValues(alpha: 0.4)
                      : const Color(0xFF00D9FF).withValues(alpha: 0.1),
                  border: Border.all(
                    color: const Color(0xFF00D9FF),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF00D9FF),
                    ),
                  ),
                ),
              ),
              if (isSelected)
                Positioned(
                  top: -40,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2847),
                      border: Border.all(color: const Color(0xFF00D9FF)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      hotspot.label,
                      style: const TextStyle(
                        color: Color(0xFF00D9FF),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHotspotInfo(Hotspot hotspot) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 100,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2847),
          border: Border.all(color: const Color(0xFF00D9FF), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              hotspot.label,
              style: const TextStyle(
                color: Color(0xFF00D9FF),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hotspot.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant SceneViewer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scene.id != widget.scene.id) {
      selectedHotspotId = null;
      AssetService.logAssetStatus(widget.scene.backgroundImage);
    }
  }
}

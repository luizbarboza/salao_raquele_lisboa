import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../util/window_size_class.dart';

class AdaptativeScaffold extends StatefulWidget {
  final List<AdaptativeScaffoldDestination> destinations;

  const AdaptativeScaffold({super.key, required this.destinations});

  @override
  AdaptativeScaffoldState createState() => AdaptativeScaffoldState();
}

class AdaptativeScaffoldState extends State<AdaptativeScaffold> {
  int _currentDestinationIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final windowSizeClass = WindowSizeClass.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 6,
            ),
            SvgPicture.asset(
              height: 32,
              "assets/rl.svg",
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Raquele Lisboa",
              style: TextStyle(
                fontSize: 22,
                color: colorScheme.onSurface,
              ),
            )
          ],
        ),
        //title: Text("Raquele Lisboa"),
      ),
      floatingActionButton: windowSizeClass == WindowSizeClass.compact
          ? widget.destinations
              .map((d) => d.fab._compact)
              .toList()[_currentDestinationIndex]
          : null,
      bottomNavigationBar: windowSizeClass == WindowSizeClass.compact
          ? NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  _currentDestinationIndex = index;
                });
              },
              selectedIndex: _currentDestinationIndex,
              destinations: widget.destinations.map((d) {
                return NavigationDestination(
                  icon: Icon(d.iconData),
                  selectedIcon: Icon(
                    d.iconData,
                    fill: 1,
                  ),
                  label: d.label,
                );
              }).toList(),
            )
          : null,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (windowSizeClass != WindowSizeClass.compact)
            NavigationRail(
              leading: widget.destinations
                  .map((d) => windowSizeClass != WindowSizeClass.medium
                      ? SizedBox(
                          width: 256,
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              d.fab._extended,
                              const Spacer(flex: 1),
                            ],
                          ),
                        )
                      : d.fab._medium)
                  .toList()[_currentDestinationIndex],
              extended: windowSizeClass != WindowSizeClass.medium,
              labelType: windowSizeClass == WindowSizeClass.medium
                  ? NavigationRailLabelType.all
                  : NavigationRailLabelType.none,
              onDestinationSelected: (int index) {
                setState(() {
                  _currentDestinationIndex = index;
                });
              },
              selectedIndex: _currentDestinationIndex,
              destinations: widget.destinations.map((d) {
                return NavigationRailDestination(
                  icon: Icon(d.iconData),
                  selectedIcon: Icon(
                    d.iconData,
                    fill: 1,
                  ),
                  label: Text(d.label),
                );
              }).toList(),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                windowSizeClass == WindowSizeClass.compact ? 16 : 0,
                windowSizeClass == WindowSizeClass.compact ? 16 : 0,
                16,
                16,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.destinations
                      .map((d) => d.body)
                      .toList()[_currentDestinationIndex]),
            ),
          ),
        ],
      ),
    );
  }
}

class AdaptativeScaffoldDestination {
  final String label;
  final IconData iconData;
  final AdaptativeScaffoldDestinationFab fab;
  final Widget body;

  AdaptativeScaffoldDestination({
    required this.label,
    required this.iconData,
    required this.fab,
    required this.body,
  });
}

class AdaptativeScaffoldDestinationFab {
  final String label;
  final IconData iconData;
  final void Function() onPressed;

  final FloatingActionButton _compact;
  final FloatingActionButton _medium;
  final FloatingActionButton _extended;

  AdaptativeScaffoldDestinationFab({
    required this.label,
    required this.iconData,
    required this.onPressed,
  })  : _compact = FloatingActionButton(
          heroTag: null,
          onPressed: onPressed,
          child: Icon(iconData),
        ),
        _medium = FloatingActionButton(
          heroTag: null,
          elevation: 0,
          onPressed: onPressed,
          child: Icon(iconData),
        ),
        _extended = FloatingActionButton.extended(
          heroTag: null,
          elevation: 0,
          label: Text(label),
          icon: Icon(iconData),
          onPressed: onPressed,
        );
}

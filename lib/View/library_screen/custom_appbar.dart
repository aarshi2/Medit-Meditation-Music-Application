import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> actions;
  final Function(String) onActionSelected;
  final String selectedAction;

  const CustomAppBar({
    super.key,
    required this.actions,
    required this.onActionSelected,
    required this.selectedAction,
  });

  @override
  Size get preferredSize => const Size.fromHeight(120.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.62),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Row(
          children: [

            SizedBox(width: 10),
            Text(
              'Your Library',
              style: TextStyle(color: Colors.white,),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle search icon press
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle add icon press
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: SizedBox(
            height: 50.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: actions.length,
              itemBuilder: (context, index) {
                return Center(
                  widthFactor: 1.1,
                  heightFactor: 1,
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: selectedAction == actions[index] ? Colors
                          .white12 : Colors.black.withOpacity(0.2),
                    ),
                    onPressed: () {
                      onActionSelected(actions[index]);
                    },
                    child: Text(actions[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
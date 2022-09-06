import 'package:flutter/material.dart';

class SnackBarSistem {
  SnackBar snackBarErrorGeneric(String message) {
    return SnackBar(
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(12),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2, color: Colors.white),
        ),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Center(
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Alert:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SnackBar snackBarAddSuccessGeneric(String message) {
    return SnackBar(
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(12),
        height: 90,
        decoration: BoxDecoration(
            color: const Color.fromARGB(237, 245, 242, 242),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: Colors.green)),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Center(
                child: Icon(
                  Icons.check_circle_outlined,
                  size: 35,
                  color: Colors.green,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Success:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SnackBar snackBarRemoveSuccessGeneric(String message) {
    return SnackBar(
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(12),
        height: 90,
        decoration: BoxDecoration(
            color: const Color.fromARGB(237, 245, 242, 242),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: Colors.green)),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Center(
                child: Icon(
                  Icons.delete_forever,
                  size: 35,
                  color: Colors.red,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Success:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

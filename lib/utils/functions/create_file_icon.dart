import 'package:flutter/material.dart';

Icon createFileIcon(String ext) {
  // print(ext);
  if (ext == "pdf") {
    return const Icon(
      Icons.picture_as_pdf_rounded,
      color: Colors.black,
    );
  } else if (ext == "png") {
    return const Icon(Icons.image, color: Colors.black);
  } else if (ext == "mp4") {
    return const Icon(Icons.video_library, color: Colors.black);
  } else if (ext == "mp3") {
    return const Icon(Icons.audio_file, color: Colors.black);
  } else if (ext == "txt") {
    return const Icon(Icons.text_snippet_rounded, color: Colors.black);
  } else if (ext == "docx") {
    return const Icon(Icons.edit_document, color: Colors.black);
  }
  return const Icon(
    Icons.file_copy_rounded,
    color: Colors.black,
  );
}

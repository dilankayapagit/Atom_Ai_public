import 'package:atomai/app_export.dart';

import '../models/image_style_model.dart';
import '../models/size_list_model.dart';

class ImageFilterConstant {
  static List<SizeListModel> sizeList = [
    SizeListModel(
      size: [512, 512],
      title: "512 * 512",
    ),
    SizeListModel(
      size: [512, 640],
      title: "512 * 640",
    ),
    SizeListModel(
      size: [512, 768],
      title: "512 * 768",
    ),
    SizeListModel(
      size: [512, 896],
      title: "512 * 896",
    ),
    SizeListModel(
      size: [768, 512],
      title: "768 * 512",
    ),
  ];

  static List<ImageStyleModel> imageList = [
    ImageStyleModel(
      id: "",
      img: ImageConstant.none,
      title: "None",
    ),
    ImageStyleModel(
      id: "3d-model",
      img: ImageConstant.d3Model,
      title: "3d-model",
    ),
    ImageStyleModel(
      id: "analog-film",
      img: ImageConstant.analogFilm,
      title: "analog-film",
    ),
    ImageStyleModel(
      id: "anime",
      img: ImageConstant.anime,
      title: "anime",
    ),
    ImageStyleModel(
      id: "cinematic",
      img: ImageConstant.cinematic,
      title: "cinematic",
    ),
    ImageStyleModel(
      id: "comic-book",
      img: ImageConstant.comicBook,
      title: "comic-book",
    ),
    ImageStyleModel(
      id: "digital-art",
      img: ImageConstant.digitalArt,
      title: "digital-art",
    ),
    // ImageStyleModel(
    //   id: "enhance",
    //   img: ImageConstant.en,
    //   title: "enhance",
    // ),
    ImageStyleModel(
      id: "fantasy-art",
      img: ImageConstant.fantasyArt,
      title: "fantasy-art",
    ),
    ImageStyleModel(
      id: "isometric",
      img: ImageConstant.isometric,
      title: "isometric",
    ),
    ImageStyleModel(
      id: "line-art",
      img: ImageConstant.lineArt,
      title: "line-art",
    ),
    ImageStyleModel(
      id: "low-poly",
      img: ImageConstant.lowPoly,
      title: "low-poly",
    ),
    // ImageStyleModel(
    //   id: "modeling-compound",
    //   img: ImageConstant.c,
    //   title: "modeling-compound",
    // ),
    ImageStyleModel(
      id: "neon-punk",
      img: ImageConstant.neonPunk,
      title: "neon-punk",
    ),
    ImageStyleModel(
      id: "origami",
      img: ImageConstant.origami,
      title: "origami",
    ),
    ImageStyleModel(
      id: "photographic",
      img: ImageConstant.photographic,
      title: "photographic",
    ),
    ImageStyleModel(
      id: "pixel-art",
      img: ImageConstant.pixelArt,
      title: "pixel-art",
    ),
    // ImageStyleModel(
    //   id: "tile-texture",
    //   img: ImageConstant.t,
    //   title: "tile-texture",
    // ),
  ];
}

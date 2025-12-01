import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUseCase implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlogUseCase({required this.blogRepository});

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      title: params.title,
      content: params.content,
      image: params.image,
      userId: params.userId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final File image;
  final String userId;
  final List<String> topics;

  UploadBlogParams({
    required this.title,
    required this.content,
    required this.image,
    required this.userId,
    required this.topics,
  });
}

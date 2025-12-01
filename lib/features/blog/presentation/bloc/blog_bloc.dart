import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase _uploadBlogUseCase;

  BlogBloc({required UploadBlogUseCase uploadBlogUseCase})
    : _uploadBlogUseCase = uploadBlogUseCase,
      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final response = await _uploadBlogUseCase(
      UploadBlogParams(
        title: event.title,
        content: event.content,
        image: event.image,
        userId: event.userId,
        topics: event.topics,
      ),
    );
    response.fold(
      (failure) => emit(BlogFailure(message: failure.message)),
      (blog) => emit(BlogSuccess()),
    );
  }
}

import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase _uploadBlogUseCase;
  final GetAllBlogsUseCase _getAllBlogsUseCase;

  BlogBloc({
    required UploadBlogUseCase uploadBlogUseCase,
    required GetAllBlogsUseCase getAllBlogsUseCase,
  }) : _uploadBlogUseCase = uploadBlogUseCase,
       _getAllBlogsUseCase = getAllBlogsUseCase,
       super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onBlogFetchAllBlogs);
  }

  void _onBlogFetchAllBlogs(
    BlogFetchAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    final response = await _getAllBlogsUseCase(NoParams());
    response.fold(
      (failure) => emit(BlogFailure(message: failure.message)),
      (blogs) => emit(BlogDisplaySuccess(blogs: blogs)),
    );
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
      (blog) => emit(BlogUploadSuccess()),
    );
  }
}

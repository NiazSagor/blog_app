import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlog());

  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  List<String> selectedTopics = [];

  @override
  void dispose() {
    textEditingController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  color: AppPallete.borderColor,
                  dashPattern: [20, 4],
                  radius: Radius.circular(10),
                  strokeCap: StrokeCap.round,
                ),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder_open_rounded, size: 50),
                      SizedBox(height: 15),
                      Text("Select your image", style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ["Technology", "Business", "Programming", "Entertainment"]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopics.contains(e)) {
                                    selectedTopics.remove(e);
                                  } else {
                                    selectedTopics.add(e);
                                  }
                                  setState(() {});
                                },
                                child: Chip(
                                  label: Text(e),
                                  color: selectedTopics.contains(e)
                                      ? const WidgetStatePropertyAll(
                                          AppPallete.gradient1,
                                        )
                                      : null,
                                  side: selectedTopics.contains(e)
                                      ? null
                                      : BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              BlogEditor(
                textEditingController: textEditingController,
                hintText: "Blog Title",
              ),
              SizedBox(height: 10),
              BlogEditor(
                textEditingController: contentController,
                hintText: "Blog Content",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

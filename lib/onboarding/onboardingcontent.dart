class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> content = [
  OnboardingContent(
    image:
        'https://img.freepik.com/free-vector/image-upload-concept-illustration_114360-798.jpg',
    title: 'Upload the issue',
    description:
        "Resolve the issue with proof of concept and make your surroundings clean",
  ),
  OnboardingContent(
    image:
        'https://img.freepik.com/free-vector/connected-world-concept-illustration_114360-3027.jpg',
    title: 'Connect them anywhere',
    description:
        "Always get connected to the authority to know the updates of your issue and society things",
  ),
  OnboardingContent(
    image:
        'https://cdn.dribbble.com/users/135634/screenshots/4843483/media/411a58b104e1dfb873d54cf1606a01ee.png?resize=400x300&vertical=center',
    title: 'Know the progress',
    description: "Track the progress of your issue and make moves accordingly",
  ),
];

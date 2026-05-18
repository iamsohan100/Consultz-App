class MessageData {
  static List<MessageModel> messageList = [
    MessageModel(
      qus: 'What is the main question you’d like answered?',
      ans:
          'The best strategies for investing in rental, properties in my local area especially concerning market trends and property management.',
    ),
    MessageModel(
      qus: 'What challenges or roadblocks are you facing?',
      ans:
          'I don’t know how to compare returns between residential and commercial properties or assess the risks involved in commercial real estate.',
    ),
    MessageModel(
      qus: 'Can you share some background or context?',
      ans:
          'I currently own two residential properties that generate steady rental income, but I’ve heard commercial properties can offer higher returns. I’m concerned about the risks and upfront costs.',
    ),
  ];
}

class MessageModel {
  String qus;
  String ans;

  MessageModel({required this.qus, required this.ans});
}

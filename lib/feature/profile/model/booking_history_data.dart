class BookingHistoryData {
  static List<BookingHistoryModel> bookingList = [
    BookingHistoryModel(
      name: 'Sam Jones',
      discussion: 'Discussion',
      amount: '£100.00',
      isCompleted: true,
    ),
    BookingHistoryModel(
      name: 'Ella Brown',
      discussion: 'Introduction',
      amount: '£25.00',
      isCompleted: false,
    ),
    BookingHistoryModel(
      name: 'Stella Lee ',
      discussion: 'Deep dive',
      amount: '£120.00',
      isCompleted: true,
    ),
    BookingHistoryModel(
      name: 'David Garcia',
      discussion: 'Deep dive',
      amount: '£120.00',
      isCompleted: true,
    ),
    BookingHistoryModel(
      name: 'Emma Smith',
      discussion: 'Discussion',
      amount: '£70.00',
      isCompleted: true,
    ),
    BookingHistoryModel(
      name: 'Sophie Anderson',
      discussion: 'Introduction',
      amount: '£120.00',
      isCompleted: false,
    ),
    BookingHistoryModel(
      name: 'Sam Jones',
      discussion: 'Discussion',
      amount: '£100.00',
      isCompleted: true,
    ),
  ];
  static List<BookingHistoryModel> completedBookingList = [
    BookingHistoryModel(
      name: 'Sam Jones',
      discussion: 'Discussion',
      amount: '£100.00',
      isCompleted: true,
    ),

    BookingHistoryModel(
      name: 'Stella Lee ',
      discussion: 'Deep dive',
      amount: '£120.00',
      isCompleted: true,
    ),
    BookingHistoryModel(
      name: 'David Garcia',
      discussion: 'Deep dive',
      amount: '£120.00',
      isCompleted: true,
    ),
    BookingHistoryModel(
      name: 'Emma Smith',
      discussion: 'Discussion',
      amount: '£70.00',
      isCompleted: true,
    ),

    BookingHistoryModel(
      name: 'Sam Jones',
      discussion: 'Discussion',
      amount: '£100.00',
      isCompleted: true,
    ),
  ];
  static List<BookingHistoryModel> pendingBookingList = [
    BookingHistoryModel(
      name: 'Stella Lee ',
      discussion: 'Deep dive',
      amount: '£120.00',
      isCompleted: false,
      isPending: true,
    ),
    BookingHistoryModel(
      name: 'David Garcia',
      discussion: 'Deep dive',
      amount: '£120.00',
      isCompleted: false,
      isPending: true,
    ),
  ];
}

class BookingHistoryModel {
  String name;
  String discussion;
  String amount;
  bool isCompleted;
  bool? isPending;
  BookingHistoryModel({
    required this.name,
    required this.discussion,
    required this.amount,
    required this.isCompleted,
    this.isPending,
  });
}

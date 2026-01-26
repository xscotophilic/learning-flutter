<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121049041-fc034900-c7d4-11eb-8a69-e51151dd377b.png" alt="Expenses"/>
</p>

`You can keep track of their daily expenditure by entering daily transactions.`

## Let's start with wireframing:

Our app will resemble the illustration below. Create application logic depending on how you want it to behave. There is no other approach for writing and constructing logic but trial and error, same with designing. It's difficult to keep track of everything I code. So I've done my best to explain everything. `You may follow the modifications and what I did in the commits step by step.`

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121049047-fc9bdf80-c7d4-11eb-8474-39a9a4922871.png" alt="Idea"/>
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121022098-aa03f880-c7bf-11eb-8d28-fb302d4ed656.png" alt="rough plan"/>
</p>

### Final Results:

  <p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/121034144-695dac80-c7ca-11eb-9a65-66c55b6f1292.gif" alt="everythingComesTogether"/>
  </p>

---

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121049036-fad21c00-c7d4-11eb-9b2a-18c99c492b75.png" alt="ShortAllusionToTheEntireThoughtAndCodingProcess"/>
</p>

- Decoding Transaction Cards

  - Break down the components and construct a widget tree according to it, then construct preliminary structure of widgets. After that Style the components. Wrap a component with Container for enhanced styling.

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120883450-de7a8780-c5fa-11eb-829d-cd29e5315c9e.png" alt="decodingTransactionCard"/>
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120884629-c0645580-c601-11eb-806c-bd213afda915.png" alt="tree"/>
</p>

- Building Basic Widgets:

  - Here we need 2 Cards (One for Chart and one for Transactions). So build a Column which have 2 children.

  - Initial commit for 2 cards: Commit [S3 basics and expenses app](https://github.com/xscotophilic/Learning-Flutter/commit/da28802bf4167dc0dcc1dbba548f87a378f63b72) (Search main.dart)

  - Transaction card design and Transaction model: Commit [S3 expenses 1.1.4 Transaction class and styling!](https://github.com/xscotophilic/Learning-Flutter/commit/b8b10960c2e335f6e1ab6da50a65415c3c717627)

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121028696-a5dad980-c7c5-11eb-9d6b-a7f93a20b897.jpg" alt="weirdDate"/>
</p>

- Formatting date and amount:

  - install [intl package](https://pub.dev/packages/intl).

  - Commit: [S3 expenses 1.1.5 formatting amount and date](https://github.com/xscotophilic/Learning-Flutter/commit/5317f527d8a6add2327d7745b8e36cdff6168533)

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121030399-0f0f1c80-c7c7-11eb-964d-619afaa63b66.jpg" alt="formattedDate"/>
</p>

- Input fields for adding new transaction:

  - Commit: [S3 expenses 1.1.6 input field added and code refactored.](https://github.com/xscotophilic/Learning-Flutter/commit/6263fb10abd2fa625728efa71f4e6d173a7d613e)

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121033558-ee949180-c7c9-11eb-9a6a-64f78b1bb985.gif" alt="InputField"/>
</p>

- SingleChildScrollView to solve error. If Device height is not what Expenses app is expecting/ when you open keyboard.

  - Commit: [S3 expenses 1.1.7 Scrollview for list](https://github.com/xscotophilic/Learning-Flutter/commit/e603122ca4ceb63e1a9a65e01f39501bc80d8fc7)

  <p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/121031369-e76c8400-c7c7-11eb-8d36-7b9857b3b026.jpg" alt="SingleChildScrollView"/>
  </p>

- Listview for Transaction List

  - [listview vs scrollview](https://stackoverflow.com/questions/62146197/what-is-the-difference-between-listview-and-singlechildscrollview-in-flutter)

  - Commit: [S3 expenses 1.1.8 Alternative listview](https://github.com/xscotophilic/Learning-Flutter/commit/2f112de7291e26c92bc3ee7f066a4ec6c8a6c201)

- Adding showModalBottomSheet for new transaction instead of showing it on main page.

  - S3 expenses 1.2.0 showModalBottomSheet added, refactored code, took care of new-transaction navigation

  - Commit: [S3 expenses 1.2.0](https://github.com/xscotophilic/Learning-Flutter/commit/805d6498b41b7a5e0129216a4d5afe9f75b1affd)

  <p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/121033912-374c4a80-c7ca-11eb-9d46-f6a11d6d5038.gif" alt="bottomwithoutchart"/>
  </p>

- Theming

  - [S3 expenses 1.2.1 theming, fonts, assets](https://github.com/xscotophilic/Learning-Flutter/commit/df7aa8756000db76dd7ae7bbd8bd3fbc88331089)

- Chart

  - Commit: [S3 expenses 1.2.2 Chart, getting recent transactions for chart](https://github.com/xscotophilic/Learning-Flutter/commit/62a65944f3c27e7ef216136b5b5ec0bbf147db07)

  - Commit: [S3 expenses 1.2.3 added Chart bars](https://github.com/xscotophilic/Learning-Flutter/commit/1837fe4d159aff2f00899aafa68773f2d63be543)

  <p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/121033137-8ba2fa80-c7c9-11eb-8205-5cb1b9216720.jpg" alt="Chart bars"/>
  </p>

- Deleting a transaction

  <p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/121034134-682c7f80-c7ca-11eb-931b-39c1392f1f0b.gif" alt="deletion"/>
  </p>

- Everything comes together:

  <p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/121034144-695dac80-c7ca-11eb-9a65-66c55b6f1292.gif" alt="everythingComesTogether"/>
  </p>

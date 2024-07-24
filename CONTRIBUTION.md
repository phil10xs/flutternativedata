# Contributing to Flutter Native Data Plugin

Thank you for considering contributing to the `flutternativedata` package! Your contributions help improve the project and make it more useful for everyone. Below are guidelines to help you get started.

## How to Contribute
### Reporting Bugs
If you find a bug, please report it by opening an issue in the [issue tracker](https://pub.dev/packages/flutternativedata/issues). Include as much detail as possible to help us diagnose and fix the issue quickly.


### Suggesting Enhancements
If you have an idea for a new feature or an enhancement, please open an issue in the [issue tracker](https://pub.dev/packages/flutternativedata/issues) and describe your suggestion. We welcome new ideas and discussions!

### Submitting Pull Requests
1. **Fork the Repository**: Click the "Fork" button at the top right of the repository page.
2. **Clone Your Fork**: Clone your forked repository to your local machine.

   ```sh
   git clone https://pub.dev/packages/flutternativedata.git
   cd flutternativedata
   ```

3. **Create a Branch**: Create a new branch for your feature or bug fix.

   ```sh
   git checkout -b feature-or-bugfix-branch
   ```
4. **Make Your Changes**: Implement your changes in the new branch. Ensure your code follows the project's coding style and conventions.
5. **Add Tests**: If applicable, add tests to cover your changes. This helps ensure the stability and reliability of the package.
6. **Commit Your Changes**: Commit your changes with a clear and descriptive commit message.

   ```sh
   git add .
   git commit -m "Description of your changes"
   ```
7. **Push Your Changes**: Push your changes to your forked repository.

   ```sh
   git push origin feature-or-bugfix-branch
   ```
8. **Open a Pull Request**: Go to the original repository and open a pull request. Provide a clear and detailed description of your changes.

### Code of Conduct
Please note that this project adheres to a [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

### Style Guide
- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style) for consistent code formatting.
- Use meaningful and descriptive variable, function, and class names.
- Document your code using comments and Dartdoc.

### Commit Messages
- Use the present tense ("Add feature" not "Added feature").
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...").
- Limit the first line to 72 characters or less.
- Reference issues and pull requests liberally after the first line.

### Running Tests
Before submitting your pull request, ensure that all tests pass. Run the tests using the following command:

```sh
flutter test
```

## Getting Help

If you need help, feel free to reach out by opening an issue in the [issue tracker](https://pub.dev/packages/flutternativedata/issues) or contacting us at [philipnduka92@gmail.com](mailto:philipnduka92@gmail.com).

## Acknowledgements

Thank you for your contributions! Your support and involvement help make `flutternativedata` a better package.

## Expected Features to Contribute

1. Separate Android and iOS data model
2. Add other data to andriod side - Kotlin eg   
  String serialNumber = androidInfo.serial;
  String macAddress = androidInfo.macAddress;
  String network = androidInfo.network;
  String imeiSlot1 = androidInfo.imei;  // Assuming you want the primary IMEI
  String imeiSlot2 = androidInfo.secondImei;
3. Unit Tests
4. Other features that can improve the package

---

_This document is subject to updates. Please review it periodically for the latest information._

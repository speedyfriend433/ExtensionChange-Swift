
# iPAPK

iPAPK is an iOS SwiftUI application that allows users to change the extension of `.ipa` files, view file information, and delete files.

## Key Features

- **File Selection**: Users can select `.ipa` files.
- **Change File Extension**: Allows users to change the extension of the selected file.
- **View File Information**: Displays the file size, creation date, and modification date.
- **Preview File Content**: Shows the content of the selected file (limited to text files).
- **Delete File**: Enables users to delete the selected file.
- **Recent Files**: Keeps track of recently selected files.
- **Change History**: Logs the history of file extension changes.

## Requirements

- iOS 16.6 or later
- Swift 5.0 or later

## Setup and Usage

1. **Clone the Repository**

    ```bash
    git clone https://github.com/speedyfriend433/ipapk.git
    cd ipapk
    ```

2. **Open the Project in Xcode**

    Open `iPAPK.xcodeproj` in Xcode.

3. **Configure the App**

    Ensure that your project is set up with the correct Team and Bundle Identifier in Xcode.

4. **Run the App**

    Select a simulator or a connected device and click the run button in Xcode.

## Code Explanation

### ContentView.swift

The main view of the app, implemented using SwiftUI. It includes functionalities for selecting files, changing file extensions, viewing file information, and deleting files.

### AppDelegate.swift

Handles document picker delegation for file selection.

### Info.plist

Includes the necessary permissions and configurations for the app.

```xml
<key>NSDocumentsUsageDescription</key>
<string>We need access to your documents to allow file selection and modification.</string>
```

## Additional Features

- **File Size Display**: Shows the size of the selected file.
- **File Information**: Displays the creation and modification dates of the file.
- **File Content Preview**: Previews the content of the selected text file.
- **Recent Files**: Lists the recently selected files.
- **Change History**: Records the history of file extension changes.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.

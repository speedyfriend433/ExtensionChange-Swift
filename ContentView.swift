//
// ContentView.swift
//
// Created by Speedyfriend67 on 25.06.24
//
 
import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var selectedFileURL: URL?
    @State private var newExtension: String = ""
    @State private var message: String = "No file selected"
    @State private var isDocumentPickerPresented = false
    @State private var recentFiles: [URL] = []
    @State private var changeHistory: [String] = []
    @State private var fileContent: String = ""
    @State private var fileInfo: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text(message)
                .padding()

            Button(action: {
                isDocumentPickerPresented = true
            }) {
                Text("Select File")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .fileImporter(
                isPresented: $isDocumentPickerPresented,
                allowedContentTypes: [UTType(filenameExtension: "ipa")!],
                allowsMultipleSelection: false
            ) { result in
                do {
                    let selectedFile = try result.get().first
                    if let fileURL = selectedFile {
                        self.selectedFileURL = fileURL
                        self.message = "Selected file: \(fileURL.lastPathComponent) (\(fileSizeString(from: fileURL)))"
                        self.fileInfo = fileInformation(from: fileURL)
                        self.fileContent = try String(contentsOf: fileURL, encoding: .utf8)
                        if !recentFiles.contains(fileURL) {
                            recentFiles.append(fileURL)
                        }
                    }
                } catch {
                    print("File selection error: \(error.localizedDescription)")
                }
            }

            TextField("Enter new extension", text: $newExtension)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            HStack {
                Button(action: changeExtension) {
                    Text("Change Extension")
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(selectedFileURL == nil || newExtension.isEmpty)

                Button(action: deleteFile) {
                    Text("Delete File")
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(selectedFileURL == nil)
            }

            if !fileInfo.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    Text("File Information:")
                        .font(.headline)
                    Text(fileInfo)
                }
                .padding()
            }

            if !fileContent.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    Text("File Content Preview:")
                        .font(.headline)
                    ScrollView {
                        Text(fileContent)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Recent Files:")
                    .font(.headline)
                ForEach(recentFiles, id: \.self) { file in
                    Text(file.lastPathComponent)
                }
            }
            .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text("Change History:")
                    .font(.headline)
                ForEach(changeHistory, id: \.self) { history in
                    Text(history)
                }
            }
            .padding()
        }
        .padding()
    }

    func changeExtension() {
        guard let fileURL = selectedFileURL else { return }
        let fileName = fileURL.deletingPathExtension().lastPathComponent
        let newFileName = fileName + "." + newExtension
        let newFileURL = fileURL.deletingLastPathComponent().appendingPathComponent(newFileName)

        do {
            try FileManager.default.moveItem(at: fileURL, to: newFileURL)
            message = "File renamed to \(newFileName)"
            selectedFileURL = newFileURL
            changeHistory.append("Renamed \(fileURL.lastPathComponent) to \(newFileName)")
        } catch {
            message = "Error renaming file: \(error)"
        }
    }

    func deleteFile() {
        guard let fileURL = selectedFileURL else { return }
        
        do {
            try FileManager.default.removeItem(at: fileURL)
            message = "File deleted: \(fileURL.lastPathComponent)"
            selectedFileURL = nil
            fileContent = ""
            fileInfo = ""
            if let index = recentFiles.firstIndex(of: fileURL) {
                recentFiles.remove(at: index)
            }
        } catch {
            message = "Error deleting file: \(error)"
        }
    }

    func fileSizeString(from url: URL) -> String {
        do {
            let resourceValues = try url.resourceValues(forKeys: [.fileSizeKey])
            if let fileSize = resourceValues.fileSize {
                return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
            } else {
                return "Unknown size"
            }
        } catch {
            return "Unknown size"
        }
    }

    func fileInformation(from url: URL) -> String {
        do {
            let resourceValues = try url.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
            let creationDate = resourceValues.creationDate ?? Date()
            let modificationDate = resourceValues.contentModificationDate ?? Date()
            return """
            Creation Date: \(creationDate)
            Modification Date: \(modificationDate)
            """
        } catch {
            return "No information available"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
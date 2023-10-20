//
//  ShareViewController.swift
//  HighlighterShareExtension
//
//  Created by Andy Trinh on 9/21/23.
//


import UIKit
import Social
import Firebase


class ShareViewController: SLComposeServiceViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the item provider for text
        if let item = extensionContext?.inputItems.first as? NSExtensionItem,
           let itemProvider = item.attachments?.first as? NSItemProvider,
           itemProvider.hasItemConformingToTypeIdentifier("public.plain-text") {
            
            itemProvider.loadItem(forTypeIdentifier: "public.plain-text", options: nil) { [weak self] (result, error) in
                if let text = result as? String {
                    self?.uploadTextToFirebase(text)
                }
            }
        }
    }

    func uploadTextToFirebase(_ text: String) {
        // Your Firebase Realtime Database code here.
        // For example:
        let dbRef = Database.database().reference().child("highlights")
        dbRef.childByAutoId().setValue(["content": text]) { (error, _) in
            if let error = error {
                print("Error uploading to Firebase: \(error)")
            }
            self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        }
    }


}

//
//  ShareViewController.swift
//  HighlighterShareExtension
//
//  Created by Andy Trinh on 9/21/23.
//


import UIKit
import Social
import MobileCoreServices
import UniformTypeIdentifiers
import Firebase
import HighlighterShared


class ShareViewController: SLComposeServiceViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            // Initialize Firebase
            FirebaseApp.configure()

            if let item = extensionContext?.inputItems.first as? NSExtensionItem {
                if let textItemProvider = item.attachments?.first as? NSItemProvider {
                    if textItemProvider.hasItemConformingToTypeIdentifier(UTType.plainText.identifier) {
                        textItemProvider.loadItem(forTypeIdentifier: UTType.plainText.identifier, options: nil, completionHandler: { [weak self] (text, error) in
                            DispatchQueue.main.async {
                                if let sharedText = text as? String {
                                    // Handle text
                                    let newHighlight = Highlight(source: "External App", content: sharedText, labels: [])
                                    self!.uploadHighlight(highlight: newHighlight)
                                    print(sharedText)
                                }
                                self?.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                            }
                        })
                    }
                }
            }
        }
    
    override func didSelectPost() {
        print("Posted")
//        if let contentText = self.contentText {
//                print(contentText)
//                let userDefaults = UserDefaults(suiteName: "group.com.yourcompany.TextShareApp")
//                        userDefaults?.set(contentText, forKey: "sharedText")
//                        userDefaults?.synchronize()  // Force saving
//                // Handle the shared content as you wish, e.g., save it, send to server, etc.
//            }
//
//        // Inform the host app that we're done
//        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }

    func uploadHighlight(highlight: Highlight) {
        let dbRef = Database.database().reference()
        let highlightRef = dbRef.child("highlights").child(highlight.id.uuidString)
        
        do {
            let data = try JSONEncoder().encode(highlight)
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                highlightRef.setValue(json)
            }
        } catch {
            print("Error encoding highlight: \(error)")
        }
    }


}

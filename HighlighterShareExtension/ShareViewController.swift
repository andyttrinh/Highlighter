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
import SwiftUI




class ShareViewController: UIViewController {
    
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
                                let newHighlight = Highlight(source: "External App", content: sharedText, labels: [])
                                self!.uploadHighlight(highlight: newHighlight)
                                print(sharedText)
                                // Handle your text and do other necessary actions here
                                // Only when you want to dismiss your extension, call the completion handler
//                                 self?.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                            }
                        }
                    })
                }
            }
        }
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
    
    func hostingControllerForShareExtensionView() -> UIViewController {
        let view = ShareExtensionView()
        let hostingController = UIHostingController(rootView: view)
        return hostingController
    }
    
    override func loadView() {
        super.loadView()  // Call the super implementation
        
        let uiHostingController = hostingControllerForShareExtensionView()
        
        // Add the hosting controller as a child view controller
        self.addChild(uiHostingController)
        self.view.addSubview(uiHostingController.view)
        
        // Set up constraints to make the hosting controller's view fill the entire view
        uiHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        uiHostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        uiHostingController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        uiHostingController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        uiHostingController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        // Call the necessary containment methods
        uiHostingController.didMove(toParent: self)
    }





}

//
//  HighlighterApp.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI
import FirebaseCore
import Firebase
import HighlighterShared




class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct HighlighterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var highlights = Highlights(items: [])
    @StateObject private var globalLabels = Labels(items: [])

    var body: some Scene {
        WindowGroup {
            HighlightsView(highlights: highlights, globalLabels: globalLabels, fetchHighlights: fetchAllHighlights)
                .onAppear {
                    fetchAllHighlights { fetchedHighlights in
                        self.highlights.replaceItems(items: fetchedHighlights)
                        print(fetchedHighlights)
                    }
                    
                    fetchAllLabels { fetchedLabels in
                            self.globalLabels.items = fetchedLabels
                            print(fetchedLabels)
                        }
                }
        }
    }
    
    func fetchAllHighlights(completion: @escaping ([Highlight]) -> Void) {
        let dbRef = Database.database().reference().child("highlights")
        
        dbRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String: [String: Any]] else {
                completion([])
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                let highlightsDict = try JSONDecoder().decode([String: Highlight].self, from: jsonData)

                // Provide default values for any nil labels arrays
                for (key, highlight) in highlightsDict {
                    if highlight.labels == nil {
                        highlightsDict[key]?.labels = []
                    }
                }

                completion(Array(highlightsDict.values))
            } catch {
                print("Error decoding highlights: \(error)")
                completion([])
            }

        }
    }
    
    func fetchAllLabels(completion: @escaping ([HighlighterShared.Label]) -> Void) {
        let dbRef = Database.database().reference().child("globalLabels")
        
        dbRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion([])
                return
            }
            
            var fetchedLabels: [HighlighterShared.Label] = []
            
            for labelData in value {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: labelData, options: .prettyPrinted)
                    let label = try JSONDecoder().decode(Label.self, from: jsonData)
                    fetchedLabels.append(label)
                } catch {
                    print("Error decoding label: \(error)")
                }
            }
            
            completion(fetchedLabels)
        }
    }

}

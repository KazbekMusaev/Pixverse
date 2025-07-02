//
//  SettingSwiftUIView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 02.07.2025.
//

import SwiftUI

struct SettingSwiftUIView: View {
    @State private var notificationsEnabled = false
    @State private var cacheSize: String = "5 MB"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Support us")) {
                    NavigationLink(destination: Text("Rate App View")) {
                        Label("Rate app", systemImage: "star")
                    }
                    NavigationLink(destination: Text("Share View")) {
                        Label("Share with friends", systemImage: "square.and.arrow.up")
                    }
                }

                Section(header: Text("Purchases & Actions")) {
                    NavigationLink(destination: Text("Upgrade Plan View")) {
                        Label("Upgrade plan", systemImage: "arrow.up.circle")
                    }

                    Toggle(isOn: $notificationsEnabled) {
                        Label("Notifications", systemImage: "bell")
                    }

                    HStack {
                        Label("Clear cache", systemImage: "trash")
                        Spacer()
                        Text(cacheSize)
                            .foregroundColor(.secondary)
                    }

                    NavigationLink(destination: Text("Restore Purchases View")) {
                        Label("Restore purchases", systemImage: "arrow.clockwise")
                    }
                }

                Section(header: Text("Info & legal")) {
                    NavigationLink(destination: Text("Contact Us View")) {
                        Label("Contact us", systemImage: "envelope")
                    }
                    NavigationLink(destination: Text("Privacy Policy View")) {
                        Label("Privacy Policy", systemImage: "doc.text")
                    }
                    NavigationLink(destination: Text("Usage Policy View")) {
                        Label("Usage Policy", systemImage: "doc.plaintext")
                    }
                }
            }
        }
    }
}


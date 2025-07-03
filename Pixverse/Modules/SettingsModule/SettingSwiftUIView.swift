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
    @State private var notificationIsOn: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Section(header: SectionLabel(text: "Support us")) {
                    SettingsBtn(isSystemPhoto: true, image: "star", text: "Rate app") {
                        print("")
                    }
                    SettingsBtn(isSystemPhoto: true, image: "square.and.arrow.up", text: "Share with friends") {
                        print("")
                    }
                }
                Section(header: SectionLabel(text: "Purchases & Actions")) {
                    SettingsBtn(isSystemPhoto: false, image: "sparklesWithGradient", text: "Upgrade plan") {
                        print("")
                    }
                    Button {
                        notificationIsOn.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "bell")
                                .foregroundStyle(.accentPrimary)
                            Text("Notifications")
                                .foregroundStyle(.labelPrimary)
                                .font(.system(size: 17))
                            Spacer()
                            Toggle("", isOn: $notificationIsOn)
                        }
                    }
                    
                    Button {
                        print("clear cashe")
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundStyle(.accentPrimary)
                            Text("Clear cache")
                                .foregroundStyle(.labelPrimary)
                                .font(.system(size: 17))
                            Spacer()
                            Text(cacheSize)
                                .foregroundStyle(.labelPrimary)
                                .font(.system(size: 17))
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.labelQuaternary)
                        }
                    }
                    
                    SettingsBtn(isSystemPhoto: true, image: "arrow.clockwise.icloud", text: "Restore purchases") {
                        print("")
                    }
                }
                Section(header: SectionLabel(text: "Info & legal")) {
                    SettingsBtn(isSystemPhoto: true, image: "text.bubble", text: "Contact us") {
                        print("")
                    }
                    SettingsBtn(isSystemPhoto: true, image: "folder.badge.person.crop", text: "Privacy Policy") {
                        print("")
                    }
                    SettingsBtn(isSystemPhoto: true, image: "doc.text", text: "Usage Policy") {
                        print("")
                    }

                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.background)
        }
    }
}


#Preview {
    SettingSwiftUIView()
}

struct SettingsBtn: View {
    let isSystemPhoto: Bool
    let image: String
    let text: String
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if isSystemPhoto {
                    Image(systemName: image)
                        .foregroundStyle(.accentPrimary)
                } else {
                    Image(image)
                        .foregroundStyle(.accentPrimary)
                }
                Text(text)
                    .foregroundStyle(.labelPrimary)
                    .font(.system(size: 17))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.labelQuaternary)
            }
        }
    }
}

struct SectionLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundStyle(Color.labelSecondary)
            .font(.system(size: 14, weight: .semibold))
    }
}

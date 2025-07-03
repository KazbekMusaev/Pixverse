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
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    SectionLabel(text: "Support us")
                    Spacer()
                }
                .padding(.leading, 16)
                SettingsBtn(isSystemPhoto: true, image: "star", text: "Rate us") {
                    print("rate us taped")
                }
                .padding(.horizontal, 16)
                SettingsBtn(isSystemPhoto: true, image: "square.and.arrow.up", text: "Share with friends") {
                    print("share taped taped")
                }
                .padding(.horizontal, 16)
                
                HStack {
                    SectionLabel(text: "Purchases & Actions")
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.top, 28)
                
                SettingsBtn(isSystemPhoto: false, image: "sparklesWithGradient", text: "Upgrade plan") {
                    print("Upgrade plan taped")
                }
                .padding(.horizontal, 16)
                
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
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.backgroundPrimaryAlpha)
                )
                .padding(.horizontal, 16)
                
                
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
                    .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.backgroundPrimaryAlpha)
                )
                .padding(.horizontal, 16)
                
                SettingsBtn(isSystemPhoto: true, image: "arrow.clockwise.icloud", text: "Restore purchases") {
                    print("Restore purchases taped")
                }
                .padding(.horizontal, 16)
                
                HStack {
                    SectionLabel(text: "Info & legal")
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.top, 28)
                
                SettingsBtn(isSystemPhoto: true, image: "text.bubble", text: "Contact us") {
                    print("Contact us taped")
                }
                .padding(.horizontal, 16)
                
                SettingsBtn(isSystemPhoto: true, image: "folder.badge.person.crop", text: "Privacy Policy") {
                    print("Privacy Policy taped")
                }
                .padding(.horizontal, 16)
                
                SettingsBtn(isSystemPhoto: true, image: "doc.text", text: "Usage Policy") {
                    print("Usage Policy taped")
                }
                .padding(.horizontal, 16)
                
                HStack {
                    Spacer()
                    Text("App Version: 1.0.0")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.labelTertiary)
                    Spacer()
                }
                .padding(.top, 24)
                
                VStack {}
                .frame(height: 116)
                .frame(maxWidth: .infinity)
                .background(Color.background)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.background)
        .padding(.top, 116)
    }
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
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.backgroundPrimaryAlpha)
            )
        }
    }
}

struct SectionLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundStyle(Color.labelSecondary)
            .font(.system(size: 17, weight: .semibold))
    }
}

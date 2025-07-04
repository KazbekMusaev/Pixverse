//
//  SettingViewModel.swift
//  Pixverse
//
//  Created by KazbekMusaev on 03.07.2025.
//

import Foundation

final class SettingViewModel: ObservableObject {
    @Published var notificationsEnabled = false
    @Published var cacheSize: String = "5 MB"
    @Published var notificationIsOn: Bool = false
    
    weak var presenter: SettingsPresenterProtocol?
    
    deinit {
        print("destroi ArchiveDocumentWriteOffLoadViewModel")
    }
}

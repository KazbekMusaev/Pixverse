//
//  ImagePickerManager.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit
import AVFoundation
import Photos

final class ImagePickerManager: NSObject {
    
    private weak var viewController: UIViewController?
    private var imagePicked: ((UIImage?) -> Void)?
    
    init(viewController: UIViewController? = nil, imagePicked: ( (UIImage?) -> Void)? = nil) {
        self.viewController = viewController
        self.imagePicked = imagePicked
    }
    
    private func checkCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            openCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    granted ? self?.openCamera() : self?.showSettingsAlert(for: .camera)
                }
            }
        default:
            showSettingsAlert(for: .camera)
        }
    }
    
    private func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            openGallery()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                DispatchQueue.main.async {
                    status == .authorized ? self?.openGallery() : self?.showSettingsAlert(for: .gallery)
                }
            }
        default:
            showSettingsAlert(for: .gallery)
        }
    }
    
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert(title: "Ошибка", message: "Камера недоступна")
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        viewController?.present(picker, animated: true)
    }
    
    func openGallery() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        viewController?.present(picker, animated: true)
    }
    
    private func showSettingsAlert(for type: MediaType) {
        let title = type == .camera ? "Доступ к камере" : "Доступ к галерее"
        let message = "Пожалуйста, разрешите доступ в настройках"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Настройки", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingsUrl)
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        viewController?.present(alert, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController?.present(alert, animated: true)
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
        picker.dismiss(animated: true) {
            self.imagePicked?(image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

enum MediaType {
    case camera, gallery
}

//
//  SettingViewController.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/13.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var captionSizeSegment: UISegmentedControl!
    @IBOutlet weak var captionColorSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }
    
    private func initLayout() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.settingView.layer.cornerRadius = 20
        self.settingView.layer.masksToBounds = true
        loadSettings() // UserDefault에서 기존 설정 정보 불러옴
    }
    
    private func loadSettings() {
        guard let initial = UserManager.shared.settingInfo else { return }
        self.urlTextField.text = initial.url
        self.captionSizeSegment.selectedSegmentIndex = initial.caption.size.rawValue
        self.captionColorSegment.selectedSegmentIndex = initial.caption.color.rawValue
    }
    
    private func saveSettings() {
        if let settingInfo = settingInfo {
            let encoded = JsonManager.shared.encode(from: settingInfo) // Json 형태로 인코딩하여 저장
            UserDefaults.standard.setValue(encoded, forKey: "setting")
        }
    }
    
    var settingInfo: SettingInfo? {
        get {
            guard let url = self.urlTextField.text,
                  let captionSize = CaptionSize(rawValue: self.captionSizeSegment.selectedSegmentIndex),
                  let captionColor = CaptionColor(rawValue: self.captionColorSegment.selectedSegmentIndex) else {
                return nil
            }
            return SettingInfo(url: url, caption: CaptionSetting(size: captionSize, color: captionColor))
        }
    }
    
    @IBAction func didTouchedCancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTouchedSaveButton(_ sender: Any) {
        saveSettings()
        self.dismiss(animated: true)
    }
}

//
//  Extension+UIImageView.swift
//  TestRnM
//
//  Created by Anderen on 02.04.2025.
//

import Kingfisher
import UIKit

extension UIImageView {

    func setImage(with imageURL: URL?) {
        kf.setImage(with: imageURL)
    }

    func cancelDownloadTask() {
        kf.cancelDownloadTask()
    }
}

//
//  PreviewImage_Extension.swift
//  Befamily_Preview
//
//  Created by Jung Hwan Park on 2023/01/09.
//

import Foundation
import UIKit

extension PreviewImage
{
    var imageID: String
    {
        return id ?? UUID().uuidString
    }
    
    var linkView: String
    {
        link ?? ""
    }
    
    var uiImage: UIImage
    {
        if !self.linkView.isEmpty, let image = FileManager().loadImage(with: imageID)
        {
            return image
        }
        else
        {
            return UIImage(systemName: "photo")!
        }
    }
}

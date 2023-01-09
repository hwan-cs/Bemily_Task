//
//  PreviewViewModel.swift
//  Befamily_Preview
//
//  Created by Jung Hwan Park on 2023/01/09.
//

import Foundation
import UIKit

class PreviewViewModel: ObservableObject
{
    @Published var link = ""
    @Published var img: UIImage
    
    var id: String?
    
    init(_ img: UIImage)
    {
        self.img = img
    }
    
    init(_ previewImg: PreviewImage)
    {
        link = previewImg.linkView
        id = previewImg.imageID
        img = previewImg.uiImage
    }
}


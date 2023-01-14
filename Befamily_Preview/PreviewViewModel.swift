//
//  PreviewViewModel.swift
//  Befamily_Preview
//
//  Created by Jung Hwan Park on 2023/01/09.
//

import Foundation
import SwiftUI
import UIKit
import Combine

class PreviewViewModel: ObservableObject
{
    @Published var imgArray: [PreviewImage] = []
    
    let fileManager = FileManager()
    
    func addImage(url: String)
    {
        withAnimation
        {
            let newImage = PreviewImage(context: PreviewImageContainer.shared.viewContext)
            newImage.link = url
            newImage.id = UUID().uuidString
            /// 사진 다운받기
            fileManager.saveImage(with: newImage)
            PreviewImageContainer.shared.saveData()
        }
    }
    
    func save()
    {
        PreviewImageContainer.shared.saveData()
    }
    
    func getAllImages()
    {
        self.imgArray = PreviewImageContainer.shared.fetchSavedImages()
    }
}


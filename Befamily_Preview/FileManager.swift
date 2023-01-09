//
//  FileManager.swift
//  Befamily_Preview
//
//  Created by Jung Hwan Park on 2023/01/09.
//

import Foundation
import UIKit

extension FileManager
{
    func loadImage(with id: String) -> UIImage?
    {
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
        do
        {
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        }
        catch
        {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveImage(with id : String)
    {
        self.downloadImage(id)
        { img in
            /// If image is system image, then a fail has occured downloading the image, so no need to save image in directory
            if img == UIImage(systemName: "photo")!
            {
                return
            }
            else
            {
                if let data = img.jpegData(compressionQuality: 1.0)
                {
                    do
                    {
                        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
                        try data.write(to: url)
                    }
                    catch
                    {
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    print("Could not save image")
                }
            }
        }
    }
    
    func downloadImage(_ url: String, completion: @escaping (_ img: UIImage) -> Void)
    {
        DispatchQueue.global(qos: .background).async
        {
            if let imageUrl = URL(string: url)
            {
                URLSession.shared.dataTask(with: imageUrl)
                { (data, res, err) in
                    if let _ = err
                    {
                        completion(UIImage(systemName: "photo")!)
                    }
                    DispatchQueue.main.async
                    {
                        if let data = data, let image = UIImage(data: data)
                        {
                            completion(image)
                        }
                    }
                }.resume()
            }
        }
    }
}


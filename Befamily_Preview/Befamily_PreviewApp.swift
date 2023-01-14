//
//  Befamily_PreviewApp.swift
//  Befamily_Preview
//
//  Created by Jung Hwan Park on 2023/01/09.
//

import SwiftUI

@main
struct Befamily_PreviewApp: App
{
    var body: some Scene
    {
        WindowGroup
        {
            PreviewScreenView()
                .environment(\.managedObjectContext, PreviewImageContainer.shared.viewContext)
        }
    }
}

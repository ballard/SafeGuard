//
//  FrameView.swift
//  SafeGuard
//
//  Created by ISLAZAREV on 23.06.2022.
//

import SwiftUI

struct FrameView: View {
    
    @EnvironmentObject var camera: CameraManager
    
    var body: some View {
        // 2
        ZStack {
            GeometryReader { geometry in
                CameraPreview(
                    size: geometry.size
                )
                .environmentObject(camera)
            }
        }
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}

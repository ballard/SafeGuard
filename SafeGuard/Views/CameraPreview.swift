//
//  CameraPreview.swift
//  SafeGuard
//
//  Created by ISLAZAREV on 25.06.2022.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
    
    @EnvironmentObject var cameraModel: CameraManager
    var size: CGSize
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        cameraModel.preview = AVCaptureVideoPreviewLayer(session: cameraModel.session)
        cameraModel.preview.frame.size = size
        cameraModel.preview.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(cameraModel.preview)
//        cameraModel.session.startRunning()
        
        return view
    }
    
    
}

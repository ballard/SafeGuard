import AVFoundation
import CoreMedia

class CameraManager: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate {
    
    enum Status {
        case unconfigured
        case configured
        case unauthorized
        case failed
    }
    
    static let shared = CameraManager()
    
    @Published var error: CameraError?
    
    let session = AVCaptureSession()
    
    private let sessionQueue = DispatchQueue(label: "com.raywenderlich.SessionQ")
    
    private let output = AVCaptureMovieFileOutput()
    
    @Published private (set) var isRecording = false
    
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    @Published var recordedUrl: URL?
    
    @Published var showPreview = false 
    
    private var status = Status.unconfigured
    
    private override init() {
        super.init()
        
//        FrameManager.shared.didSendBuffer = { [weak self] output, sampleBuffer, connection in
//            self?.captureOutput(output, didOutput: sampleBuffer, from: connection)
//        }
        
//        configure()
    }
    
    private func set(error: CameraError?) {
        DispatchQueue.main.async {
            self.error = error
        }
    }
    
    private func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video) { authorized in
                if !authorized {
                    self.status = .unauthorized
                    self.set(error: .deniedAuthorization)
                }
                self.sessionQueue.resume()
            }
        case .restricted:
            status = .unauthorized
            set(error: .restrictedAuthorization)
        case .denied:
            status = .unauthorized
            set(error: .deniedAuthorization)
        case .authorized:
            break
        @unknown default:
            status = .unauthorized
            set(error: .unknownAuthorization)
        }
    }
    
    private func configureCaptureSession() {
        
        guard status == .unconfigured else {
            return
        }
        
        session.beginConfiguration()
        
        defer {
            session.commitConfiguration()
        }
        
        let device = AVCaptureDevice.default(
            .builtInDualWideCamera,
            for: .video,
            position: .back)
        
        let audioDevice = AVCaptureDevice.default(for: .audio)
        
        guard let camera = device,
                let audio = audioDevice else {
            set(error: .cameraUnavailable)
            status = .failed
            return
        }
        
        do {
            
            let videoInput = try AVCaptureDeviceInput(device: camera)
            let audioInput = try AVCaptureDeviceInput(device: audio)
            
            if session.canAddInput(videoInput) && session.canAddInput(audioInput) {
                session.addInput(videoInput)
                session.addInput(audioInput)
            } else {
                set(error: .cannotAddInput)
                status = .failed
                return
            }
            
        } catch {
            set(error: .createCaptureInput(error))
            status = .failed
            return
        }
        
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        
        status = .configured
    }
    
    func configure() {
        checkPermissions()
        
        sessionQueue.async {
            self.configureCaptureSession()
            self.session.startRunning()
            DispatchQueue.main.async {
                self.startRecording()
            }
        }
    }
    
    func startRecording() {
        let tempUrl = NSTemporaryDirectory() + "\(Date()).mov"
        let url = URL(fileURLWithPath: tempUrl)
        output.startRecording(to: url, recordingDelegate: self)
        isRecording = true
    }
    
    func stopRecording() {
        output.stopRecording()
        isRecording = false
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        print(outputFileURL)
        recordedUrl = outputFileURL
    }
}

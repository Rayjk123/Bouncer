//Taken from Hacking From Swift
//URL: https://www.hackingwithswift.com/example-code/media/how-to-scan-a-qr-code
//

import Firebase
import AVFoundation
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    private lazy var inviteRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "codes")
    private var inviteRefHandle: FIRDatabaseHandle?
    var deletedValue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //inviteRef.child("123456").setValue("123456")
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        captureSession.startRunning();
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning();
        }
        inviteRef.removeAllObservers()
        
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: readableObject.stringValue);
        }
        
        //dismiss(animated: true)
    }
    
    func found(code: String) {
        var handle: UInt = 0
        print(code)
        let viewController = ValidQRViewController()
        handle = inviteRef.observe(.value, with: { (snapshot) in
            if(snapshot.hasChild(code)){  //The code exists in the database
                viewController.valid = true
                print("Entered Valid")
                self.inviteRef.child(code).removeValue()
                self.inviteRef.removeObserver(withHandle: handle)
                self.present(viewController, animated: true, completion: nil)
                self.deletedValue = true
            }
            else{                         //The code does not exist int he database
                if(self.deletedValue == false){
                    viewController.valid = false
                    print("Entered Invalid")
                    self.present(viewController, animated: true, completion: nil)
                }
                else{
                    self.deletedValue = false
                }
            }
        })
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

//
//  RecordViewController.swift
//  TU20 App
//
//  Created by Alexsia Louizos on 2018-07-16.
//  Copyright © 2018 Dean Louizos. All rights reserved.
//


import UIKit
import AVKit
import MobileCoreServices

import AVFoundation

class RecordViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
    
    
    var countdownLabel = UILabel()


    
    var recordCountdown: Int = 5;
    var recordTime: Double = 5.0;
    var cameraView: UIView!
    
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var movieOutput = AVCaptureMovieFileOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    var textTimer = Timer()
    var flashTimer = Timer()
    var shouldRecord = false;
    var flashCount = 0;
    
    override func viewDidLoad() {
         textTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self,   selector: (#selector(RecordViewController.updateTimer)), userInfo: nil, repeats: true)
        flashTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self,   selector: (#selector(RecordViewController._toggleFlash)), userInfo: nil, repeats: true)
        print("Init Timer")
        initCamera()
        
        countdownLabel.text = String(recordCountdown+1);
        countdownLabel.frame.size = CGSize(width: 200, height: 200)
        countdownLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.width/2)
        countdownLabel.font = UIFont(name: "Helvetica", size: 80)
        countdownLabel.textColor = #colorLiteral(red: 0.09411764706, green: 0.2470588235, blue: 0.4, alpha: 1)
        countdownLabel.textAlignment = .center
        view.addSubview(countdownLabel)
        
        
    }
    
    
    
    
    func initCamera() {
        
        
        self.cameraView = self.view
        
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if device.position == AVCaptureDevice.Position.back{
                
                
                do{
                    
                    let input = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
                    
                    if captureSession.canAddInput(input){
                        
                        captureSession.addInput(input)
                        
                        if captureSession.canAddOutput(sessionOutput){
                            
                            captureSession.addOutput(sessionOutput)
                            
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                            cameraView.layer.addSublayer(previewLayer)
                            
                            previewLayer.position = CGPoint(x: self.cameraView.frame.width / 2, y: self.cameraView.frame.height / 2)
                            previewLayer.bounds = cameraView.frame
                            
                            
                        }
                        captureSession.addOutput(movieOutput)
                        
                        captureSession.startRunning()
    
                    }
                    
                }
                catch{
                    
                    print("Error")
                }
                
            }
        }
        
    }
    func record(){
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
        let fileUrl = paths[0].appendingPathComponent("output.mov")
        try? FileManager.default.removeItem(at: fileUrl)
        print("Starting to record")
        movieOutput.startRecording(to: fileUrl, recordingDelegate: self)
        //  toggleFlash(devices: devices)
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + self.recordTime) {
            print("stopping: waited \(self.recordTime)")
            self.movieOutput.stopRecording()
        }
    }
    

    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        print("FINISHED \(error)")
        // save video to camera roll
 
    }
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if error == nil {
            print("saving")
            UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, nil, nil, nil)
            present(MainScreen(), animated: true)
        }
        
    }
    func toggleFlash(devices: [AVCaptureDevice]) {
        for device in devices {
        if (device.hasTorch) {
            
            try? device.lockForConfiguration()
            try? device.setTorchModeOn(level: 1.0)
            
            print("Toggling Flash at \(NSDate().timeIntervalSince1970)")
            if device.isTorchActive {
                device.torchMode = AVCaptureDevice.TorchMode.off
            }
            else{
                 device.torchMode = AVCaptureDevice.TorchMode.off
            }
     
            device.unlockForConfiguration()
        }
        }
    }
    @objc func _toggleFlash() {
        let devices = AVCaptureDevice.devices()
        if !shouldRecord {
            toggleFlash(devices: devices)
        }
        
    }

    @objc func updateTimer(){
        flashCount += 1;
        print("Incremented Timer at at \(NSDate().timeIntervalSince1970)")
        if(flashCount >= recordCountdown + 1 ){
            print("Done countdown")
            textTimer.invalidate();
            flashTimer.invalidate();
            shouldRecord = true
            record();
            countdownLabel.text = "🔴";
            countdownLabel.font = UIFont(name: "Helvetica", size: 25)
            countdownLabel.center = CGPoint(x: view.frame.width*0.10, y: view.frame.width*0.10)

            return;
        }
        countdownLabel.text = String(Int(countdownLabel.text!)!-1);
    }
    
}

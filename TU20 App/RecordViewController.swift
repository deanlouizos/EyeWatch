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
    
    var cameraView: UIView!
    
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var movieOutput = AVCaptureMovieFileOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    override func viewWillAppear(_ animated: Bool) {
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
                        
                        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                        
                        let fileUrl = paths[0].appendingPathComponent("output.mov")
                        try? FileManager.default.removeItem(at: fileUrl)
                        movieOutput.startRecording(to: fileUrl, recordingDelegate: self)
                        
                        //
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            print("stopping")
                            self.movieOutput.stopRecording()
                        }
                        
                    }
                    
                }
                catch{
                    
                    print("Error")
                }
                
            }
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
        }
        
    }
    
}

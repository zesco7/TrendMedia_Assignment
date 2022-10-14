//
//  BackupViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/10/14.
//

import UIKit
import Zip
import RealmSwift

class BackupViewController: UIViewController {
    static var identifier = "BackupViewController"
    
    @IBOutlet weak var backupButton: UIButton!
    @IBOutlet weak var restorationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        buttonAttribute()
    }
    
    func buttonAttribute() {
        backupButton.setTitle("백업하기", for: .normal)
        restorationButton.setTitle("복구하기", for: .normal)
        backupButton.backgroundColor = .orange
        restorationButton.backgroundColor = .yellow
    }
    
    func showActivityViewController() {
        //ActivityViewController에 추가할 백업파일의 링크를 만들어줘야함
        guard let path = documentDirectoryPath() else {
            showAlert(alertTitle: "도큐먼트 위치에 오류가 있습니다", alertMessage: "")
            return
        }
        //ShoppingList.zip로 저장된 파일의 경로를 url타입으로 변환
        //ActivityViewController 아이템을 링크로 저장(fileName과 다르게 appendingPathComponent는 확장자명까지 작성)
        let backupFileURL = path.appendingPathComponent("ShoppingList.zip")
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        var urlPaths = [URL]() //백업할 파일의 url경로를 저장할 빈배열 생성
        
        //1.도큐먼트 위치 경로 + 백업파일 유무 확인
        guard let path = documentDirectoryPath() else {
            showAlert(alertTitle: "도큐먼트 위치에 오류가 있습니다", alertMessage: "")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm")
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlert(alertTitle: "백업할 파일이 없습니다", alertMessage: "")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!) //백업할 파일의 url경로를 빈배열에 저장
        
        //2.압축
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "ShoppingList") //백업할 파일경로정보를 압축
            print("Archive Location: \(zipFilePath)")
            showActivityViewController() //압축에 성공했을때만 ActivityViewController 실행
        } catch {
            showAlert(alertTitle: "압축을 실패했습니다", alertMessage: "")
        }
    }
    
    @IBAction func restorationButtonClicked(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true)
    }
}

extension BackupViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        //선택할 파일 링크 유무 체크: 링크있으면 selectedFileURL 프로퍼티에 저장
        guard let selectedFileURL = urls.first else {
            showAlert(alertTitle: "선택한 파일을 찾을 수 없습니다", alertMessage: "")
            return
        }
        
        //선택한 파일을 저장할 경로 유무 체크
        guard let path = documentDirectoryPath() else {
            showAlert(alertTitle: "도큐먼트 위치에 오류가 있습니다", alertMessage: "")
            return
        }
        
        //selectedFileURL.lastPathComponent로 저장된 파일 링크 생성
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) { //도큐먼트에 파일이 있으면(복구시도 2회 이상) 바로 압축해제
            //let fileURL = path.appendingPathComponent("ShoppingList")
            do {
                try Zip.unzipFile(sandboxFileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("fileOutputHandler: \(unzippedFile)")
                    self.showAlertWithClosure(alertTitle: "복구가 완료되었습니다", alertMessage: "") {
                        //self.dismiss(animated: true)
                        self.changeRootView()
                    }
                })
            } catch {
                showAlert(alertTitle: "압축해제에 실패했습니다.", alertMessage: "")
            }
        } else { //도큐먼트에 파일이 없으면(첫번째 복구시도) 백업파일 받아오고 압축해제
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                try Zip.unzipFile(sandboxFileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("fileOutputHandler: \(unzippedFile)")
                    self.showAlertWithClosure(alertTitle: "복구가 완료되었습니다", alertMessage: "") {
                        //self.dismiss(animated: true)
                        self.changeRootView()
                    }
                })
            } catch {
                showAlert(alertTitle: "압축해제에 실패했습니다.", alertMessage: "")
            }
        }
    }
}

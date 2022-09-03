//
//  SceneDelegate.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/08/31.
//

import UIKit

/*질문
 -. UserDefaults.standard.set(false, forKey: "First")을 SceneDelegate 파일이 아닌 다른 파일에 배치해야 하는 이유?
 */

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //true이면 ViewController, false면 SearchTableViewController 불러오기
        UserDefaults.standard.set(false, forKey: "First") //SceneDelegate 파일이 아닌 다른 파일에 배치해야 한다.
    
        guard let scene = (scene as? UIWindowScene) else { return } //scene은 현재 화면에 보이는 부분을 의미함
        window = UIWindow(windowScene: scene)
        
        if UserDefaults.standard.bool(forKey: "First") {
            let sb = UIStoryboard(name: "Trend", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            window?.rootViewController = vc //윈도우에 뷰컨트롤러를 루트뷰로 사용하겠다
        } else {
            let sb = UIStoryboard(name: "Search", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "SearchTableViewController") as! SearchTableViewController
            //window?.rootViewController = vc
            window?.rootViewController = UINavigationController(rootViewController: vc) //네비게이션 컨트롤러 추가된 vc 표시 가능
        }
        window?.makeKeyAndVisible() //rootViewController인 vc를 시작화면에 보여줌
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


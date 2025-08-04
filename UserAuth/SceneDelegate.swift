

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        
//        let window = UIWindow(windowScene: windowScene)
//        let userCache = UserCache()
//        let rootVC: UIViewController
//        
////        if userCache.getCurrentUser() != nil {
////            // ✅ User is already logged in
////            rootVC = MainAppViewController()
////        } else {
////            let loginVC = LoginViewController()
////            rootVC = UINavigationController(rootViewController: loginVC)
////        }
//        
//        if userCache.getCurrentUser() != nil {
//            rootVC = MainAppViewController()
//        } else {
//            let loginVC = LoginViewController()
//            rootVC = UINavigationController(rootViewController: loginVC)
//        }
//
//        
//        window.rootViewController = rootVC
//        self.window = window
//        window.makeKeyAndVisible()
//    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let userCache = UserCache()
        let rootVC: UIViewController
        
        if let _ = userCache.getCurrentUser() {
            // User is logged in → go to main app
            rootVC = MainAppViewController()
        } else {
            // No logged-in user → go to login
            let loginVC = LoginViewController()
            rootVC = UINavigationController(rootViewController: loginVC)
        }
        
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }


}


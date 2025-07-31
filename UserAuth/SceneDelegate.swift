

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let userCache = UserCache()
        let rootVC: UIViewController
        
        if userCache.getUser() != nil {
            // User already logged in, show main app screen (create MainAppViewController)
            rootVC = MainAppViewController() // You create this placeholder in /View folder
        } else {
            // Show login flow inside navigation controller
            let loginVC = LoginViewController()
            rootVC = UINavigationController(rootViewController: loginVC)
        }
        
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }
}


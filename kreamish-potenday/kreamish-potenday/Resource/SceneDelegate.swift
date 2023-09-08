
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var statusBarView = UIView()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        statusBarView.frame =  window?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
        
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light // 라이트모드만 지원하기
        }
    }

    


}


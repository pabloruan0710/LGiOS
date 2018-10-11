//
//  AppDelegate.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 10/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // login google setup
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        setRootViewController()
        return true
    }
    
    func setRootViewController(){
        let navigation : UINavigationController!
        let realm = try! Realm()
        if let _ = realm.objects(Usuario.self).filter("logado = true").first{
            let vcHome = HomeViewController()
            vcHome.title = "Atividades"
            navigation = UINavigationController(rootViewController: vcHome)
        }else{
            let vcLogin = LoginViewController()
            vcLogin.title = "Login"
            navigation = UINavigationController(rootViewController: vcLogin)
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    // MARK: Google Login Firebase
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func alert(title:String, message:String?){
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let _ = error {
            self.alert(title: "Atenção", message:"Erro ao efetuar login, tente novamente. "+(error?.localizedDescription ?? ""))
            return // error login google
        }
        
        guard let auth = user.authentication else {
            self.alert(title: "Atenção", message:"Dados de autenticação não fornecidos pelo provedor de serviços, tente novamente.")
            return // user login without authentication
        }
        
        let credenciais = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credenciais) { (result, error) in
            if (error != nil){
                self.alert(title: "Atenção", message:"Erro ao efetuar login, tente novamente. "+(error?.localizedDescription ?? ""))
                return
            }
            self.alert(title: "Tudo Certo", message:"Login Realizado.")
            
            let usuario : Usuario = Usuario()
            usuario.logado = true
            
            if let name = result?.user.displayName { usuario.nome = name }
            if let email = result?.user.email { usuario.email = email }
            
            let realm = try! Realm()
            try! realm.write({
                realm.create(Usuario.self, value: usuario, update: true)
            })
            demoData()
            self.setRootViewController()
        }
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


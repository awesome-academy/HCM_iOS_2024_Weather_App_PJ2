//
//  AppDelegate.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import UIKit
import RxSwift
import RxCocoa

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let assembler: Assembler = DefaultAssembler()
    var disposeBag = DisposeBag()

    // MARK: - Triggers
    private let deleteCurrentWeatherTrigger = PublishSubject<Void>()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        bindViewModel(window: window)
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        deleteCurrentWeatherTrigger.onNext(())
    }
}

extension AppDelegate {
    func bindViewModel(window: UIWindow) {
        let viewModel: AppViewModel = assembler.resolve(window: window)
        let input = AppViewModel.Input(
                    loadTrigger: .just(()),
                    deleteWeatherCurrentTrigger: deleteCurrentWeatherTrigger.asDriverOnErrorJustComplete())
        
        _ = viewModel.transform(input: input, disposeBag: disposeBag)
    }
}


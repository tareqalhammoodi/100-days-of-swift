//
//  ActionViewController.swift
//  Extension
//
//  Created by Tareq Alhammoodi on 24.08.2023.
//

import UIKit
import MobileCoreServices

struct Scripts: Codable {
    var name: String!
    let url: String!
    let script: String!
}

protocol ActionViewControllerDelegate: AnyObject {
    func loadScript(fromScript loadedScript: String)
    func deleteScript(idx scriptIndex: IndexPath)
    func renameScript(newName name: String, idx: IndexPath)
    func getScripts() -> [Scripts]
}

class ActionViewController: UIViewController {
    
    var pageTitle = ""
    var pageURL = ""
    var savedScripts = [Scripts]()
    var currentPage: String?

    @IBOutlet var script: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Options", style: .plain, target: self, action: #selector(showOptions))
        let defaults = UserDefaults.standard
        if let scripts = defaults.object(forKey: "Scripts") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                savedScripts = try jsonDecoder.decode([Scripts].self, from: scripts)
            } catch {
                print("Failed to load scripts.")
            }
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDict = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDict[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                        self?.currentPage = self?.pageURL
                    }
                }
            }
        }
    }

    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text!]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedScript = try? jsonEncoder.encode(savedScripts) {
            let defaults = UserDefaults.standard
            defaults.set(savedScript, forKey: "Scripts")
        } else {
            print("Failed to save new script.")
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        script.scrollIndicatorInsets = script.contentInset
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
    @objc func showOptions() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Show Page Title Script", style: .default, handler: { [weak self] _ in
            let item = NSExtensionItem()
            let argument: NSDictionary = ["customJavaScript": "alert(document.title);"]
            let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
            let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
            item.attachments = [customJavaScript]
            self?.extensionContext?.completeRequest(returningItems: [item])
        }))
        ac.addAction(UIAlertAction(title: "Save New Script", style: .default, handler: { [weak self] _ in
            if self?.script.text == "" {
                let alert = UIAlertController(title: "Error!", message: "Please make sure you write a script before saving it.", preferredStyle: UIAlertController.Style.alert)
                if let vc = self?.view?.window?.rootViewController {
                    vc.present(alert, animated: true, completion: nil)
                }
                print("nil")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5) {
                    alert.dismiss(animated: true, completion: nil)
                }
            } else {
                print("saving")
                let alert = UIAlertController(title: "Name the new Script", message: nil, preferredStyle: .alert)
                alert.addTextField()
                alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak alert] _ in
                    guard let newName = alert?.textFields?[0].text else { return }
                    let newScript = Scripts(name: newName, url: self?.currentPage!, script: self?.script.text)
                    self?.savedScripts.append(newScript)
                    self?.save()
                    let alert = UIAlertController(title: "The Script has been saved.", message: nil, preferredStyle: UIAlertController.Style.alert)
                    if let vc = self?.view?.window?.rootViewController {
                        vc.present(alert, animated: true, completion: nil)
                    }
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                        alert.dismiss(animated: true, completion: nil)
                    }
                })
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self?.present(alert, animated: true)
            }
        }))
        ac.addAction(UIAlertAction(title: "Show Saved Scripts", style: .default, handler: { [weak self] _ in
            let tableView = TableViewController()
            tableView.scripts = self?.savedScripts ?? [Scripts]()
            tableView.delegate = self
            self?.navigationController?.pushViewController(tableView, animated: true)
        }))
        present(ac, animated: true, completion: nil)
    }

}

extension ActionViewController: ActionViewControllerDelegate {
    
    func loadScript(fromScript loadedScript: String) {
        script.text = loadedScript
    }
    
    func deleteScript(idx scriptIndex: IndexPath) {
        savedScripts.remove(at: scriptIndex.row)
        save()
    }
    
    func renameScript(newName name: String, idx: IndexPath) {
        savedScripts[idx.row].name = name
        save()
    }
    
    func getScripts() -> [Scripts] {
        return savedScripts
    }
    
}

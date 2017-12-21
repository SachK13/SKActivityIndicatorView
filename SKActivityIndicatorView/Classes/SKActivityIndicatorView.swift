//
//  SKActivityIndicatorView.swift
//  SKActivityIndicatorView
//
//  Created by Sachin on 22/12/17.
//

import Foundation
import UIKit

public class SKActivityIndicator: NSObject {
    
    // MARK: - Custom Properties
    var window: UIWindow?
    var backgroundView: UIView?
    var activityIndicatorView: UIToolbar?
    var spinnerContainerView: UIView?
    var statusLabel: UILabel?
    
    
    /// ActivityIndicator Customization
    fileprivate var statusLabelFont        : UIFont                 = UIFont.systemFont(ofSize  : 16, weight  : .semibold)
    fileprivate var statusTextColor        : UIColor                = UIColor.black
    fileprivate var spinnerColor           : UIColor                = UIColor.darkGray
    fileprivate var backgroundViewColor    : UIColor                = UIColor.init(red  : 0.0, green  : 0.0, blue  : 0.0, alpha  : 0.2)
    fileprivate var activityIndicatorStyle : ActivityIndicatorStyle = .defaultSpinner
    fileprivate var activityIndicatorTranslucency : UIBlurEffectStyle           = .extraLight
    
    
    // MARK: - Singleton Accessors
    fileprivate static let shared: SKActivityIndicator = {
        let instance = SKActivityIndicator()
        // Do any additional Configuration
        return instance
    }()
    
    // MARK: - Initialization
    private override init() {
        super.init()
        let delegate: UIApplicationDelegate = UIApplication.shared.delegate!
        if let windowObj = delegate.window {
            window = windowObj
        } else {
            window = UIApplication.shared.keyWindow!
        }
        statusLabel = nil
        backgroundView = nil
        spinnerContainerView = nil
        activityIndicatorView = nil
    }
    
    // MARK: - Display Methods
    /**
     Display Activity-Indicator without status message
     
     */
    public static func show() {
        DispatchQueue.main.async {
            self.shared.configureActivityIndicator(withStatusMessage: "", isUserInteractionEnabled: true)
        }
    }
    
    /**
     Display Activity-Indicator with status message
     
     - parameter message : Status message display with activity indicator
     */
    public static func show(_ message: String) {
        DispatchQueue.main.async {
            self.shared.configureActivityIndicator(withStatusMessage: message, isUserInteractionEnabled: true)
        }
    }
    
    /**
     Display Activity-Indicator with status message and user interaction enabled or disabled.
     The "userInteractionStatus" allows to enable or disable user interaction with other UI elements while Activity-Indicator being displayed.
     
     - parameter message : Status message display with activity indicator
     - parameter userInteractionStatus : Set true to enble user interaction and false to disable
     */
    public static func show(_ message: String, userInteractionStatus: Bool) {
        DispatchQueue.main.async {
            self.shared.configureActivityIndicator(withStatusMessage: message, isUserInteractionEnabled: userInteractionStatus)
        }
    }
    
    
    // MARK: - Hide Methods
    /**
     Hide Activity-Indicator
     
     */
    public static func dismiss() {
        DispatchQueue.main.async {
            self.shared.hideActivityIndicator()
        }
    }
    
    
    // MARK: - Configure Activity Indicator
    fileprivate func configureActivityIndicator(withStatusMessage message: String, isUserInteractionEnabled userInteractionStatus: Bool) {
        
        /// Setup Activity Indicator View
        if activityIndicatorView == nil {
            activityIndicatorView = UIToolbar(frame: CGRect.zero)
            activityIndicatorView!.layer.cornerRadius = 8
            activityIndicatorView!.layer.masksToBounds = true
            activityIndicatorView!.isTranslucent = true
            registerForKeyboardNotificatoins()
        }
        
        /// Setup Spinner Container View
        if spinnerContainerView == nil {
            let spinnerViewFrame = CGRect(x: 0, y: 0, width: 37, height: 37)
            spinnerContainerView = UIView(frame: spinnerViewFrame)
            spinnerContainerView!.backgroundColor = UIColor.clear
        }
        
        /// Setup Spinner
        if spinnerContainerView != nil {
            
            spinnerContainerView?.removeFromSuperview()
            spinnerContainerView = nil
            
            let spinnerViewFrame = CGRect(x: 0, y: 0, width: 37, height: 37)
            spinnerContainerView = UIView(frame: spinnerViewFrame)
            spinnerContainerView!.backgroundColor = UIColor.clear
            
            let viewLayer = spinnerContainerView!.layer
            let animationRectsize = CGSize(width: 37, height: 37)
            SKActivityIndicatorStyle.createSpinner(in: viewLayer, size: animationRectsize, color: spinnerColor, style: activityIndicatorStyle)
        }
        
        if spinnerContainerView?.superview == nil {
            activityIndicatorView!.addSubview(spinnerContainerView!)
        }
        
        if activityIndicatorView?.superview == nil && userInteractionStatus == false {
            backgroundView = UIView.init(frame: window!.frame)
            backgroundView!.backgroundColor = backgroundViewColor
            window!.addSubview(backgroundView!)
            backgroundView!.addSubview(activityIndicatorView!)
        } else {
            window!.addSubview(activityIndicatorView!)
        }
        
        /// Setup Status Message Label
        if statusLabel == nil {
            statusLabel                     = UILabel.init(frame : CGRect.zero)
            statusLabel!.font               = statusLabelFont
            statusLabel!.textColor          = statusTextColor
            statusLabel!.backgroundColor    = UIColor.clear
            statusLabel!.textAlignment      = .center
            statusLabel!.baselineAdjustment = .alignCenters
            statusLabel!.numberOfLines      = 0
        }
        if statusLabel?.superview == nil {
            activityIndicatorView!.addSubview(statusLabel!)
        }
        statusLabel?.text = message
        statusLabel?.isHidden = (message.count == 0) ? true : false
        
        /// Setup Activity IndicatorView Size & Position
        configureActivityIndicatorSize()
        configureActivityIndicatorPosition(notification: nil)
        showActivityIndicator()
    }
    
    
    
    // MARK: - Configure ActivityIndicator
    fileprivate func configureActivityIndicatorSize() {
        
        var rectLabel: CGRect = CGRect.zero
        var widthHUD: CGFloat = 100
        var heightHUD: CGFloat = 100
        
        if let statusMessage =  statusLabel?.text, statusMessage.count != 0 {
            let attributes = [NSAttributedStringKey.font: statusLabel?.font]
            let options: NSStringDrawingOptions = [.usesFontLeading, .truncatesLastVisibleLine, .usesLineFragmentOrigin]
            rectLabel = (statusLabel?.text?.boundingRect(with: CGSize(width: 200, height: 300), options: options, attributes: attributes as [NSAttributedStringKey : AnyObject], context: nil))!
            widthHUD = rectLabel.size.width + 40
            heightHUD = rectLabel.size.height + 75
            if widthHUD < 100 {
                widthHUD = 100
            }
            if heightHUD < 100 {
                heightHUD = 100
            }
            rectLabel.origin.x = (widthHUD - rectLabel.size.width) / 2
            rectLabel.origin.y = (heightHUD - rectLabel.size.height) / 2 + 25
        }
        
        activityIndicatorView?.bounds = CGRect(x: 0, y: 0, width: widthHUD, height: heightHUD)
        
        let imageX: CGFloat = widthHUD/2
        let imageY: CGFloat = (statusLabel!.text?.count == 0) ? heightHUD/2 : 36
        spinnerContainerView!.center = CGPoint(x: imageX, y: imageY)
        statusLabel?.frame = rectLabel
    }
    
    // MARK: - ActivityIndicator Position
    @objc fileprivate func configureActivityIndicatorPosition(notification: NSNotification?) {
        var keyboardHeight: CGFloat = 0.0
        
        if notification != nil {
            if let keyboardFrame: NSValue = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                if (notification!.name == NSNotification.Name.UIKeyboardWillShow || notification!.name == NSNotification.Name.UIKeyboardDidShow) {
                    keyboardHeight = keyboardRectangle.height
                }
            }
        } else {
            keyboardHeight = 0.0
        }
        let screen: CGRect = UIScreen.main.bounds
        let center: CGPoint = CGPoint(x: screen.size.width/2, y: (screen.size.height-keyboardHeight)/2)
        
        UIView.animate(withDuration: 0, delay: 0, options: [.allowUserInteraction], animations: {
            self.activityIndicatorView?.center = CGPoint(x: center.x, y: center.y)
        }, completion: nil)
        
        if backgroundView != nil {
            backgroundView!.frame = window!.frame
        }
    }
    
    // MARK: - Show
    fileprivate func showActivityIndicator() {
        if activityIndicatorView != nil {
            activityIndicatorView!.alpha = 0
            UIView.animate(withDuration: 0.1, animations: {
                self.activityIndicatorView?.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
                self.activityIndicatorView?.alpha = 1
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.2, animations: {() -> Void in
                    self.activityIndicatorView?.transform = CGAffineTransform.identity
                }, completion: nil)
            })
        }
    }
    
    // MARK: - Hide
    fileprivate func hideActivityIndicator() {
        if activityIndicatorView != nil && activityIndicatorView?.alpha == 1 {
            UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
                self.activityIndicatorView?.transform = CGAffineTransform.identity.scaledBy(x: 0.7, y: 0.7)
                self.activityIndicatorView?.alpha = 0
            }, completion: { (succes) in
                self.activityIndicatorView?.alpha = 0
                self.deallocateActivityIndicator()
            })
        }
    }
    
    
    // MARK: - Deallocate ActivityIndicator
    fileprivate func deallocateActivityIndicator() {
        NotificationCenter.default.removeObserver(self)
        statusLabel?.removeFromSuperview()
        statusLabel = nil
        spinnerContainerView?.removeFromSuperview()
        spinnerContainerView = nil
        activityIndicatorView?.removeFromSuperview()
        activityIndicatorView = nil
        backgroundView?.removeFromSuperview()
        backgroundView = nil
    }
    
    
    // MARK: - Keyboard Notifications
    fileprivate func registerForKeyboardNotificatoins() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.configureActivityIndicatorPosition), name: .UIApplicationDidChangeStatusBarOrientation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.configureActivityIndicatorPosition), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.configureActivityIndicatorPosition), name: .UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.configureActivityIndicatorPosition), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.configureActivityIndicatorPosition), name: .UIKeyboardDidShow, object: nil)
    }
    
    
    // MARK: - Customization Methods
    public static func statusLabelFont(_ font: UIFont) {
        self.shared.statusLabelFont = font
    }
    
    public static func statusTextColor(_ color: UIColor) {
        self.shared.statusTextColor = color
    }
    
    public static func spinnerColor(_ color: UIColor) {
        self.shared.spinnerColor = color
    }
    
    public static func spinnerStyle(_ spinnerStyle: ActivityIndicatorStyle) {
        self.shared.activityIndicatorStyle = spinnerStyle
    }
}


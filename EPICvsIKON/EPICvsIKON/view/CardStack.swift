//
//  CardStack.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/2/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//

import UIKit

protocol CardStackDelegate: class {
    func cardInterested(resort: Resort)
    func cardNotInterested(resort: Resort)
}

class CardStack: UIView {
    var cards: [CardView] = []
    weak var delegate: CardStackDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        seedResorts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        seedResorts()
    }
    
    func seedResorts() {
        for index in 0...20 {
            if let resort = DataStore.instance.resortAtIndex(index) {
                addResort(resort: resort)
            }
        }
    }
    
    func addResort(resort: Resort) {
        let card = CardView()
        card.resort = resort
        self.addSubview(card)
        
        card.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: card, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: card, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: card, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: card, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        cards.append(card)
        self.sendSubview(toBack: card)
        
        setupTransforms(percentCompletion: 0)
        
        setUpGestures()
    }
    
    func setupTransforms(percentCompletion: Double) {
        let translationDelta: CGFloat = 6
        for (i, card) in cards.enumerated() {
            if i == 0 { continue; }
            
            var translationA, rotationA, scaleA: CGFloat!
            var translationB, rotationB, scaleB: CGFloat!
            
            if i % 2 == 0 {
                translationA = CGFloat(i)*translationDelta
                rotationA = CGFloat(Double.pi)/100*CGFloat(i)
                
                translationB = -CGFloat(i-1)*translationDelta
                rotationB = -CGFloat(Double.pi)/100*CGFloat(i-1)
            } else {
                translationA = -CGFloat(i)*translationDelta
                rotationA = -CGFloat(Double.pi)/100*CGFloat(i)
                
                translationB = CGFloat(i-1)*translationDelta
                rotationB = CGFloat(Double.pi)/100*CGFloat(i-1)
            }
            
            scaleA = 1-CGFloat(i)*0.05
            scaleB = 1-CGFloat(i-1)*0.05
            
            let translation = translationA*(1-CGFloat(percentCompletion))+translationB*CGFloat(percentCompletion)
            let rotation = rotationA*(1-CGFloat(percentCompletion))+rotationB*CGFloat(percentCompletion)
            let scale = scaleA*(1-CGFloat(percentCompletion))+scaleB*CGFloat(percentCompletion)
            
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: translation, y: 0)
            transform = transform.rotated(by: rotation)
            transform = transform.scaledBy(x: scale, y: scale)
            
            card.transform = transform
        }
    }
    
    func setUpGestures() {
        for card in cards {
            let gestures = card.gestureRecognizers ?? []
            for gesture in gestures {
                card.removeGestureRecognizer(gesture)
            }
        }
        
        if let firstCard = cards.first {
            firstCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(CardStack.pan(gesture:))))
        }
    }
    
    @objc func pan(gesture: UIPanGestureRecognizer) {
        let card = gesture.view! as! CardView
        let translation = gesture.translation(in: self)
        
        var percent = translation.x / self.bounds.midX
        percent = min(percent, 1)
        percent = max(percent, -1)
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 1, options: [], animations: { () -> Void in
            self.setupTransforms(percentCompletion: abs(Double(percent)))
        }, completion: nil)
        
        if percent > 0.2 && gesture.state == .ended {
            // Important call delegate
            self.delegate?.cardInterested(resort: card.resort)
        } else if percent < -0.2 && gesture.state == .ended {
            self.delegate?.cardNotInterested(resort: card.resort)
        }
        
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: translation.x, y: translation.y)
        transform = transform.rotated(by: CGFloat(Double.pi)*percent/30)
        
        card.transform = transform
        
        if gesture.state == .ended {
            let velocity = gesture.velocity(in: self)
            let percentBlock = {
                self.cards.remove(at: self.cards.index(of: card)!)
                self.setUpGestures()
                card.removeGestureRecognizer(card.gestureRecognizers![0])
                
                let slope = translation.y / translation.x
                let distance = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
                
                let y = distance*sqrt(1+1/(slope*slope))
                let x = y / slope
                
                let normVelX = velocity.x / x
                let normVelY = velocity.y / y
                
                UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: normVelX, options: [], animations: { () -> Void in
                    card.center.x = x
                }, completion: nil)
                
                UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: normVelY, options: [], animations: { () -> Void in
                    card.center.y = y
                }, completion: nil)
            }
            
            if percent > 0.2 {
                percentBlock()
            } else if percent < -0.2 {
                percentBlock()
            } else {
                let normVelX = -velocity.x / translation.x
                let normVelY = -velocity.y / translation.y
                
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: { () -> Void in
                    }, completion: nil)
                
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: normVelX, options: [], animations: { () -> Void in
                    
                    var transform = CGAffineTransform.identity
                    transform = transform.translatedBy(x: 0, y: translation.y)
                    card.transform = transform
                    }, completion: nil)
                
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: normVelY, options: [], animations: { () -> Void in
                    
                    var transform = CGAffineTransform.identity
                    transform = transform.translatedBy(x: 0, y: 0)
                    card.transform = transform
                    }, completion: nil)
            }
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 1, options: [], animations: { () -> Void in
                self.setupTransforms(percentCompletion: 0)
                }, completion: nil)
        }
    }
}

//
//  Animate.swift
//  Animate
//
//  Created by Alexandre on 12/12/2018.
//  Copyright © 2018 Animate. All rights reserved.
//

import Foundation
import UIKit



public struct Animation {
    public let duration: TimeInterval
    public let closure: (UIView) -> Void
}

extension Animation {
    //MARK:- Fades
    static func fadeIn(duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, closure: {
            $0.alpha = 1
        })
    }
    static func fadeOut(duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, closure: {
            $0.alpha = 0
        })
    }
    
    //MARK:- Movement
    static func rotate(duration: TimeInterval = 0.3, rotationAngle:CGFloat) -> Animation {
        return Animation(duration: duration, closure: {
            let transform = CGAffineTransform(rotationAngle: rotationAngle)
            $0.transform = transform
        })
    }
}

public extension UIView {
    enum AnimationMode {
        case sequence
        case parallel
    }
    func animate(_ animations: [Animation], mode: AnimationMode) -> Void {
        switch mode {
        case .sequence:
            animateInSequence(animations)
        case .parallel:
            animateInParallel(animations)
        }
    }

    private func animateInSequence(_ animations: [Animation]) -> Void {
        guard !animations.isEmpty else {
            return
        }
        
        var animations = animations
        let animation = animations.removeFirst()
        
        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        } , completion: { (_) in
            self.animateInSequence(animations)
        })
    }
    
    private func animateInParallel(_ animations: [Animation]) -> Void {
        guard !animations.isEmpty else {
            return
        }
        /*
        for animation in animations {
            <#code#>
        }
        /*
        var animations = animations
        let animation = animations.removeFirst()
        
        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        } , completion: { (_) in
            self.animateInSequence(animations)
        })
 */
    }
}









